# 1단계: Maven을 사용하여 스프링부트 프로젝트 빌드
FROM maven:3.8.4-openjdk-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# 2단계: 빌드된 JAR파일을 실행할 OPENJDK 이미지를 이용하여 Docker 이미지 생성
FROM openjdk:17-jdk
VOLUME /uploadtest
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar 
#COPY src/main/resources/keystore.p12 /app/keystore.p12
ENTRYPOINT ["java"]
CMD ["-jar", "app.jar", "--server.port=443", "--server.ssl.key-store=classpath:keystore.p12", "--server.ssl.key-store-password=your_password", "--server.ssl.keyStoreType=PKCS12", "--server.ssl.key-alias=your_key_alias"]