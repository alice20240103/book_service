# 1단계: Maven을 사용하여 스프링부트 프로젝트 빌드
FROM maven:3.8.4-openjdk-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# 2단계: 빌드된 JAR 파일을 실행할 OpenJDK 이미지를 이용하여 Docker 이미지 생성
FROM openjdk:17-jdk
VOLUME /uploadtest
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar 
# SSL 관련 파일 복사 제거
# COPY src/main/resources/keystore.p12 /app/keystore.p12
ENTRYPOINT ["java"]
CMD ["-jar", "app.jar"]  # SSL 제거하고 8080 포트에서 실행
