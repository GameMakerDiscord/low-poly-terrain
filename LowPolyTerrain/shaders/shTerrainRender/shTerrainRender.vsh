struct VS {
    float3 Position : POSITION0;
    float3 Normal   : NORMAL0;
    float3 Diffuse  : COLOR0;
};

struct PS {
    float4 Position : SV_Position0;
    float clp       : SV_ClipDistance0;
    nointerpolation float3 Diffuse  : TEXCOORD0;
    nointerpolation float3 Normal   : NORMAL0;
    float  Depth    : TEXCOORD1;
    float3 WorldPos : TEXCOORD2;
};

float4 _Clip;
float3 _LightDir, _LightColor;
float2 _LightBias;
float _Far;

// Lightning
float3 calcLight(VS In) {
    float3 N = normalize(mul(gm_Matrices[MATRIX_WORLD], float4(In.Normal, 0.)).xyz) * 2. - 1.;
    float b = max(dot(-_LightDir, N), 0.);
    return (_LightColor * _LightBias.x) + (b * _LightColor * _LightBias.y);
}

PS main(VS In) {
    PS Out;
        float4 WP = float4(In.Position, 1.); // Get current position
        float clp = dot(mul(gm_Matrices[MATRIX_WORLD], WP), _Clip);
        //clip(clp); // Apply clipping plane
        //float x = WP.z / 1000.;
        
        Out.Position = mul(gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION], WP);
        Out.Diffuse  = In.Diffuse * calcLight(In); // Out.Position.z / 3000.; // Color
        Out.clp      = clp;
        Out.Depth    = Out.Position.z / _Far;
        Out.Normal   = normalize(mul(gm_Matrices[MATRIX_WORLD], float4(In.Normal, 0.)).xyz);
        Out.WorldPos = normalize(mul(gm_Matrices[MATRIX_WORLD], WP));
    return Out;
}
