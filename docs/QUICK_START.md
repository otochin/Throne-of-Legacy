# 新しいチャットセッションでの開発開始ガイド

このドキュメントは、新しいチャットセッションで開発を開始する際に参照すべき順序とポイントをまとめています。

---

## ⚠️ 最初に参照すること：UEFN Verse

**開発を進める前に、必ず UEFN Verse の公式ドキュメントを参照してください。**

- **まとめ**: リンク一覧は **`docs/UEFN_VERSE_REFERENCE.md`** に記載しています。
- **Verse API Reference（公式）**: https://dev.epicgames.com/documentation/en-us/uefn/verse-api-reference
- **Verse Language Reference**: [verse-language-reference](https://dev.epicgames.com/documentation/en-us/uefn/verse-language-reference-in-unreal-editor-for-fortnite)
- **UEFN Documentation**: [uefn](https://dev.epicgames.com/documentation/en-us/uefn)

Verse の構文・型・API は公式仕様に従い、実装やコード生成時は上記ドキュメントを優先して参照すること。

---

## 📋 推奨参照順序

### 1. **`docs/DEVELOPMENT_LOG.md`** （最重要・最初に確認）

**目的**: 現在の開発状況を把握する

**確認すべき内容**:
- ✅ **現在のフェーズ**: どのPhaseまで進んでいるか
- ✅ **完了したタスク**: チェックリストで完了済みの項目
- ✅ **進行中のタスク**: 現在作業中の項目
- ✅ **次のステップ**: 次に実装すべき機能
- ✅ **実装済みファイル**: どのVerseファイルが既に存在するか
- ✅ **既知の問題・課題**: バグや技術的な課題があるか
- ✅ **変更履歴**: 最近の変更内容

**所要時間**: 2-3分

---

### 2. **`docs/throne_of_legacy_gdd.md`** （設計思想の確認）

**目的**: プロジェクトの全体設計と設計思想を理解する

**確認すべき内容**:
- ✅ **プロジェクト・ビジョン**: コアコンセプト（タイクーン/RPG/ローグライク）
- ✅ **コア・システム設計**: 
  - 経済システム
  - 建設システム
  - RPG・戦闘システム
  - ダンジョンシステム
- ✅ **開発フェーズ・ロードマップ**: 現在のPhaseの目標とタスク
- ✅ **運用指示**: コーディング規約や設計原則

**所要時間**: 5-10分（必要な箇所だけ確認）

---

### 3. **`docs/SPECIFICATIONS.md`** （実装詳細の確認）

**目的**: 実装レベルの詳細仕様を確認する

**確認すべき内容**:
- ✅ **データ構造仕様**: 実装するクラスの定義
- ✅ **システム実装仕様**: 実装する機能の詳細ロジック
- ✅ **実装チェックリスト**: 現在のPhaseのチェックリスト
- ✅ **エラーハンドリング仕様**: エラー処理の方法

**所要時間**: 5-10分（実装する機能に関連する箇所を重点的に）

---

## 🚀 クイックスタート手順

### Step 1: 現状把握（必須）
```
1. docs/DEVELOPMENT_LOG.md を開く
2. 「開発状況サマリー」セクションを確認
3. 「実装済みファイル」セクションで既存ファイルを確認
4. 「次のステップ」を確認
```

### Step 2: 設計確認（推奨）
```
1. docs/throne_of_legacy_gdd.md を開く
2. 現在のPhaseのセクションを確認（例: Phase 1）
3. 「運用指示」セクションでコーディング規約を確認
```

### Step 3: 実装詳細確認（必要に応じて）
```
1. docs/SPECIFICATIONS.md を開く
2. 実装する機能に関連するセクションを確認
3. データ構造やロジックの詳細を確認
```

---

## ⚠️ コンパイルエラーとUEFN側オブジェクトの関係

**コンパイルエラーが出ている場合**
- **Verse のコンパイルエラーは、コード（.verse ファイル）の修正で解消します。**
- UEFN のレベルに Mutator Zone や Verse Device を置いても、**スクリプトのコンパイルエラーは消えません**。
- コンパイラは .verse の構文・型・API だけを見ており、レベル上に何があるかは見ていません。

**コンパイルが通ったあと**
- **その時点で**、UEFN エディタ側でオブジェクトを用意する必要があります。
- 例：
  - **Verse Device** をレベルに配置し、Verse File（例: `throne_zone_device.verse`）と Device Class（例: `throne_zone_device`）を指定する。
  - **Mutator Zone** を配置し、必要なら Verse Device から参照する（`@editable` でデバイスに Mutator Zone を渡す場合）。
- 詳細な手順は **`docs/UEFN_SETUP_STEPS.md`** にあります。

| 状況 | 対処 |
|------|------|
| まだコンパイルエラーが出る | Verse コードを修正する（型・構文・API の見直し） |
| コンパイルは通るがゲームで動かない | UEFN で Verse Device / Mutator Zone などを配置し、`UEFN_SETUP_STEPS.md` の手順を実施する |

---

## 💡 効率的な確認方法

### パターンA: 開発を続ける場合
1. `DEVELOPMENT_LOG.md` の「次のステップ」を確認
2. 実装する機能に関連する `SPECIFICATIONS.md` の該当セクションを確認
3. 必要に応じて `throne_of_legacy_gdd.md` の設計思想を確認

### パターンB: バグ修正や問題解決の場合
1. `DEVELOPMENT_LOG.md` の「既知の問題・課題」を確認
2. 問題に関連する `SPECIFICATIONS.md` の「エラーハンドリング仕様」を確認
3. 必要に応じて `throne_of_legacy_gdd.md` の設計思想を再確認

### パターンC: 新しい機能を追加する場合
1. `throne_of_legacy_gdd.md` の「開発フェーズ・ロードマップ」を確認
2. 既存システムとの整合性を `SPECIFICATIONS.md` で確認
3. `DEVELOPMENT_LOG.md` に新しいタスクを追加

---

## 📝 開発ログの更新

開発を進める際は、必ず `DEVELOPMENT_LOG.md` を更新してください：

### タスク完了時
- [ ] チェックリストの該当項目にチェックを入れる
- [ ] 「変更履歴」セクションに記録を追加

### 問題発見時
- [ ] 「既知の問題・課題」セクションに記録
- [ ] 解決方法が見つかったら、解決内容も記録

### 重要な設計決定時
- [ ] 「重要な設計決定」セクションに記録
- [ ] 必要に応じて `SPECIFICATIONS.md` も更新

---

## 🎯 チェックリスト

新しいチャットセッション開始時に確認：

- [ ] `DEVELOPMENT_LOG.md` で現在の進捗を確認した
- [ ] 次に実装する機能を特定した
- [ ] 実装する機能の仕様を `SPECIFICATIONS.md` で確認した
- [ ] 設計思想を `throne_of_legacy_gdd.md` で確認した
- [ ] 既存のコードファイルを確認した（必要に応じて）

---

## 📚 ドキュメントの役割分担

| ドキュメント | 主な用途 | 参照頻度 |
|------------|---------|---------|
| `DEVELOPMENT_LOG.md` | 進捗管理・現状把握 | ⭐⭐⭐ 毎回 |
| `throne_of_legacy_gdd.md` | 設計思想・全体像 | ⭐⭐ 必要時 |
| `SPECIFICATIONS.md` | 実装詳細・技術仕様 | ⭐⭐ 実装時 |
| `README.md` | セットアップ・概要 | ⭐ 初回のみ |

---

## 🔗 関連リンク

- [Epic Games UEFN Documentation](https://dev.epicgames.com/documentation/en-us/uefn)
- [Verse Language Reference](https://dev.epicgames.com/documentation/en-us/uefn/verse-language-reference-in-unreal-editor-for-fortnite)
