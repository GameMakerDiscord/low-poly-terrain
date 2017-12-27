struct PS {
    float4 Position : SV_POSITION0;
    float2 Texcoord : TEXCOORD0;
};

Texture2D<float> _Depth : register(t1);
SamplerState _DepthSamp : register(s1);

//      [0-1]
float _Stength, _Samples;
float2 _Direction;

float4 main(PS In) : SV_Target {
    float4 Out = float4(0., 0., 0., 1.);
    float4 m_Out = float4(0., 0., 0., 1.);
    float Depth = 1. - _Depth.Sample(_DepthSamp, In.Texcoord);
    float a = gm_BaseTextureObject.Sample(gm_BaseTexture, In.Texcoord).a;
    
    float delta = 1. / _Samples;
    float di = 1. / (_Samples - 1.);
    
    for( float i = -.5; i < .501; i += di ) {
        float4 c = gm_BaseTextureObject.Sample(gm_BaseTexture, In.Texcoord + i * _Direction);
        Out += c * delta;
        m_Out = max(m_Out, c);
    }
    
    return lerp(Out, m_Out, _Stength);
    
    /*for( int x = -R; x < R; x++ ) {
        for( int y = -R; y < R; y++ ) {
            float2 UV = In.Texcoord + float2(x, y);
            
            if( distance(UV, In.Texcoord) < R ) {
                float4 P = gm_BaseTextureObject.Sample(gm_BaseTexture, UV);
                float w = (length(P.rgb) + .1);
                weight += w;
                Out += P * w;
            }
        }
    }
    
    return float4((Out / weight).rgb * Depth, a);*/
}
