Shader "Transparent/ZWrite3"
{
Properties {
            _MainTex ("Base (RGB)", 2D) = "white" {}
        }
     
        SubShader {
            Blend SrcAlpha OneMinusSrcAlpha
 
            Pass {
                CGPROGRAM
                #pragma vertex vert_img
                #pragma fragment frag
   
                #include "UnityCG.cginc"
             
                uniform sampler2D _MainTex;
   
                fixed4 frag(v2f_img i) : SV_Target {
                    fixed4 r = tex2D(_MainTex, i.uv);
                 
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
