# Elixir-2023

## IEx
* iexコマンド
* IEx.Helpers
* アリティ

## Elixirの型(Basic)
Elixirのデータ型
* 整数(integer)
* 浮動小数点数(float)
* アトム(atom)
* 文字列(string)

## データ型
整数(integer)
浮動小数点数(float)
アトム(atom)
真偽値(boolean value)
nil
ビットストリング(bitstring)
バイナリ(binary)
文字列(string)
リスト(list)
文字リスト(charlist)
キーワードリスト(keyword list)
タプル(tuple)
マップ(map)
関数(function)
PID(Process ID)
リファレンス(reference)
ポート識別子(port identifier)

## 数値

## アトム

## 文字列

## コレクション
### リスト
* リストの差分
* リストの連結
* 二項演算子 in , not in

### タプル
* タプルの特徴
* タプルの使い道
* タプルのメリット・デメリット

### キーワードリスト
* キーワードリストを用いる条件
* キー・値について

### マップ
* 特徴、記述方法
* 値の取り出し

## 関数
* 無名関数
* 名付き関数

## 型の判別
ある変数にセットされている項の型を判別する関数

## 無名関数
* 定義する方法
* 使う方法

## 名前づき関数
* 定義する方法
* 使う方法

## モジュール
* 名前付き関数の呼び出し
* 無名関数の作成と呼び出し

## キャプチャ演算子
* 使い道と使い方

## 構造体
* 定義する方法
* 構造体の取得
* エラーの発生
* nilの定義
* 関数を使用しての更新

## Elixir基礎ワーク
* ワーク用フォルダの作成
* 標準入出力
* 四則演算
* 文字列とアトム
* 文字リスト
* リスト/タプル/マップ

## パターンマッチ
* 変数への束縛
* 変数への再束縛
* パターンマッチの活用
* パターンマッチ上のアンダースコア
* アンダースコアから始まる変数
* 値の不変性

## 制御構造
* 制御構造とは
* 制御構想の種類
    * if, if・else
    * unless, unless・else
    * case
    * cond
    * do/endブロック

## 例外
* 例外とは
* Check Point 1: Elixirでの例外処理
* Check Point 2: Elixirのエラーハンドリング構文
* raise
* try/rescue
* try/catch
* after
* exit

## Day 2 ワーク
1. デッキを作成する
2. デッキをシャッフルする
3. デッキからカードを何枚か引く
4. 手札に何のカードがあるか確認する
5. デッキの状態を保存する
6. 保存したデッキの情報を取得します

## コレクション操作
* コレクションとは
* リストの操作
    * リストの長さを調べる
    * リストから要素を取得する
    * リストに要素を挿入する
    * リストから要素を削除する
    * ストの並びを反転させる
    * リストの平坦化
* タプルの操作
* キーワードリストの操作
    * 値を取得する
    * 要素の追加
    * 要素の削除
* キーワードリストを扱うその他の関数
* マップの操作
    * 値を取得する
    * 要素の追加と更新
    * 要素の追加と更新(パイプ記号)
    * その他の関数

## forマクロ
* forマクロで要素を順に取り出す

## Enum
* Enumとは
* Enum.map/2
* Enum.each/2
* Enum.sort/1, Enum.sort/2
* Enum.reverse/1
* Enum.find/2
* Enum.empty?/1
* Enum.filter/2
* Enum.reject/2
* Enum.join/2
* Enum.all?/1
* Enum.any?/1
* Enum.uniq/1
* Enum.min/1, Enum.min/2
* Enum.max/1, Enum.max/2
* Enum.take/2
* Enum.zip/1, Enum.zip/2
* Enum関数群のサフィックスルール
    * _by, _while, _every
* 複数の Enum 関数を１つにまとめて提供されている関数