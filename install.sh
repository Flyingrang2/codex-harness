#!/usr/bin/env bash
# 작업 폴더에 작업 규칙(AGENTS.md)과 스킬(.agents/skills)을 복사한다. 이미 있는 파일은 덮어쓰지 않는다.
# 사용: 작업 폴더에서  bash /tmp/kit/install.sh
#       작업 폴더에 AGENTS.md가 이미 있으면 아무것도 안 하고 멈춘다 → 그 파일을 먼저 읽고,
#       이어 붙여도 되겠다고 판단했을 때만  bash /tmp/kit/install.sh --append
set -e
KIT="$(cd "$(dirname "$0")" && pwd)"
APPEND=0
[ "$1" = "--append" ] && { APPEND=1; shift; }
DEST="${1:-$PWD}"

echo "설치 위치: $DEST"
ls "$DEST" | head -20
ls "$DEST" | grep -qi '^readme' || echo "!! 여기에 README가 안 보임 — 작업 폴더가 맞는지 확인할 것"

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

mkdir -p "$DEST/.agents/skills"
for s in "$KIT"/.agents/skills/*/; do
  n="$(basename "$s")"
  if [ -e "$DEST/.agents/skills/$n" ]; then
    echo "!! 스킬 $n 이미 있음 — 건너뜀"
  else
    cp -r "$s" "$DEST/.agents/skills/$n" && echo "+ 스킬 $n"
  fi
done

echo "끝. 이제 codex를 켜고(업데이트 창은 Skip) /status 에서 AGENTS.md가 잡혔는지 확인."
