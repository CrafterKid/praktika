FROM openjdk:11-jdk as builder
WORKDIR application
COPY build/libs/backend-todo-list.jar application.jar
RUN java -Djarmode=layertools -jar application .jar extract

FROM openjdk:11-jdk
EXPOSE 8080
WORKDIR application
COPY --from=builder application/spring-boot-loader/ ./
COPY --from=builder application/dependencies/ ./
COPY --from=builder application/snapshot-dependencies/ ./
COPY --from=builder application/application/ ./
EXPOSE ["java", "org.springframework.boot.loader.JarLauncher"]
