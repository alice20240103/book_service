# 1단계: Maven을 사용하여 스프링부트 프로젝트 빌드
FROM maven:3.8.4-openjdk-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# 2단계: Nginx와 Spring Boot를 포함한 최종 이미지 생성
FROM openjdk:17-jdk AS app
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

# 3단계: Nginx 설치
RUN apt-get update && apt-get install -y nginx

# Nginx 설정 파일 복사
COPY nginx.conf /etc/nginx/nginx.conf

# 80번 포트와 8080번 포트 노출
EXPOSE 80
EXPOSE 8080

# ENTRYPOINT 설정: Spring Boot 애플리케이션과 Nginx를 동시에 실행
CMD ["sh", "-c", "java -jar app.jar & nginx -g 'daemon off;'"]

