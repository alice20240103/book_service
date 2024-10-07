# 1단계: Maven을 사용하여 스프링부트 프로젝트 빌드
FROM maven:3.8.4-openjdk-17 AS build
WORKDIR /app
COPY . . 
RUN mvn clean package -DskipTests

# 2단계: 빌드된 JAR파일과 keystore 파일을 실행할 OPENJDK 이미지를 이용하여 Docker 이미지 생성
FROM openjdk:17-jdk
VOLUME /uploadtest
WORKDIR /app

# keystore 디렉토리 생성 및 권한 설정
RUN mkdir -p /app/keystore && chown -R ubuntu:ubuntu /app/keystore

# JAR 파일 복사
COPY --from=build /app/target/*.jar app.jar

# keystore 파일 복사 (여기서는 빌드 과정에서 keystore를 포함하지 않으므로, EC2에서 처리할 것)
# COPY --from=build /app/keystore/keystore.p12 /app/keystore/keystore.p12

ENTRYPOINT ["java"]
CMD ["-jar", "app.jar"]
