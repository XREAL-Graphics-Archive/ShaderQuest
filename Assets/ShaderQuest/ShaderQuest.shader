Shader "ShaderQuest"
{
    Properties
    {
        [KeywordEnum(Mesh Normals, Normal Map)] _Define ("Bump", Float) = 1
        
        _MainTex ("Albedo", 2D) = "white" {}
        
        [NoScaleOffset] _BumpMap("Normal Map", 2D) = "bump" {}
        _BumpScale("Normal Scale", Range(0,1)) = 1
    }
    SubShader
    {
        Tags 
        {
            "RenderPipeline"="UniversalPipeline"
            "Queue"="Geometry"
            "RenderType"="Opaque"
        }

        Pass
        {
            Name "Universal Forward"
            Tags {"LightMode"="UniversalForward"}
            
            HLSLPROGRAM
            #pragma prefer_hlslcc gles
        	#pragma exclude_renderers d3d11_9x
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile _ _DEFINE_NORMAL_MAP

            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Util.hlsl"

            struct Attributes
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float3 normal : NORMAL;
                ////////////////////////////////////
                #if _DEFINE_NORMAL_MAP
                float4 tangent : TANGENT;
                #endif
            };

            struct Varyings
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
                float3 normal : TEXCOORD3;
                ////////////////////////////////////
                #if _DEFINE_NORMAL_MAP
                float3 tangent : TEXCOORD4;
                float3 bitangent : TEXCOORD5;
                #endif
            };

            // declare variables here
            ///////////////////////////////////////////////////
            ////////////////// ADD CODE HERE //////////////////
            ///////////////////////////////////////////////////
            float _BumpScale;

            Varyings vert (Attributes v)
            {
                Varyings o = (Varyings)0;

                // transform mesh vertices & setup UVs
                ///////////////////////////////////////////////////
                ////////////////// ADD CODE HERE //////////////////
                ///////////////////////////////////////////////////
                
                o.normal = TransformObjectToWorldNormal(v.normal); // transform mesh normals
                
                #if _DEFINE_NORMAL_MAP
                o.tangent = TransformObjectToWorldDir(v.tangent.xyz);
                o.bitangent = cross(o.normal, o.tangent.xyz);
                o.bitangent *= v.tangent.w * unity_WorldTransformParams.w; // handle flipping/mirroring
                #endif
                
                return o;
            }
            
            half4 frag (Varyings i) : SV_Target
            {
                Light mainLight = GetMainLight();

                half4 albedo = 0; // sample albedo here
                half4 normal = 0; // sample normal here
                
                // sample albedo, normal map and remap normal map
                ///////////////////////////////////////////////////
                ////////////////// ADD CODE HERE //////////////////
                ///////////////////////////////////////////////////
                
                #if _DEFINE_NORMAL_MAP

                normal = half4(DecodeNormals(normal, _BumpScale), 1);
                float3x3 mtxTangentToWorld = {
                    i.tangent.x, i.bitangent.x, i.normal.x,
                    i.tangent.y, i.bitangent.y, i.normal.y,
                    i.tangent.z, i.bitangent.z, i.normal.z
                };
                half3 worldNormal = mul(mtxTangentToWorld, normal.xyz);
                half diffuse = saturate(dot(mainLight.direction, worldNormal));
                
                #else

                half diffuse = saturate(dot(mainLight.direction, i.normal));

                #endif
                
                albedo *= diffuse;
                return albedo;
            }
            ENDHLSL
        }
    }
}