half3 DecodeNormals(half4 packedNormal, half scale = 1.0)
{
    half3 normal;
    normal.xy = packedNormal.ag;
    normal.z = max(1.0e-16, sqrt(1.0 - saturate(dot(normal.xy, normal.xy))));
    normal.xy *= scale;
    return normal;
}