# 4주차 - 자동화와 협업 

1. 오늘 배운 내용

- 반복 작업을 자동화하는 기초
- 텍스트 파일 생성 및 내용 확인
- 파일의 일부 내용 출력하기
- Git과 Github를 이용한 작업 관리


2. 새로 배운 명령어
- 텍스트 파일 생성
cd ~/devops/week04
mkdir -p test
cd test

cat > diary.txt << 'EOF'
월요일 - 리눅스를 배웠다.
화요일 - Git과 GitHub를 배웠다.
수요일 - 네트워크를 배웠다.
목요일 - 도커는 언제나 배울까?
EOF

- 파일 내용 확인
cat diart.txt

- 파일의 앞부분과 뒷부분 확인
head -2 diary.txt -> 앞 2줄 출력
tail -1 diary.txt -> 뒷 1줄 출력

- 전제 줄 수 출력
wc -l diary.txt


3. Git 브랜치와 커밋

브랜치를 사용하면 기존 작업과 분리된 공간에서 새로운 내용을 수정할 수 있다.

cd ~/devops

git branch
git switch -c feature/backup-log
git status
git diff week04/backup.sh

변경 내용을 확인한 뒤 커밋하고 원격 저장소에 푸시한다.

git add week04/backup.sh
git commit -m "feat: 백업 로그 기록 기능 추가"
git push -u origin feature/backup-log

5. Pull Request (PR)

Pull Request는 작업 브랜치에서 변경한 내용을 기준 브랜치에 반영하기 전에 변경 사항을 공유하고 검토하는 과정이다.

gh pr create --title "백업 로그 기록 기능 추가" \
  --body "백업이 끝나면 backup.log에 백업 일시와 파일명을 기록합니다." \
  --base main \
  --head feature/backup-log

gh pr view --web

6. Merge

검토가 완료된 PR을 Merge하여 작업 브랜치의 변경 내용을 main 브랜치에 반영한다.

gh pr merge --squash --delete-branch
git switch main
git pull --ff-only
git log --oneline -3