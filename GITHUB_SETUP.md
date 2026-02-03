# GitHubへのアップロード手順

このプロジェクトをGitHubにアップロードするための手順です。

## 前提条件

- Gitがインストールされていること
- GitHubアカウントを持っていること
- リポジトリが作成済みであること: https://github.com/otochin/Throne-of-Legacy

## 手順

### 方法1: コマンドライン（Gitがインストールされている場合）

```bash
# 1. Gitリポジトリを初期化（まだの場合）
git init

# 2. リモートリポジトリを追加
git remote add origin https://github.com/otochin/Throne-of-Legacy.git

# 3. すべてのファイルをステージング
git add .

# 4. 初回コミット
git commit -m "Initial commit: Throne of Legacy project setup"

# 5. メインブランチにプッシュ
git branch -M main
git push -u origin main
```

### 方法2: GitHub Desktopを使用する場合

1. **GitHub Desktopを開く**
2. **File > Add Local Repository** を選択
3. このプロジェクトのフォルダを選択: `C:\Users\ariey\uefn\ThroneOfLegacy`
4. **Repository > Repository Settings** を開く
5. **Remote** タブで、リモートURLを設定:
   - `https://github.com/otochin/Throne-of-Legacy.git`
6. **Changes** タブで、すべての変更を確認
7. コミットメッセージを入力: "Initial commit: Throne of Legacy project setup"
8. **Commit to main** をクリック
9. **Push origin** をクリック

### 方法3: VS Code / CursorのGit機能を使用する場合

1. **Source Control** パネルを開く（Ctrl+Shift+G）
2. **Initialize Repository** をクリック（まだ初期化されていない場合）
3. すべてのファイルをステージング（+ボタン）
4. コミットメッセージを入力: "Initial commit: Throne of Legacy project setup"
5. **Commit** をクリック
6. **...** メニューから **Remote > Add Remote** を選択
7. リモート名: `origin`
8. リモートURL: `https://github.com/otochin/Throne-of-Legacy.git`
9. **...** メニューから **Push** を選択

## 注意事項

- `.gitignore` ファイルが作成済みです。これにより、以下のファイルはアップロードされません:
  - `.uasset`, `.umap` などのバイナリファイル
  - `.urc/` フォルダ（Unreal Revision Controlのデータ）
  - `.vscode/` フォルダ（個人設定）
  - その他の一時ファイル

- **アップロードされるファイル**:
  - `Content/*.verse` - Verseスクリプトファイル
  - `docs/` - ドキュメント
  - `README.md` - プロジェクト説明
  - `.gitignore` - Git除外設定
  - プロジェクト設定ファイル（`.uefnproject`, `.uplugin` など）

## トラブルシューティング

### Gitがインストールされていない場合

1. [Git公式サイト](https://git-scm.com/download/win)からダウンロード
2. インストール後、コマンドプロンプトまたはPowerShellを再起動

### 認証エラーが発生する場合

- GitHubのPersonal Access Tokenを使用する必要がある場合があります
- または、SSHキーを設定してください

### リポジトリが既に存在する場合

```bash
# 既存のリモートを確認
git remote -v

# リモートを削除して再追加（必要な場合）
git remote remove origin
git remote add origin https://github.com/otochin/Throne-of-Legacy.git
```
