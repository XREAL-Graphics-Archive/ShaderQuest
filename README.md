# ShaderQuest
 
그래픽스팀 5/6 과제 리포

## 과제 내용
### 1. 노말 매핑
* [ShaderQuest.shader](https://github.com/XREAL-Graphics-Archive/ShaderQuest/blob/master/Assets/ShaderQuest/ShaderQuest.shader) 파일의 스켈레톤 코드에서 다음 부분을 찾아 채워주세요. ***나머지 부분은 수정하지 마세요!!!***
```hlsl
  // declare variables here
  ///////////////////////////////////////////////////
  ////////////////// ADD CODE HERE //////////////////
  ///////////////////////////////////////////////////
  float _BumpScale;
```
```hlsl
  Varyings o = (Varyings)0;

  // transform mesh vertices & setup UVs
  ///////////////////////////////////////////////////
  ////////////////// ADD CODE HERE //////////////////
  ///////////////////////////////////////////////////

  o.normal = TransformObjectToWorldNormal(v.normal); // transform mesh normals
```
```hlsl
  half4 albedo = 0; // sample albedo here
  half4 normal = 0; // sample normal here

  // sample albedo, normal map and remap normal map
  ///////////////////////////////////////////////////
  ////////////////// ADD CODE HERE //////////////////
  ///////////////////////////////////////////////////
```
* Unity상의 결과를 아래 사진 처럼 찍어서 업로드 해주세요. *(똑같을 필요는 없고 비슷하기만 하면 됩니다)*
<p align="center">
  <img src="https://user-images.githubusercontent.com/61895947/235045533-1a2484f6-b63e-412a-9511-b507d89eccb1.jpeg" width="711" height="400">
 <p/>
<p align="center"><b>Figure 1:</b> Medieval Pavement<p/>

## 필수 구현사항
* Clip space로 공간 변환
* 텍스처링 적용
  * albedo map 샘플링
  * normal map 샘플링
  * normal map 리매핑

> **Note**<br>
> Normal map의 rgb 값의 범위는 [0,1]인데, [-1,1]로 만들어주셔야 합니다!

## 선택 구현사항
Height map 적용 (height map 적용에 한해서 다른 코드 수정하셔도 됩니다)

*하단의 참고 자료(Parallax Mapping)를 확인해주세요*

## 추가 자료
### Normal Map
노멀 맵은 실제 지오메트리로 표현되는 것처럼 광원을 받는 범프, 홈 및 스크래치 등의 표면 디테일을 모델에 추가하는 데 사용할 수 있는 특별한 텍스처 종류입니다.
상황에 따라 “실제” 지오메트리로 모델링된 작은 디테일을 갖는 것은 일반적으로 좋지 않습니다. 미세한 표면 디테일을 가진 커다란 모델에서 그리면 매우 많은 수의 폴리곤이 필요합니다. 이를 피하기 위해 노멀 맵을 사용하여 미세한 표면 디테일을 표현하고, 모델의 더 큰 모양을 위해 더 낮은 해상도의 폴리곤 표면을 사용해야 합니다. 디테일을 범프 맵으로 대신 나타내면 표면 지오메트리가 훨씬 더 간단해질 수 있고 디테일은 광원이 표면에서 반사되는 방법을 조절하는 텍스처로 표현됩니다.

### Normal Mapping
노말 매핑은 텍스처를 사용하여 모델 전체에 걸쳐 표면 노멀을 수정하는 방법에 대한 정보를 저장하여 표면 노멀 수정을 한 단계 발전시킵니다. 노멀 맵은 일반 컬러 텍스처처럼 모델의 표면에 매핑되는 이미지 텍스처이지만, 노멀 맵 텍스처의 각 픽셀(texel이라고 함)은 평평한(또는 부드럽게 보간된) 폴리곤의 “실제” 표면 노멀과 표면 노멀 방향 간의 편차를 나타냅니다.
<p align="center">
  <img src="https://docs.unity3d.com/kr/2021.3/uploads/Main/BumpMapBumpShadingDiagram.svg">
 <p/>
<p align="center"><b>Figure 2:</b> 3개의 폴리곤에 걸친 노멀 매핑(2D 다이어그램으로 표시)<p/>
3D 모델의 표면에 있는 폴리곤을 2D로 표현한 이 다이어그램에서 주황색 화살표는 각각 노멀 맵 텍스처의 픽셀에 대응합니다. 아래에는 노멀 맵 텍스처의 단일 픽셀 슬라이스가 있습니다. 중앙을 보면 노멀이 수정되어 폴리곤 표면에 범프가 2–3개 있는 형상이 나타남을 알 수 있습니다. 이런 범프는 조명이 표면에 나타나는 방법으로만 보입니다. 수정된 노멀이 조명 계산에 사용되기 때문입니다.

원시 노멀 맵 파일에 보이는 컬러는 일반적으로 푸른 색조를 띠고 밝거나 어두운 실제 셰이딩을 포함하지 않습니다. 컬러 자체가 그대로 표시되도록 의도되지 않았기 때문입니다. 그 대신 각 텍셀의 RGB 값이 방향 벡터의 X, Y, Z 값을 나타내고 폴리곤 표면의 기본 보간된 부드러운 노멀에 대한 수정으로 적용됩니다.

### Tangent, Bitangent, Normal
노말맵에 인코딩된 노말 벡터들은 전부 tangent space에 존재하는 벡터입니다.
<p align="center">
  <img src="https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2Fb8opv9%2FbtqBNNyBjNf%2FzmIlP78KWUkWNAhhDK4EPk%2Fimg.png">
 <p/>
<p align="center"><b>Figure 3:</b> Tangent, Bitangent, Normal<p/>

하지만 diffuse를 계산하기 위해서는 이를 world space로 변환해야 합니다. World space로 변환하기 위해 먼저 메쉬 폴리곤이 가지고 있는 `normal`과 `tangent`를 HLSL semantic을 이용해 Attributes 구조체에 받아옵니다.

```hlsl
  struct Attributes
  {
     ...
     float3 normal : NORMAL;
     float4 tangent : TANGENT;
     ...
  };
```

`bitangent` 값은 `normal`과 `tangent`의 cross product(외적값)으로 구할 수 있습니다. 그리고, 메쉬가 뒤집히거나 미러링이 발생하는 상황도 같이 처리하기 위해 tangent의 w값과 built-in 유니티 파라미터인 `unity_WorldTransformParams.w`을 `bitangent`에 곱합니다.

```hlsl
  bitangent = cross(normal, tangent.xyz);
  bitangent *= tangent.w * unity_WorldTransformParams.w; // handle flipping/mirroring
```

이 결과들을 가지고 TBN 행렬을 생성합니다. 생성된 TBN 행렬과 노말맵에 인코딩된 tangent space normal을 곱하면 world space에 존재하는 노말을 샘플링할 수 있습니다.

```hlsl
  float3x3 mtxTangentToWorld = {
      i.tangent.x, i.bitangent.x, i.normal.x,
      i.tangent.y, i.bitangent.y, i.normal.y,
      i.tangent.z, i.bitangent.z, i.normal.z
  };
  half3 worldNormal = mul(mtxTangentToWorld, normal.xyz);
```

이제 샘플링한 노말값과 광원의 정보를 이용하여 diffuse값을 계산할 수 있습니다.

## References
* [노말맵 유니티 매뉴얼](https://docs.unity3d.com/kr/2021.3/Manual/StandardShaderMaterialParameterNormalMap.html)
* [노말맵 샘플링](https://darkcatgame.tistory.com/84)
* [LearnOpenGL: Normal Mapping](https://learnopengl.com/Advanced-Lighting/Normal-Mapping)
* [LearnOpenGL: Parallax Mapping](https://learnopengl.com/Advanced-Lighting/Parallax-Mapping)
* [Catlike Coding: Rendering 6](https://catlikecoding.com/unity/tutorials/rendering/part-6/)
