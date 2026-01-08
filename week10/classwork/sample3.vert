// 頂点座標と法線（頂点ごとに与えられる）
attribute vec3 aPosition;          // 頂点の位置（ローカル座標）
attribute vec3 aNormal;            // 頂点の法線ベクトル

// 変換行列（全頂点で共通）
uniform mat4 uModelViewMatrix;     // モデル・視点変換行列
uniform mat4 uProjectionMatrix;    // 投影変換行列
uniform mat3 uNormalMatrix;        // 法線用変換行列

// フラグメントシェーダへ渡す値
varying vec3 vNormal;              // 変換後の法線
varying vec3 vPos;                 // カメラ座標系での位置

void main() {
  // 法線をカメラ座標系へ変換＋正規化
  vNormal = normalize(uNormalMatrix * aNormal);

  // 頂点位置をカメラ座標系へ変換
  vec4 posView = uModelViewMatrix * vec4(aPosition, 1.0); 
  vPos = posView.xyz;               // 位置をvec3で保持

  // 画面座標へ
  gl_Position = uProjectionMatrix * posView; // クリップ座標を計算
}

