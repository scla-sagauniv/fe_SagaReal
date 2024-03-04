# fe_sagareal
## 概要
SAGARealフロントエンドSwiftアプリ

## 言語
- Swift
- Ruby (firebaseなどのCocoaPodsによるインストールが必要なライブラリを使う際に環境が必要)

## アーキテクチャ
ほぼMVC
### ディレクトリ詳細
- model：CRUDなどのデータベースや処理関連を担う関数のswiftファイルを配置する
- view：画面を構成するstoryboardファイルを配置する
- controller：画面遷移や画面操作などのviewにあるstoryboardの操作とmodelの実行を行う

## 環境構築

1. 適当なディレクトリに ```git clone git@github.com:scla-sagauniv/fe_sagareal.git```
1. ディレクトリに移動 ```cd fe_sagareal```
1. developブランチに移動 ```git checkout develop```
1. プロジェクトを開く ```open fe_sagareal.xcodeproj```　もしくはxcodeからプロジェクトを開くかFinderからxcodeprojをダブルクリック

## 実行
- xcodeの矢印（デバッグボタン）でデバッグ
