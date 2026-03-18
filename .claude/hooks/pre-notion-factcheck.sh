#!/usr/bin/env bash
# PreToolUse hook: kiji記事Notion出力前ファクトチェック
# notion-create-pages / notion-update-page 呼び出しをインターセプトし、
# kiji記事の場合はファクトチェック完了まで出力をブロックする。

set -euo pipefail

INPUT=$(cat)

# jq 未インストール時はスキップ（ブロックしない）
if ! command -v jq &>/dev/null; then
  exit 0
fi

# tool_input を文字列化して「みこ」の存在でkiji記事かどうか判定
TOOL_INPUT=$(echo "$INPUT" | jq -r '.tool_input // empty' 2>/dev/null)
if [ -z "$TOOL_INPUT" ]; then
  exit 0
fi

# 「みこ」が含まれなければkiji記事ではない → スキップ
if ! echo "$TOOL_INPUT" | jq -r 'tostring' 2>/dev/null | grep -q "みこ"; then
  exit 0
fi

# セッションIDベースのフラグファイルでループ防止
SESSION_ID=$(echo "$INPUT" | jq -r '.session_id // "unknown"' 2>/dev/null)
FLAG_FILE="/tmp/kiji_factcheck_${SESSION_ID}"

# フラグ存在 → ファクトチェック済み → 許可
if [ -f "$FLAG_FILE" ]; then
  exit 0
fi

# フラグ作成（次回は許可される）
touch "$FLAG_FILE"

# ブロック: ファクトチェック指示を出力
cat <<'BLOCK_JSON'
{"decision": "block", "reason": "【記事本文ファクトチェック未実施】Notion出力前に記事本文のファクトチェックが必要です。\n\n以下の手順で実行してください:\n1. `.claude/skills/kiji/agents/article-fact-checker.md` を Read で読み込む\n2. Agent ツール (model=sonnet) で記事本文ファクトチェッカーを起動し、書き上がった記事ドラフト全文を入力として渡す\n3. 結果が NEEDS_FIX の場合、確信度「高」「中」の指摘箇所を修正する\n4. 修正完了後（またはPASSの場合）、再度Notionへの出力を実行する"}
BLOCK_JSON
