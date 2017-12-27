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

struct GPass {
    float4 Diffuse  : SV_Target0;
    float4 Depth    : SV_Target1;
    float4 Normal   : SV_Target2;
    float4 WorldPos : SV_Target3;
};

#region Settings
static const float3 waterColour = float3(.604, .867, .851); //float3(0., 145., 255.) / 255; //
static const float fresnelReflective = .5;
static const float edgeSoftness = 1.;
static const float minBlueness = .4;
static const float maxBlueness = .75;
static const float murkyDepth = 1.;
static const float distStrength = .02;
#endregion

#region Samplers / Textures
Texture2D _Reflection           : register(t0);
SamplerState _ReflectionSampler : register(s0);

Texture2D _Refraction           : register(t1);
SamplerState _RefractionSampler : register(s1);

Texture2D _Depth                : register(t2);
SamplerState _DepthSampler      : register(s2);

Texture2D _CausticDistortion     : register(t3);
SamplerState _CausDistortionSamp : register(s3);

Texture2D _NormalDistortion      : register(t4);
SamplerState _NormDistortionSamp : register(s4);

Texture2D _FoamDistortion        : register(t5);
SamplerState _FoamDistortionSamp : register(s5);
#endregion

#region Uniforms
float2 _NearFar, _Texel;
#endregion

#region Functions
float3 applyMurkiness2(float3 refractColour, float waterDepth) {
    return lerp(refractColour, waterColour, min(waterDepth, 1.));
}

float3 applyMurkiness(float3 refractColour, float waterDepth) {
    float f = smoothstep(0., murkyDepth, waterDepth);
    float v = minBlueness + f * (maxBlueness - minBlueness);
    return lerp(refractColour, waterColour, v);
}

float toLinearDepth(float zDepth) {
    float near = _NearFar.x;
    float far = _NearFar.y;
    return 2. * near * far / (far + near - (2. * zDepth - 1.) * (far - near));
}

float calcWaterDepth(float2 uv, PS In) {
    float depth = _Depth.Sample(_DepthSampler, uv).r;
    return toLinearDepth(depth) * 2.;// - toLinearDepth(In.ClipSpaceGrid.z);
}

float calcFresnel(PS In) {
    float3 vVec = (In.ToCamVec);
    float3 N = normalize(In.Normal) * 2. - 1.;
    float f = pow(dot(vVec, N), fresnelReflective);
    return clamp(f, 0., 1.);
}

float2 clipCoordsToUV(float4 Clip) {
    float2 ndc = (Clip.xy / Clip.w);
    return clamp(ndc * .5 + .5, .002, .998);
}
#endregion

GPass main(PS In) {
    // Get UV from Clip space
    float2 UVGrid = clipCoordsToUV(In.ClipSpaceGrid);
    
    // Get distorion
    float Foam = _FoamDistortion.Sample(_FoamDistortionSamp, In.ClipSpaceReal).r;
    float Caust = _CausticDistortion.Sample(_CausDistortionSamp, In.ClipSpaceReal).r;
    float Offset = Caust + Foam;
    
    float OffsetT = Offset * distStrength;
    
    // Calculate depth and texcoords
    float2 RefractUV = float2(UVGrid.x, 1. - UVGrid.y);
    float2 ReflectUV = UVGrid + (OffsetT * 2. - 1.);
    float waterDepth = calcWaterDepth(RefractUV, In);
    
    // Get colors
    float3 RefractColor = _Refraction.Sample(_RefractionSampler, RefractUV).rgb;
    float3 ReflectColor = _Reflection.Sample(_ReflectionSampler, ReflectUV).rgb;
    float3 NormalMapped = _NormalDistortion.Sample(_NormDistortionSamp, In.ClipSpaceReal).rgb;
    NormalMapped = normalize(float3(NormalMapped.r * 2. - 1., NormalMapped.g * 2. - 1., NormalMapped.b));
    
    // Adjust some values
    RefractColor = applyMurkiness2(RefractColor, waterDepth);
    ReflectColor = lerp(ReflectColor, waterColour, minBlueness);
    
    // Output
    float a = clamp(waterDepth / edgeSoftness, 0., 1.);
    float3 final = lerp(ReflectColor, RefractColor, .5); //calcFresnel(In)
    
    #region DELETE
    //final = _Refraction.Sample(MeshTextureSampler, RefractUV).rgb;
    //final * In.Diffuse + In.Specular
    //final = float3(waterDepth, waterDepth, waterDepth) / 32000.;
    /*float x = waterDepth / 32000.;
    final = float3(x, x, x); //(In.Normal + 1.) * .5;
    */
    //final = _Refraction.Sample(MeshTextureSampler, RefractUV).rgb; //float3(RefractUV, 0.);
    //final = float3(waterDepth, waterDepth, waterDepth);
    #endregion
    
    GPass Out;
        Out.Diffuse  = float4((final + Caust + Foam * distStrength) * In.Diffuse + In.Specular /*(In.Normal + 1.) * .5*/, 1.);
        Out.Depth    = float4(In.Depth, In.Depth, In.Depth, 1.);
        Out.Normal   = float4(NormalMapped * .5 + .5, 1.);
        Out.WorldPos = float4(In.WorldPos, 1.);
    return Out;
}
