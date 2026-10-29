#!/usr/bin/env bash
# 작업 폴더에 작업 규칙(AGENTS.md)과 스킬(.agents/skills)을 복사한다. 이미 있는 파일은 덮어쓰지 않는다.
# 사용: 작업 폴더에서  bash /tmp/kit/install.sh
#       작업 폴더에 AGENTS.md가 이미 있으면 아무것도 안 하고 멈춘다 → 그 파일을 먼저 읽고,
#       이어 붙여도 되겠다고 판단했을 때만  bash /tmp/kit/install.sh --append
set -e
KIT="$(cd "$(dirname "$0")" && pwd)"
APPEND=0
[ "$1" = "--append" ] && { APPEND=1; shift; }
DEST="$(cd "${1:-$PWD}" && pwd)"

# 하네스 폴더 안에서 실행했으면 그 바깥 폴더를 작업 폴더 후보로 본다.
[ "$DEST" = "$KIT" ] && DEST="$(dirname "$KIT")"

# 작업 폴더 = 과제 README가 있는 곳. 여기에 없으면 git 맨 위 폴더를 보고, 거기에도 없으면 멈춘다.
if ! ls "$DEST" | grep -qi '^readme'; then
  TOP="$(git -C "$DEST" rev-parse --show-toplevel 2>/dev/null || true)"
  if [ -n "$TOP" ] && ls "$TOP" | grep -qi '^readme'; then
    echo "여기엔 README가 없어서 git 맨 위 폴더에 설치: $TOP"
    DEST="$TOP"
  else
    echo "!! $DEST 에 README가 없음 — 작업 폴더가 아닌 것 같아 멈춤."
    echo "   파일 탐색기 맨 위 폴더(README가 있는 곳)로 이동한 뒤 다시:  cd <그 폴더>  →  bash $KIT/install.sh"
    exit 1
  fi
fi

echo "설치 위치: $DEST"
ls "$DEST" | head -20

if [ -e "$DEST/AGENTS.md" ]; then
  if [ "$APPEND" = 1 ]; then
    { printf '\n\n## 응시자 작업 규칙 (위 지침과 다르면 위 지침이 우선)\n'; tail -n +2 "$KIT/AGENTS.md"; } >> "$DEST/AGENTS.md"
    echo "+ AGENTS.md 맨 아래에 작업 규칙을 이어 붙임"
  else
    echo "!! AGENTS.md가 이미 있음 — 아무것도 바꾸지 않고 멈춤."
    echo "   먼저 읽기:  cat AGENTS.md"
    echo "   이어 붙여도 되면:  bash $KIT/install.sh --append"
    exit 1
  fi
else
  cp "$KIT/AGENTS.md" "$DEST/AGENTS.md" && echo "+ AGENTS.md"
fi

# 스킬은 .agents/skills 에. Codex 보안 상자 안에서 실행하면 .agents 가 읽기 전용이라 못 만든다
# → 그때는 harness-skills/ 에 넣고, AGENTS.md 끝에 「거기서 직접 읽어」를 덧붙인다.
SK="$DEST/.agents/skills"
if ! { mkdir -p "$SK" 2>/dev/null && [ -w "$SK" ]; }; then
  SK="$DEST/harness-skills"
  mkdir -p "$SK"
  echo "!! .agents 폴더에 쓸 수 없음(Codex 보안 상자 안에서 실행한 듯) → 스킬을 harness-skills/ 에 넣음"
  printf '\n스킬 파일은 harness-skills/<이름>/SKILL.md 에 있어. 스킬 목록에 없으니 쓸 때마다 그 파일을 직접 읽고 따라.\n' >> "$DEST/AGENTS.md"
fi
for s in "$KIT"/.agents/skills/*/; do
  n="$(basename "$s")"
  if [ -e "$SK/$n" ]; then
    echo "!! 스킬 $n 이미 있음 — 건너뜀"
  else
    cp -r "$s" "$SK/$n" && echo "+ 스킬 $n"
  fi
done

case "$KIT/" in
  "$DEST"/*) echo "!! 하네스 폴더가 작업 폴더 안에 있음 — 설치는 끝났으니 커밋이 꼬이지 않게 지우기:  rm -rf \"$KIT\"" ;;
esac

echo "끝. 이제 codex를 켜고(업데이트 창은 Skip) /status 에서 AGENTS.md가 잡혔는지 확인."
