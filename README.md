# ShaderQuest
 
그래픽스팀 5/6 과제 리포

## 과제 내용
1. [ShaderQuest.shader](https://github.com/XREAL-Graphics-Archive/ShaderQuest/blob/master/Assets/ShaderQuest/ShaderQuest.shader) 파일의 스켈레톤 코드에서 다음 부분을 찾아 채워주세요. ***나머지 부분은 수정하지 마세요!!!***
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
2. Unity상의 결과를 아래 사진 처럼 찍어서 업로드 해주세요. *(똑같을 필요는 없고 비슷하기만 하면 됩니다)*
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

[참고자료](https://learnopengl.com/Advanced-Lighting/Parallax-Mapping)
