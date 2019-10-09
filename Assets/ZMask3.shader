Shader "Transparent/ZWrite3"
{
Properties {
            _MainTex ("Base (RGB)", 2D) = "white" {}
			_ClippingMask("ClippingMask", 2D) = "white" {}
        }
     
        SubShader {
		 Tags { "Queue" = "Transparent" "IgnoreProjector" = "True" "RenderType" = "Transparent" }
		 Cull Off
		 Lighting Off
		 ZWrite Off
		 Blend One OneMinusSrcAlpha
 
            Pass {
                CGPROGRAM
                #pragma vertex vert_img
                #pragma fragment frag
   
                #include "UnityCG.cginc"

				struct v2f
				{
					float4  pos : SV_POSITION;
					float2  uv : TEXCOORD0;
					float2  uv2 : TEXCOORD1;
					fixed4  color : COLOR;
				};

                sampler2D _MainTex;
				sampler2D _ClippingMask;
				float4 _MainTex_ST;
				float4 _ClippingMask_ST;

				v2f vert_img(appdata_full v)
				{
					v2f o;
					o.pos = UnityObjectToClipPos(v.vertex);
					o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
					o.uv2 = TRANSFORM_TEX(v.texcoord1, _ClippingMask);
					o.color = v.color;
					return o;
				}

                fixed4 frag(v2f i) : SV_Target {
					fixed4 r = tex2D(_MainTex, i.uv) * tex2D(_ClippingMask, i.uv2);
                
				
                    if(r.g >= 0.7f)
                    {
                        r.a = 0;
                        r.g = r.r = r.b = 0;
                    }

                    return r;
                }
                ENDCG
            }
        }
}
