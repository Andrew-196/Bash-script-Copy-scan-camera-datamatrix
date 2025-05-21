#!/bin/bash

echo "----------------------------------------------------------"
echo "HELLO $USER"
current_date="$(date +'%d.%m.%Y')"
current_time="$(date +'%H:%M')"
host_ip="$(hostname -I)"
echo "----------Проверка срабатывала ли камера сегодня----------"

cd /home/user1/192.168.123.120/
sorts="$(ls -ltr)"
printf "%s\n" "$sorts"
echo "----------------------------------------------------------"
echo "Сегодня $current_date Время $current_time"

if [  -d "$current_date" ]; then
  echo "Созданная папка за $current_date существует(камера срабатывала)."
  echo "----------------------------------------------------------"
  read -p "Скопировать данную папку? (y/n). При отмене будет предложено копирование файла - " copy
  read -p "Скопировать file.jpg из папки? (y/n) - " copy_file
  if [[ "$copy_file" == "y" || "$copy_file" == "yes" ]]; then #copy file.jpg
    read -p "Напишите число.jpg (формат) - " number
    find="/home/user1/192.168.123.120/$current_date"
    if [ -f "$find/$number" ]; then
      echo "----------------------------------------------------------"
      echo "Файл $number был найден в $current_date"
      echo "----------------------------------------------------------"
      backup_number="/home/user1/script-backup-camera/$current_date"
      mkdir -p "$backup_number"
      cp -r "/home/user1/192.168.123.120/$current_date/$number" "$backup_number"
      echo "Копирование file.jpg прошло успешно"
    else
      echo "----------------------------------------------------------"
      echo "Такого файла не существует"
    fi
  else
    echo "----------------------------------------------------------"
    echo "Вы отменили копирование файла.jpg"
  fi

  if [[ "$copy" == "y" || "$copy" == "yes" ]]; then #copy folder
    backup="/home/user1/script-backup-camera"
    mkdir -p "$backup"
    cp -r "/home/user1/192.168.123.120/$current_date" "$backup"
    echo "----------------------------------------------------------"
    echo "Копирование папки $current_date прошло успешно"
  else
    echo "----------------------------------------------------------"
    echo "Вы отменили копирование папки"
  fi
else
  echo "----------------------------------------------------------"
  echo "Созданной папки за сегодня $current_date не найдена(камера не срабатывала)."
fi
echo "----------------------------------------------------------"



