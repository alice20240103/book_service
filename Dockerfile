# 1단계: Maven을 사용하여 스프링부트 프로젝트 빌드
FROM maven:3.8.4-openjdk-17 AS build
WORKDIR /app
COPY . . 
RUN mvn clean package -DskipTests

# 2단계: 빌드된 JAR파일과 keystore 파일을 실행할 OPENJDK 이미지를 이용하여 Docker 이미지 생성
FROM openjdk:17-jdk
VOLUME /uploadtest
WORKDIR /app

# keystore 디렉토리 생성
RUN mkdir -p /app/keystore

# JAR 파일 복사
COPY --from=build /app/target/*.jar app.jar

# 필요한 경우, 아래와 같이 `USER`를 설정할 수 있음
# USER ubuntu

ENTRYPOINT ["java"]
CMD ["-jar", "app.jar"]
