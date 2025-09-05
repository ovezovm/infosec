# Preamble

## Author
author:
  name: Овезов Мерген
  degrees: Студент
  affiliation:
    - name: Российский университет дружбы народов
      country: Российская Федерация
      postal-code: 117198
      city: Москва
      address: ул. Миклухо-Маклая, д. 6
## Title
title: "Отчёт по лабораторной работе N3"
subtitle: "Права доступа и атрибуты файлов для групп пользователей"
license: "CC BY"
## Generic options
lang: ru-RU
number-sections: true
toc: true
toc-title: "Содержание"
toc-depth: 2
## Crossref customization
crossref:
  lof-title: "Список иллюстраций"
  lot-title: "Список таблиц"
  lol-title: "Листинги"
## Bibliography
bibliography:
  - bib/cite.bib
csl: _resources/csl/gost-r-7-0-5-2008-numeric.csl
## Formats
format:
  pdf:
    toc: true
    number-sections: true
    colorlinks: false
    toc-depth: 2
    lof: true
    lot: true
    documentclass: scrreprt
    papersize: a4
    fontsize: 12pt
    linestretch: 1.5
    babel-lang: russian
    babel-otherlangs: english
    cite-method: biblatex
    biblio-style: gost-numeric
    biblatexoptions:
      - backend=biber
      - langhook=extras
      - autolang=other*
    csquotes: true
    indent: true
    header-includes: |
      \usepackage{indentfirst}
      \usepackage{float}
      \floatplacement{figure}{H}
      \usepackage[math,RM={Scale=0.94},SS={Scale=0.94},SScon={Scale=0.94},TT={Scale=MatchLowercase,FakeStretch=0.9},DefaultFeatures={Ligatures=Common}]{plex-otf}
  docx:
    toc: true
    number-sections: true
    toc-depth: 2
---

# Цель работы

Получение практических навыков работы в консоли с атрибутами файлов для групп пользователей.

# Задание

1. Создать пользователей `guest` и `guest2`.
2. Создать группу `group1` и добавить в неё `guest2`.
3. Создать директорию `/home/guest/dir1` и назначить владельцем группы `group1`.
4. Настроить права доступа для группы и проверить возможность выполнения операций пользователем `guest2`.
5. Удалить `guest2` из группы и повторить проверку.
6. Снять все права с директории и проверить доступ.
7. Заполнить таблицы 3.1 и 3.2.

# Теоретическое введение

В UNIX‑подобных системах права доступа определяют, какие действия могут выполнять владелец, группа и остальные пользователи.  
Три базовых права:
- **r** — чтение (read)
- **w** — запись (write)
- **x** — выполнение (execute) или вход в директорию

Для директорий:
- `r` — просмотр списка файлов
- `w` — создание/удаление файлов
- `x` — доступ к содержимому по имени

Расширенные атрибуты (`lsattr`, `chattr`) позволяют дополнительно ограничивать операции, например, делать файл неизменяемым (`i`) или разрешать только дозапись (`a`).

# Выполнение лабораторной работы

## Создание пользователей
```bash
sudo adduser guest
sudo adduser guest2
```
_[Место для скриншота]_

## Создание группы и добавление пользователя
```bash
sudo groupadd group1
sudo usermod -aG group1 guest2
```
_[Место для скриншота]_

## Создание директории и назначение группы
```bash
mkdir /home/guest/dir1
chgrp group1 /home/guest/dir1
```
_[Место для скриншота]_

## Назначение прав группе
```bash
chmod 770 /home/guest/dir1
```
_[Место для скриншота]_

## Проверка доступа от имени `guest2`
```bash
echo "test" > /home/guest/dir1/file1
```
_[Место для скриншота]_

## Удаление `guest2` из группы и повторная проверка
```bash
sudo gpasswd -d guest2 group1
echo "test2" > /home/guest/dir1/file2
```
_[Место для скриншота]_

## Снятие всех прав
```bash
chmod 000 /home/guest/dir1
```
_[Место для скриншота]_

# Таблица 3.1 — Разрешённые действия для `guest2`

| Права на директорию | Права на файл | Просмотр (`ls`) | Вход (`cd`) | Чтение (`cat`) | Создание файла | Удаление файла |
|---------------------|---------------|-----------------|-------------|----------------|----------------|----------------|
| --- (000)           | r--           | –               | –           | –              | –              | –              |
| --x (001)           | r--           | –               | +           | +              | –              | –              |
| -w- (010)           | r--           | –               | –           | –              | –              | –              |
| -wx (011)           | r--           | –               | +           | +              | +              | +              |
| r-- (100)           | r--           | +               | –           | –              | –              | –              |
| r-x (101)           | r--           | +               | +           | +              | –              | –              |
| rw- (110)           | r--           | +               | –           | –              | +              | +              |
| rwx (111)           | r--           | +               | +           | +              | +              | +              |

# Таблица 3.2 — Минимальные права для `guest2`

| Операция                | Права на директорию | Права на файл |
|-------------------------|---------------------|---------------|
| Создание файла          | w + x               | —             |
| Удаление файла          | w + x               | —             |
| Чтение файла            | x                   | r             |
| Запись в файл           | x                   | w             |
| Перемещение файла       | w + x               | —             |
| Создание поддиректории  | w + x               | —             |
| Удаление поддиректории  | w + x               | x             |

# Выводы

В ходе работы:
- Созданы пользователи и группы.
- Настроены права доступа для группы.
- Проверено влияние прав на возможность выполнения операций другим пользователем.
- Определены минимальные права для выполнения операций.

# Список литературы{.unnumbered}

::: {#refs}
:::
```
