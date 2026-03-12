# Notion Sources

kiji スキルが参照する Notion リソースの ID 一覧。

---

## 口調・スタイルガイド（STEP 4-1）

`notion-fetch` で取得するページ。

| ページ | Notion ID |
|--------|-----------|
| 文章スタイル | `2f4ad2a27aab80f7bad1e377f5611de0` |
| 執筆・構造ガイドライン | `2f4ad2a27aab804da2ead72c41ed22fe` |
| ポンテベッキオ文体分析 | `41c33190a13a4e98863edc3bcfcb1324` |

取得失敗時は `references/tone_guide.md` をフォールバックとして使用する。

---

## 模範記事（STEP 4-2）

テーマに近いものを1〜2本選択し `notion-fetch` で取得する。

| 記事名 | Notion ID |
|--------|-----------|
| Claude Coworker記事 | `2f7ad2a27aab806cae57e3f42e4fdd07` |
| Claude Code壁打ち記事 | `2f6ad2a27aab80dd8158da93a773a5d3` |
| Roblox記事 | `2f5ad2a27aab803191d7f539826ae235` |
| Claude AI進化記事 | `2f5ad2a27aab8051a853cfa16a40920b` |

---

## 出力先（STEP 4-4）

`notion-create-pages` で記事案データベースに新規ページを作成する。

**親コレクション**: `collection://2f3ad2a2-7aab-8047-89ce-000b57b0431c`（finn.dev 記事案）

**プロパティ定義**:

| プロパティ | 値 |
|-----------|-----|
| タイトル | 記事タイトル |
| ステータス | 「下書き」 |
| ライター | 「Claude」 |
| 案出 | ユーザー名 |

**本文**:
- 記事全文
- 末尾にソースURL一覧を配置
