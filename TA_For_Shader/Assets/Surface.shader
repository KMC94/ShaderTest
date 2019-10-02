Shader "Custom/Surface"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
		_BumpMap("NormalMap", 2D) = "bump"{}
		_Metallic ("Metalic", Range(0, 1)) = 0
		_Smoothness ("Smoothness", Range(0, 1)) = 0.5
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        #pragma surface surf Standard

        sampler2D _MainTex;
		sampler2D _BumpMap;
		float _Metallic;
		float _Smoothness;


        struct Input
        {
            float2 uv_MainTex;
			float2 uv_BumpMap;
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			fixed3 n = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
			o.Normal = float3(n.x * 2, n.y * 2, n.z);
			//o.Normal = UnpackNormal(tex2D(_BumpMap, UN.uv_BumpMap));
            o.Albedo = c.rgb;
            o.Alpha = c.a;
			o.Metallic = _Metallic;
			o.Smoothness = _Smoothness;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
