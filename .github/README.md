# codex-harness — 코딩 에이전트와 일하는 방법

Codex 같은 코딩 에이전트에게 데이터·코드 과제를 맡길 때 쓰는 **작업 규칙과 점검 절차** 모음입니다.
과제 답이나 과제용 코드는 들어 있지 않습니다. 「어떻게 일하나」만 담았습니다.

## 들어 있는 것
| 파일 | 하는 일 |
|---|---|
| `AGENTS.md` | 항상 지킬 작업 규칙 — 판단은 사람이(README·담당자 답에 없는 기준은 정하지 않고 선택지별 숫자만 보여 줌), 코드를 고치면 업무 말로 설명 + 고치기 전후 숫자, 기록은 `notes/`(담당자 대화 QA.md, 스킬 밖 질문 ASK.md, 매 턴 한 줄 LOG.md · 시각은 한국시간 시:분) |
| `harness-skills/explain` | 「설명해 줘」 — 계산 전에 과제 요약·데이터 파일·열 뜻·낯선 용어와 현장 맥락을 쉽게 풀어 `notes/EXPLAIN.md`로 |
| `harness-skills/issues` | 「특이사항 봐 줘」 — 결과를 바꿀 수 있는데 아직 안 정해진 기준을 카드로(본 것 · 왜 생긴 것 같나 · 정해야 할 것 · 왜 물어야 하나 · 상태) `notes/ISSUES.md`. 질문 문장은 사람이 |
| `harness-skills/check` | 「검산해 줘」 — 특이사항 카드를 다른 방법으로 다시 세고 원본 줄을 그대로 보여 줌, 원인이 근거인지 추측인지 표시 `notes/CHECK.md`. 새 Codex 세션에서 권장 |
| `harness-skills/verify` | 「검증해 줘 · 제출 전 점검」 — README 규칙·확정 기준 대조, 다른 방법으로 재계산(더한 원본 행까지), 경계 사례, 테스트, 다시 실행, 제출 파일 점검 `notes/VERIFY.md` |

## 쓰는 법
과제 폴더 터미널에서 두 줄:
```bash
git clone https://github.com/flyingrang2/codex-harness /tmp/kit
bash /tmp/kit/install.sh
codex
```
또는 Codex에게 한 문장: 「flyingrang2/codex-harness 클론하고, 그 안의 install.sh 실행해. 끝나면 클론한 폴더는 지워.」 → 끝나면 Codex를 껐다 다시 켠다(AGENTS.md는 켤 때만 읽는다).

`install.sh`는 과제 README가 있는 폴더를 찾아서 `AGENTS.md`와 `harness-skills/`만 복사하고, 끝에 설치 결과(✅/❌)를 보여 준다. 이미 있는 파일은 건드리지 않는다. 스킬은 Codex 스킬 목록에 뜨지 않으므로 AGENTS.md가 「부르는 말을 들으면 harness-skills/의 파일을 직접 읽어라」라고 안내한다.

## 원칙
- 판단은 사람이, 실행과 점검은 에이전트가. 에이전트는 기준이 애매하면 멈추고 묻는다.
- 「완료」 메시지는 완료가 아니다. 숫자·실행 결과로 확인한다.

## 라이선스
MIT — 누구나 자유롭게 쓰고 고쳐도 됩니다.
