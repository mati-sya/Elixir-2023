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
* 整数(integer)
* 浮動小数点数(float)
* アトム(atom)
* 真偽値(boolean value)
* nil
* ビットストリング(bitstring)
* バイナリ(binary)
* 文字列(string)
* リスト(list)
* 文字リスト(charlist)
* キーワードリスト(keyword list)
* タプル(tuple)
* マップ(map)
* 関数(function)
* PID(Process ID)
* リファレンス(reference)
* ポート識別子(port identifier)

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

## Stream
* Streamとは

## リスト
* リストのヘッドとテール
* パターンマッチを使ったヘッドとテールの取得

## 再帰
* 再帰処理とは
* リストの再帰的構造
* map関数の作成
* 再帰中の値の保持
* より複雑なリストのパターン
* 特定条件のリストの抽出

## 文字列
* シングルクオーテーション
* ダブルクオーテーション

## バイナリ

## シギル

## ワーク：Cardモジュールの作成
1. デッキを作成する
2. デッキをシャッフルする
3. デッキからカードを何枚か引く
4. 手札に何のカードがあるか確認する
5. デッキの状態を保存する
6. 保存したデッキの情報を取得します

## Mixコマンド

## Mixプロジェクト
* プロジェクトの生成
* ソースコードの整理とテスト
* ソースコードの記述
* Mixプロジェクト内でIExを起動する
* パッケージのインストール

## カード節
* 復習：caseマクロ
* ガード節を用いたcaseマクロのプログラム
* ガード節(Guard)とは
* ガード節付きの名前付き関数
* ガード節付きの無名関数
* ガード節の制限

## ワーク：Identicon
* Identiconプログラムの概要
* Identiconプログラムの設計
* 文字列からのパターン生成
* :crypto.hash/2 について
* ハッシュ化関数の利用
* プロジェクトの作成
* 構造体の作成
* カラー作成の考え方
* リスト先頭からの要素の取得
* グリッドの構築
* リストの分割
* 左右対称にする関数mirror_rowの作成
* Enum.mapの活用
* インデックスをつける
* 色をつける場所をフィルターする
* 画像処理のライブラリ EGD
* 水平と垂直の求め方
* build_pixel_map関数の作成
* 画像の生成
* 画像の書き出し
* main関数の作成

## Doc
* Elixirのドキュメント
* モジュール属性
* #(インラインドキュメント)
* @moduledoc
* @doc
* ExDoc

## ExUnit(テスト駆動)
* ExUnit
* doctest
* ExUnitとdoctestの違い
* ExUnitの書き方
    * assert
    * refute
* テストのグループ化
* 未実装のテスト
* 個別のファイルとしてテストスクリプトを作成する方法
* doctestの補足

## PID
* Elixirのプロセスの仕組み
* 新しいプロセスを作る（spawn/1、spawn/3）
* プロセス間でのメッセージ送受信（send/2、receive/1）
* プロセス間でのメッセージ送受信（send/2、receive/1）＋ 再帰処理
* プロセスのオーバーヘッド
* プロセスが死ぬ時
* プロセス監視
* Parallel Map

## ワーク：クローラー
* チュートリアル
* Work

## データ加工・変換(Json)
* データ読み込みと加工
* jsonをマップに変換
* マップからjsonへ変換
* デコードしたデータの確認
* 地理座標の取得
* データのマッピング
* マップからjson変換(応用)

## CSV読み込み・加工
* CSVデータ変換
* csvモジュールによる書き出し
* csvデータをマップへ変換

## 文字列操作10本ノック
* パイプライン演算子
1. 文字列の逆順
2. 「パタトクカシーー」
3. 「パトカー」＋「タクシー」＝「パタトクカシーー」
4. 円周率
5. 元素記号
6. n-gram
7. 集合
8. テンプレートによる文生成
9. 暗号文
10. TypoglycemiaPermalink

## データ加工・変換を使用したワーク
* 演習
* 解答例

## DB作成
* Ecto
* Ectoアプリケーションの作成
* データベースのセットアップ

## マイグレーション
* テーブルの作成

## スキーマ
* スキーマの作成

## シードデータの扱い
* シードデータの作成

## Repo
* Repo.all/2
* Repo.get/3
* Repo.get_by/3

## ワーク
* DBの作成からテーブル、スキーマの作成、Repo.getを使用したワーク

## Repo.insert

## チェンジセット、バリデーション
* cast/4, validate_required/3