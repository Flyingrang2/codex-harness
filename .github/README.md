# codex-harness — 코딩 에이전트와 일하는 방법

Codex 같은 코딩 에이전트에게 데이터·코드 과제를 맡길 때 쓰는 **작업 규칙과 점검 절차** 모음입니다.
과제 답이나 과제용 코드는 들어 있지 않습니다. 「어떻게 일하나」만 담았습니다.

## 들어 있는 것
| 파일 | 하는 일 |
|---|---|
| `AGENTS.md` | 항상 지킬 작업 규칙 — 판단은 사람이(README·담당자 답에 없는 기준은 정하지 않고 선택지별 숫자만 보여 줌), 코드를 고치면 업무 말로 설명 + 고치기 전후 숫자, 기록은 `notes/`(담당자 질문·답 QA.md, 매 턴 한 줄 LOG.md) |
| `.agents/skills/explain` | 「설명해 줘」 — 계산 전에 과제·데이터 파일·열·기존 코드·낯선 용어·README 규칙을 쉽게 풀어 `notes/EXPLAIN.md`로 |
| `.agents/skills/issues` | 「특이사항 봐 줘」 — 계산 실수나 결과를 바꿀 수 있는 사항을 무엇·몇 행·예시·결과에 주는 영향 표로(`notes/ISSUES.md`). 무엇을 물을지는 사람이 |
| `.agents/skills/verify` | 「검증해 줘 · 제출 전 점검」 — README·담당자 기준 대조, 다른 방법으로 재계산, 경계 사례, 테스트, 제출 파일 점검 |

## 쓰는 법
과제 폴더 터미널에서 두 줄:
```bash
git clone https://github.com/flyingrang2/codex-harness /tmp/kit
bash /tmp/kit/install.sh
codex
```
또는 Codex에게 한 문장: 「flyingrang2/codex-harness 클론하고, 그 안의 install.sh 실행해. 끝나면 클론한 폴더는 지워.」 → 끝나면 Codex를 껐다 다시 켠다(AGENTS.md는 켤 때만 읽는다).

`install.sh`는 과제 README가 있는 폴더를 찾아서 `AGENTS.md`와 `.agents/skills`만 복사한다. 이미 있는 파일은 건드리지 않는다.

## 원칙
- 판단은 사람이, 실행과 점검은 에이전트가. 에이전트는 기준이 애매하면 멈추고 묻는다.
- 「완료」 메시지는 완료가 아니다. 숫자·실행 결과로 확인한다.

## 라이선스
MIT — 누구나 자유롭게 쓰고 고쳐도 됩니다.
