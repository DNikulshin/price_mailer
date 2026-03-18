#!/bin/bash
# Установка сервиса рассылки прайс-листов
# Запускать: chmod +x setup.sh && ./setup.sh

set -e

echo "========================================="
echo "  Установка сервиса рассылки прайс-листов"
echo "========================================="

# Проверяем Python
if ! command -v python3 &> /dev/null; then
    echo "Python3 не найден. Пожалуйста, установите Python3."
    exit 1
fi

echo "Python3: $(python3 --version)"

# Создаём рабочую папку
INSTALL_DIR="price_mailer/run"
echo "Устанавливаю в $INSTALL_DIR ..."

mkdir -p "$INSTALL_DIR"
cp price_mailer/price_mailer.py "$INSTALL_DIR/"
cp price_mailer/config.json "$INSTALL_DIR/"
mkdir -p "$INSTALL_DIR/logs"
mkdir -p "$INSTALL_DIR/temp"

# Настраиваем cron: каждый день в 06:00 по Москве (UTC+3 = 03:00 UTC)
# Using absolute path for cron job
CRON_CMD="0 3 * * * cd $(pwd)/$INSTALL_DIR && /usr/bin/python3 price_mailer.py >> $(pwd)/$INSTALL_DIR/logs/cron.log 2>&1"

# Проверяем, не добавлена ли уже задача
(crontab -l 2>/dev/null | grep -v "price_mailer"; echo "$CRON_CMD") | crontab -

echo ""
echo "========================================="
echo "  Установка завершена!"
echo "========================================="
echo ""
echo "  Папка:   $INSTALL_DIR"
echo "  Расписание: каждый день в 06:00 МСК (03:00 UTC)"
echo ""
echo "  ⚠️  Не забудьте:"
echo "  1. Отредактировать $INSTALL_DIR/config.json"
echo "     — вставить пароли приложений"
echo "  2. Проверить часовой пояс сервера:"
echo "     timedatectl"
echo "     Если на сервере МСК — замените '0 3' на '0 6' в crontab -e"
echo ""
echo "  Тестовый запуск:"
echo "  cd $INSTALL_DIR && python3 price_mailer.py"
echo ""
