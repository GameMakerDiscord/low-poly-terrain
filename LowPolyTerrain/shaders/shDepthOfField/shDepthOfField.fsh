struct PS {
    float4 Position : SV_POSITION0;
    float2 Texcoord : TEXCOORD0;
};

Texture2D<float> _Depth : register(t1);
SamplerState _DepthSamp : register(s1);

Texture2D _Blur        : register(t2);
SamplerState _BlurSamp : register(s2);

float _FocalDistance, _FocalRange;

float4 main(PS In) : SV_Target {
    float  Depth = _Depth.Sample(_DepthSamp, In.Texcoord);
    float4 Out = gm_BaseTextureObject.Sample(gm_BaseTexture, In.Texcoord);
    float4 Blurred = _Blur.Sample(_BlurSamp, In.Texcoord);
    
    float Blur = (1. - clamp(abs(Depth - _FocalDistance), 0., 1.)) / _FocalRange;
    
    float a = Out.a;
    Out = lerp(Out, Blurred, Blur);
    Out.a = a;
    
    return /*float4(Blur, Blur, Blur, 1.); //*/Out;
}
