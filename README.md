$ gh pr create --title "백업 로그 기록 기능 추가" \
> --body "백업이 끝나면 backup.log에 백업 일시와 파일명을 기록합니다." \
> --base main
> --head feature/backup-log # 생략 가능
$ gh pr view --web
