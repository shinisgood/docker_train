FROM python:3
#./Dockerfile
#기반이 될 이미지/ 우리가 기반을 파이썬으로 만들겠다/ 이건 꼭 있어야해

WORKDIR /usr/src/app
# 작업디렉토리(default)설정/ 로컬이 아니고, 이미지를 생성하고 구동시켰을 때의 위치


COPY requirements.txt ./
## Install packages
#현재 패키지 설치 정보를 도커 이미지에 복사/ 독커파일에있는 모든 패키지 정보들을 여기에저장을 >해놓는것

RUN pip install -r requirements.txt
#설치정보를 읽어 들여서 패키지를 설치

COPY . .
## Copy all src files
#현재경로에 존재하는 모든 소스파일을 이미지의 기본 디폴트 위치(작업디렉토) 복사



EXPOSE 8000
## Run the application on the port 8080
#8000번 포트를 외부에 개방하도록 설정
# 표트포워딩이 8000포트로 내 컴퓨터에 요청이 들어오면 컨테이너 8000이 개방되어있으니까 그 컨테>이너로 다시 전달해주기 위해서 열어주고 있는거

#CMD ["python", "./setup.py", "runserver", "--host=0.0.0.0", "-p 8080"]
# 장고할때 런서버를 하는건 개발용 서버이기 때문 운영할 때에는 runserver 을 쓰지>않아..

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "docker_train.wsgi:application"]
#그래서 런서버 대신 gunicorn을 사용해서 서버를 실행
