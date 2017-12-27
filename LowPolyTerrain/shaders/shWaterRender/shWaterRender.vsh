struct VS {
    float2 Position : POSITION0;
    float4 Indicies : TEXCOORD0;
    float2 Texcoord : TEXCOORD1;
};

struct PS {
    float4 Position      : SV_Position0;
    nointerpolation float3 Normal        : NORMAL0;
    float4 ClipSpaceGrid : TEXCOORD0;
    float4 ClipSpaceReal : TEXCOORD1;
    nointerpolation float3 ToCamVec      : TEXCOORD2;
    nointerpolation float3 Specular      : TEXCOORD3;
    nointerpolation float3 Diffuse       : TEXCOORD4;
    float  Depth         : TEXCOORD5;
    float3 WorldPos      : TEXCOORD6;
};

#region Constants / Settings
static const float PI = 3.1415926535897932384626433832795;

static const float waveLength = 10.;
static const float waveAmplitude = .5;
static const float specularReflectivity = .3;
static const float shineDamper = 5.;
static const float TextureRepeats = 1.;
#endregion

#region Uniforms
float _Height;
float3 _CamPos;
float _WaveTime;

float3 _LightDir, _LightColor;
float2 _LightBias;

float _Far;
#endregion

#region Functions
// Lightning
float3 calcSpecular(float3 toCam, float3 toLight, float3 Normal) {
    float3 refLD = reflect(-toLight, normalize(Normal) * 2. - 1.);
    float spec = dot(refLD, toCam);
    spec = pow(max(spec, 0.), shineDamper);
    return spec * specularReflectivity * _LightColor;
}

float3 calcDiffuse(float3 toLight, float3 N) {
    float b = max(dot(-toLight, normalize(N) * 2. - 1.), 0.);
    return (_LightColor * _LightBias.x) + (b * _LightColor * _LightBias.y);
}

// Other stuff
float3 calcNormal(float3 v0, float3 v1, float3 v2) {
    float3 tangent = v1 - v0;
    float3 bitangent = v2 - v0;
    return normalize(cross(tangent, bitangent));
}

float calcOffset(float x, float y) {
    float radX = (x / waveLength + _WaveTime) * 2. * PI;
    float radY = (y / waveLength + _WaveTime) * 2. * PI;
    return waveAmplitude * .5 * max(sin(radY) + cos(radX), cos(radY) + sin(radX));
}

float3 applyDistortion(float3 vert) {
    float3 distortion = float3(
        calcOffset(vert.x, vert.y), 
        calcOffset(vert.x, vert.y), 
        calcOffset(vert.x, vert.y)
    );
    
    return vert + distortion;
}
#endregion

PS main(VS In) {
    // Convert from [0, 1] to [-1, 1]
    In.Indicies *= 2.;
    In.Indicies--;
    
    // From [0, 1] to [-1, 1] = VAL * .5 + .5  = (VAL + 1) / 2
    // Vise versa             = VAL * 2 - 1    = (VAL * 2) - 1 (Reversed expression)
    
    PS Out;
        // Get verticies
        float3 curr = float3(In.Position.x, In.Position.y, _Height);
        float3 v1 = curr + float3(In.Indicies.x, In.Indicies.y, 0.);
        float3 v2 = curr + float3(In.Indicies.z, In.Indicies.w, 0.);
        
        // Transform vertex
        Out.ClipSpaceGrid = mul(gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION], float4(curr, 1.));
        
        // Get normal
        curr = applyDistortion(curr);
        v1 = applyDistortion(v1);
        v2 = applyDistortion(v2);
        float3 Normal = calcNormal(curr, v1, v2);
        
        // 
        float3 toLightVec = -normalize(_LightDir);
        
        // Fill data
        Out.Normal        = mul(gm_Matrices[MATRIX_WORLD], float4(Normal, 0.)).xyz;
        Out.Position      = mul(gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION], float4(curr, 1.));
        Out.ClipSpaceReal = float4(fmod(In.Texcoord * TextureRepeats + _WaveTime * waveAmplitude, 1.), 0., 1.);
        Out.ToCamVec      = normalize(_CamPos - curr);
        Out.Specular      = calcSpecular(Out.ToCamVec, toLightVec, Out.Normal);
        Out.Diffuse       = calcDiffuse(toLightVec, Out.Normal);
        Out.Depth         = Out.Position.z / _Far;
        Out.WorldPos      = normalize(mul(gm_Matrices[MATRIX_WORLD], float4(curr, 1.)));
    return Out;
}
