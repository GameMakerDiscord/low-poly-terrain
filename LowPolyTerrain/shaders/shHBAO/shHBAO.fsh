struct PS {
    float4 Position : SV_Position0;
    float2 Texcoord : TEXCOORD0;
};

#region Samplers
Texture2D<float> _Depth : register(t0);
//SamplerState _DepthSamp : register(s0);
SamplerState _DepthSamp {
    Filter = MIN_MAG_LINEAR_MIP_POINT;
    AddressU = Border;
    AddressV = Border;
    BorderColor = float4(1., 1., 1., 1e5f);
};

Texture2D _Normal        : register(t1);
SamplerState _NormalSamp : register(s1);

Texture2D<float2> _Noise : register(t2);
SamplerState _NoiseSamp  : register(s2);

Texture2D<float4> _WorldPos : register(t3);
SamplerState _WorldPosSamp  : register(s3);

Texture2D<float4> _Diffuse : register(t4);
SamplerState _DiffuseSamp  : register(s4);
#endregion

#region Uniforms
float2 _ScreenSize;
float4x4 _m_Proj, _m_InvProj, _m_InvView; // Matrices
#endregion

#region Functions
// Position to UV
float2 P2UV(float3 P) {
    float4 proj = mul(_m_Proj, float4(P, 1));
    proj /= proj.w;
    
    float2 UV = (proj.xy + 1.) / 2;
    UV.y = 1 - UV.y;
    
    return UV;
}

// Depth to Position
float3 D2P(float Depth, float2 UV) {
    float4 clipSpace = float4(UV * 2. - 1., Depth * 2. - 1, 1.);
    clipSpace.y = 1. - clipSpace.y;
    
    float4 viewSpace = mul(_m_InvProj, clipSpace);
    
    return mul(_m_Proj, viewSpace / viewSpace.w).xyz;
}

// Same, but overloaded
float3 D2P(float2 UV) {
    return _WorldPos.Sample(_WorldPosSamp, UV).rgb; //D2P(_Depth.Sample(_DepthSamp, UV), UV);
}

// 

#endregion

float4 main(PS In) : SV_Target {
    // AO settings
    const int nSampleDir = 6;
    const int nSampleRadius = 6;
    const float AORadius = .25;
    
    // Get some values
    float3 P = D2P(In.Texcoord);
    float3 n = normalize(cross(ddy(P), ddx(P))); //_Normal.Sample(_NormalSamp, In.Texcoord);
    float randOffset = _Noise.Sample(_NoiseSamp, In.Texcoord * _ScreenSize / 64.);
    float occlusion = .0f;
    
    // Sample in every direction
    for( int i = 0; i < nSampleDir; i++ ) {
        float theta = i * 6.2831 / nSampleDir + randOffset * 6.28;
        float3 dir  = normalize(float3(sin(theta), 0., cos(theta)));
        
        // tangent vector int the plane define by theta angle
        float3 T      = normalize(dir - dot(n, dir) * n);
        float  alphaT = atan(-T.y / length(T.xz));
        
        float alphaH = alphaT;
        float finalRadius = 0;
        float value = 0;
        
        // Find horizon angle
        for( int k = 1; k <= nSampleRadius; k++ ) {
            float radius  = k * AORadius/ nSampleRadius;
            float3 offset = radius * normalize(float3(T.x, 0, T.z));
            float3 S      = D2P(P2UV(P + k * offset)).xyz;
            float3 H      = S - P;
            float  h      = length(H);
            
            float ah = atan(-H.y / length(H.xz));
            
            if( ah > alphaH && h < AORadius ) {
                alphaH = ah;
                finalRadius = h;
                value = max(dot(normalize(H), n), 0);
            }
        }
        
        // Compute occlusion only if we are higher
        // than a certain bias
        if( alphaH - alphaT > 3.14 / 6. ) {
            // the value used is different from the paper of NVidia
            occlusion += (1. - finalRadius * finalRadius / (AORadius * AORadius)) * value;
        }
    }
    
    float access = pow(clamp(1 - occlusion / nSampleDir, 0, 1), 4);
    return float4(access, access, access, _Diffuse.Sample(_DiffuseSamp, In.Texcoord).a);// * _Diffuse.Sample(_DiffuseSamp, In.Texcoord);
}
