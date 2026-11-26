# Docker Compose 실습 


1. 실습 목표 
- Docker Compose를 이용해 여러 컨테니어를 함께 실행한다.
- Nginx와 웹 컨테이너의 동작을 확인한다.
- 웹 컨테이너를 Scale하여 여러 개 실행한다.
- docker compose down과 docker compose down -v의 차이를 확인한다.
- .env 파일을 Git에 올리지 않아야 하는 이유를 이해한다.


2. 컨테이너 실행 및 상태 확인
docker compose ps 명령어를 실행하여 컨테이너의 실행 상태를 확인하였다.
실행 결과 Redis 컨테이너 1개와 웹 컨테이너 3개가 실행 중이었으며, Redis와 웹 컨테이너 모두 healthy 상태를 확인하였다. 
Nginx 컨테이너도 Up 상태로 실행 중이었다.
ace@DESKTOP-NI3CD7E:~/devops/guestbook1$ docker compose ps
NAME                 IMAGE            COMMAND                  SERVICE   CREATED          STATUS                    PORTS
guestbook1-nginx-1   nginx:alpine     "/docker-entrypoint.…"   nginx     52 minutes ago   Up 51 minutes             0.0.0.0:8080->80/tcp, [::]:8080->80/tcp
guestbook1-redis-1   redis:7-alpine   "docker-entrypoint.s…"   redis     52 minutes ago   Up 52 minutes (healthy)   6379/tcp
guestbook1-web-1     guestbook1-web   "python app.py"          web       34 minutes ago   Up 34 minutes (healthy)   5000/tcp
guestbook1-web-2     guestbook1-web   "python app.py"          web       34 minutes ago   Up 28 minutes (healthy)   5000/tcp
guestbook1-web-3     guestbook1-web   "python app.py"          web       34 minutes ago   Up 34 minutes (healthy)   5000/tcp

3. 웹 컨테이너 Scale 및 호스트명 확인

웹 컨테이너를 3개로 실행한 후 각 컨테이너의 호스트명을 확인하였다.

docker exec guestbook1-web-1 hostname
docker exec guestbook1-web-2 hostname
docker exec guestbook1-web-3 hostname

실행 결과 
guestbook1-web-1  -> 43950fb88a1d
guestbook1-web-2  -> de11d3c2f24
guestbook1-web-3  -> 731f0f950d2c

그리고 캡쳐는 week07에 있습니다.


4. down 후 up과 down -v 후 up 비교

- docker compose down 후 docker compose up -d
컨테이너를 종료하고 다시 생성하였다. 일반적으로 Compose에서 관리하는 볼륨은 유지되므로 Redis 데이터가 삭제하지 않고 보존될 수 있다. 그러므로, 
7주차 실습에서 방명록 웹페이지 댓글 내용 기록이 삭제되지 않고 그대로 유지가 되었다.

- docker compose down -v 후 docker compose up -d
컨테이너를 종료하고 Compose에서 관리하는 관련 볼륨도 삭제한 뒤 서비스를 다시 실행하였다. 기존 볼륨 데이터는 삭제되므로 Redis 데이터가 모두 삭제된다.
볼륨까지 삭제된 후에 방명록 웹페이지에 다시 생성하여 들어가보면 댓글 내용 기록들이 모두 삭제되었다는 걸 볼 수 있다.


5. .env 파일을 Git에 올리지 않는 이유
.env 파일에는 Redis 비밀번호, 데이터베이스 접속 정보, API 키 등 중요한 환경변수가 포함될 수 있다. 이 파일을 GitHub에 올리면 다른 사람이 비밀번호나 인증 정보를 확인하여 악용할 위험이 있다.

따라서 .env 파일은 .gitignore에 등록하여 Git에 올라가지 않도록 하고, 다른 사람이 설정을 참고할 수 있도록 실제 비밀번호가 없는 .env.example 파일을 제공한다.

이를 통해 민감한 정보를 보호하고 안전하게 프로젝트를 관리할 수 있다.
