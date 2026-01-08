// --------------------------------------------
// 頂点シェーダ：
// 頂点の位置を変換し，画面上に描画する
// --------------------------------------------

attribute vec3 aPosition;            // 各頂点の位置座標（x, y, z）

uniform mat4 uModelViewMatrix;       // モデル座標→視点座標の変換行列
uniform mat4 uProjectionMatrix;      // 視点座標→画面座標の投影行列

void main() {

  // 頂点座標に変換行列を適用し，最終的な表示位置を計算する
  gl_Position =
      uProjectionMatrix              // 投影変換
    * uModelViewMatrix               // モデル・視点変換
    * vec4(aPosition, 1.0);          // 頂点位置（同次形[x,y,z,1]）
}
