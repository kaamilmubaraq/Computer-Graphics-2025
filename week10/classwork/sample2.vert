// --------------------------------------------
// 頂点シェーダ：法線をフラグメントへ渡し，
// 頂点位置を画面上の座標に変換する
// --------------------------------------------

attribute vec3 aPosition;        // 各頂点の位置座標
attribute vec3 aNormal;          // 各頂点の法線ベクトル

uniform mat4 uModelViewMatrix;   // モデル座標→視点座標の変換行列
uniform mat4 uProjectionMatrix;  // 視点座標→画面座標の投影行列

varying vec3 vNormal;            // フラグメントシェーダに渡す法線

void main() {

  // 法線を正規化（単位ベクトル化）してフラグメントシェーダへ送る
  vNormal = normalize(aNormal);

  // 頂点座標を変換し，最終的な描画位置を決定する
  gl_Position = uProjectionMatrix
              * uModelViewMatrix
              * vec4(aPosition, 1.0);
}
