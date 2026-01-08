precision mediump float;    // 浮動小数点の精度指定

varying vec3 vNormal;       // 頂点シェーダから受け取る法線
varying vec3 vPos;          // 頂点シェーダから受け取る位置（カメラ座標）

void main() {
  // ---------- 固定パラメータ ----------
  // 光源（カメラ座標系）
  vec3 lightPos = vec3(200.0, -200.0, 200.0); // 光源位置
  vec3 lightColor = vec3(1.0, 1.0, 1.0);      // 光の色（白）

  // 材質
  vec3 Ka = vec3(0.1, 0.1, 0.1);          // 環境光反射率（色）
  vec3 Kd = vec3(0.2, 0.5, 1.0);          // 拡散反射率（色）
  vec3 Ks = vec3(1.0, 1.0, 1.0);          // 鏡面反射率（色）
  float shininess = 30.0;                 // 鏡面の鋭さ

  // 環境光
  vec3 ambientLight = vec3(0.3, 0.3, 0.3); // 環境光の強さ

  // ---------- ベクトル計算 ----------
  vec3 N = normalize(vNormal);            // 正規化した法線
  vec3 L = normalize(lightPos - vPos);    // 光の入射方向
  vec3 V = normalize(-vPos);              // 視点方向
  vec3 R = reflect(-L, N);                // 反射方向

  // ---------- Phong 反射モデル ----------
  // 環境光
  vec3 Ia = Ka * ambientLight;             // 環境光成分

  // 拡散反射（Lambert）
  float diff = max(dot(N, L), 0.0);        // 明るさ係数
  vec3 Id = Kd * lightColor * diff;        // 拡散反射成分
  
  // 鏡面反射
  float spec = 0.0;                        // 鏡面強度
  if (diff > 0.0) {                        // 光が当たる場合のみ
    spec = pow(max(dot(R, V), 0.0), shininess); // 鏡面反射計算
  }
  vec3 Is = Ks * lightColor * spec;        // 鏡面反射成分

  vec3 color = Ia + Id + Is;               // 反射光の合成

  gl_FragColor = vec4(color, 1.0);         // 最終的な色を出力
}
