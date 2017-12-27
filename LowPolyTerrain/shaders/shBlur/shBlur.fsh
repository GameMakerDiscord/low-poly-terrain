/*struct PS {
    float4 Position : SV_POSITION0;
    float2 Texcoord : TEXCOORD0;
};

float2 _ScreenSize;
float _Radius, _Type;

float4 main(PS In) : SV_Target {
    float offset[3];
    float weight[3];
    
    offset[0] = 0.;
    offset[1] = 1.3846153846;
    offset[2] = 3.2307692308;
    
    weight[0] = .2270270270;
    weight[1] = .3162162162;
    weight[2] = .0702702703;
    
    float3 tc = float3(1., 0., 0.);
    float q = float2(((_Type == 0.) ? 1. : 0.), ((_Type == 1.) ? 1. : 0.));
    
    if( In.Texcoord.x < (_Radius - .01) ) {
        tc = gm_BaseTextureObject.Sample(gm_BaseTexture, In.Texcoord).rgb * weight[0];
        
        for( int i = 1; i < 3; i++ ) {
            tc += gm_BaseTextureObject.Sample(gm_BaseTexture, In.Texcoord + float2(offset[i], offset[i]) * q / _ScreenSize.y).rgb / weight[i];
            tc += gm_BaseTextureObject.Sample(gm_BaseTexture, In.Texcoord - float2(offset[i], offset[i]) * q / _ScreenSize.y).rgb / weight[i];
        }
    } else {
        if( In.Texcoord.x >= (_Radius + .01) ) {
            tc = gm_BaseTextureObject.Sample(gm_BaseTexture, In.Texcoord).rgb;
        }
    }
    
    return float4(tc, 1.);
}
/**/
struct PS {
    float4 Position : SV_POSITION0;
    float2 Texcoord : TEXCOORD0;
};

float2 _ScreenSize;
float _Radius, _Type;

float4 blur9(float2 UV, float2 Dir) {
    float4 c = float4(0., 0., 0., 0.);
    float2 off1 = float2(1.3846153846, 1.3846153846) * Dir;
    float2 off2 = float2(3.2307692308, 3.2307692308) * Dir;
    
    c += gm_BaseTextureObject.Sample(gm_BaseTexture, UV)                        * .227027027 ;
    c += gm_BaseTextureObject.Sample(gm_BaseTexture, UV + (off1 / _ScreenSize)) * .3162162162;
    c += gm_BaseTextureObject.Sample(gm_BaseTexture, UV - (off1 / _ScreenSize)) * .3162162162;
    c += gm_BaseTextureObject.Sample(gm_BaseTexture, UV + (off2 / _ScreenSize)) * .0702702703;
    c += gm_BaseTextureObject.Sample(gm_BaseTexture, UV - (off2 / _ScreenSize)) * .0702702703;
    
    return c;
}

float4 main(PS In) : SV_Target {
    return blur9(In.Texcoord, (_Type == 0.) ? float2(0., _Radius) : float2(_Radius, 0.));
}
//*/
