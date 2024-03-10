# Указание базового образа для этапа сборки
FROM openjdk:11-jdk-slim as build
WORKDIR /app

# Копирование файлов проекта в рабочую директорию
COPY . ./

# Предварительная загрузка зависимостей для ускорения последующих сборок
RUN ./gradlew --no-daemon dependencies

# Сборка приложения
RUN ./gradlew --no-daemon build

# Новый этап сборки для создания финального образа
FROM openjdk:11-jre-slim
WORKDIR /app

# Копирование собранного исполняемого JAR файла в финальный образ
COPY --from=build /app/build/libs/*.jar /app/app.jar

# Команда для запуска приложения
CMD ["java", "-jar", "/app/app.jar"]