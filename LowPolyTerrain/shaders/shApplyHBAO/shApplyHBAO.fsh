struct PS {
    float4 Position : SV_POSITION0;
    float2 Texcoord : TEXCOORD0;
};

Texture2D _Diffuse        : register(t1);
SamplerState _DiffuseSamp : register(s1);

float4 main(PS In) : SV_Target {
    float4 Out = gm_BaseTextureObject.Sample(gm_BaseTexture, In.Texcoord);
    return Out * _Diffuse.Sample(_DiffuseSamp, In.Texcoord);
}
