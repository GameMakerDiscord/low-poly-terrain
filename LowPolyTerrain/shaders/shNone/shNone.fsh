struct PS {
    float4 Position : SV_POSITION0;
    float2 Texcoord : TEXCOORD0;
};

float4 main(PS In) : SV_Target {
    float4 Out = gm_BaseTextureObject.Sample(gm_BaseTexture, In.Texcoord);
    
    return Out;
}
