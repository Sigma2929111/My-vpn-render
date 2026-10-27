FROM alpine:latest

# Устанавливаем утилиты для скачивания
RUN apk add --no-cache curl unzip

# Скачиваем и распаковываем Xray-core (движок VLESS)
RUN curl -L -o xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    unzip xray.zip && mv xray /usr/local/bin/ && rm xray.zip

# Копируем скрипт запуска
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Render динамически назначает порт, по умолчанию будет 10000
EXPOSE 10000

CMD ["/start.sh"]
