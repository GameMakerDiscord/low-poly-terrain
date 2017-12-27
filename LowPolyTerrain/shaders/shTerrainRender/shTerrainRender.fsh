struct PS {
    float4 Position : SV_Position0;
    float clp       : SV_ClipDistance0;
    nointerpolation float3 Diffuse  : TEXCOORD0;
    nointerpolation float3 Normal   : NORMAL0;
    float  Depth    : TEXCOORD1;
    float3 WorldPos : TEXCOORD2;
};

struct GPass {
    float4 Diffuse  : SV_Target0;
    float4 Depth    : SV_Target1;
    float4 Normal   : SV_Target2;
    float4 WorldPos : SV_Target3;
};

GPass main(PS In) {
    GPass Out;
        Out.Diffuse  = float4(In.Diffuse, 1.);
        Out.Depth    = float4(In.Depth, In.Depth, In.Depth, 1.);
        Out.Normal   = float4(In.Normal, 1.);
        Out.WorldPos = float4(In.WorldPos, 1.);
    return Out;
}
