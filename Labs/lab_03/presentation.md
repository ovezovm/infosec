# Preamble

## Author
author:
  name: Овезов Мерген
  degrees: Студент
  email: 1032234249@pfur.ru
  affiliation:
    - name: Российский университет дружбы народов
      country: Российская Федерация
      postal-code: 117198
      city: Москва
      address: ул. Миклухо-Маклая, д. 6
## Title
title: Лабораторная работа N3
subtitle: Права доступа и атрибуты файлов для групп пользователей
license: CC BY
date: 2025-09-05
## Generic options
lang: ru-RU
crossref:
  lof-title: Список иллюстраций
  lot-title: Список таблиц
  lol-title: Листинги
## Formats
format:
  beamer:
    toc: true
    toc-title: Содержание
    number-sections: true
    colorlinks: false
    toc-depth: 2
    slide_level: 2
    aspectratio: 169
    section-titles: true
    theme: metropolis
    themeoptions: progressbar=frametitle,sectionpage=progressbar,numbering=fraction
    babel-lang: russian
    babel-otherlangs: english
  revealjs:
    transition: slide
    margin: 0.2
    smaller: false
    output-ext: html
    theme: beige
---

# Информация

## Докладчик

:::::::::::::: {.columns align=center}
::: {.column width="70%"}

- Овезов Мерген
- Студент
- Российский университет дружбы народов
- [1032234249@pfur.ru](mailto:1032234249@pfur.ru)

:::
::: {.column width="30%"}

<!-- Место для фото -->

:::
::::::::::::::

# Вводная часть

## Цель

Целью данной работы является приобретение практических навыков установки операционной системы на виртуальную машину, настройки минимально необходимых для дальнейшей работы сервисов.

# Ход работы

## Создание пользователя guest2

```bash
sudo adduser guest2
```

## Вход под пользователем guest2

_(Скриншот входа)_

## Создание группы group1 и добавление в неё guest2

```bash
sudo groupadd group1
sudo usermod -aG group1 guest2
```

## Назначение группы директории

```bash
chgrp group1 /home/guest/dir1
```

## Назначение прав группе на директорию

```bash
chmod 770 /home/guest/dir1
```

## Проверка создания файла от имени guest2

_(Скриншот проверки)_

## Удаление guest2 из группы и повторная проверка

```bash
sudo gpasswd -d guest2 group1
```

## Снятие всех прав с директории

```bash
chmod 000 /home/guest/dir1
```

# Выводы

В ходе выполнения работы были:
- Созданы пользователи и группы.
- Настроены права доступа для группы.
- Проверено влияние прав на возможность выполнения операций другим пользователем.
- Определены минимальные права для выполнения операций.
```

