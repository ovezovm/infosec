## Front matter
title: "Отчет о выполнении лабораторной работы"
subtitle: "Лабораторная работа №1"
author: "Овезов Мерген"

## Generic options
lang: ru-RU
toc-title: "Содержание"

## Bibliography
bibliography: bib/cite.bib
csl: pandoc/csl/gost-r-7-0-5-2008-numeric.csl

## Pdf output format
toc: true
toc-depth: 2
lof: true
lot: true
fontsize: 12pt
linestretch: 1.3
papersize: a4
documentclass: scrreprt
numbersections: true

## I18n polyglossia
polyglossia-lang:
  name: russian
  options:
    - spelling=modern
    - babelshorthands=true
polyglossia-otherlangs:
  name: english

## I18n babel
babel-lang: russian
babel-otherlangs: english

## Fonts
mainfont: PT Serif
romanfont: PT Serif
sansfont: PT Sans
monofont: PT Mono
mainfontoptions: Ligatures=TeX
romanfontoptions: Ligatures=TeX
sansfontoptions: Ligatures=TeX,Scale=MatchLowercase
monofontoptions: Scale=MatchLowercase,Scale=0.9

## Biblatex
biblatex: true
biblio-style: "gost-numeric"
biblatexoptions:
  - parentracker=true
  - backend=biber
  - hyperref=auto
  - language=auto
  - autolang=other*
  - citestyle=gost-numeric

## Pandoc-crossref LaTeX customization
figureTitle: "Рис."
tableTitle: "Таблица"
listingTitle: "Листинг"
lofTitle: "Список иллюстраций"
lotTitle: "Список таблиц"
lolTitle: "Список листингов"

## Misc options
indent: true
header-includes:
  - \usepackage{indentfirst}
  - \usepackage{float}
  - \floatplacement{figure}{H}
---

# Цель работы

Выполнить первичную установку операционной системы.

# Задание

Установить и настроить операционную систему Rocky.

# Выполнение лабораторной работы

## Создание виртуальной машины

**Параметры:**
- ПО: Oracle VirtualBox  
- Имя: `Rockyovm`  
- Тип ОС: Linux (Red Hat 64-bit)  
- ОЗУ: 8192 МБ  
- CPU: 14 ядер  
- Диск: 80 ГБ (VDI)  
- Сеть: NAT  

![Создание виртуальной машины](image/klab1s1.png){#fig:vm width=100%}

## Установка ОС

- Язык: Русский (Россия)  
- Клавиатура: Английская (США) + Русская  
- Выбор программ: Server with GUI + DNS, FTP, NFS, почтовый сервер и др.  
- Пароль root: установлен (короткий, с предупреждением)  
- Пользователь: `ovm` с правами администратора  

![Выбор языка установки](image/klab1s3.png){#fig:lang width=100%}

## Проверка системы

```bash
dmesg
dmesg | grep -i "Linux version"
dmesg | grep -i "mhz"
dmesg | grep -i "CPU0"
dmesg | grep -i "memory"
dmesg | grep -i "Hypervisor detected"
dmesg | grep -i "filesystem"
```

# Выводы

Мы провели первичную установку и настройку ОС Rocky на виртуальной машине, проверили параметры системы и изучили базовые команды.

# Ответы на вопросы

## 1. Что содержит учётная запись пользователя?

- Имя пользователя (login)  
- Пароль  
- UID (User ID)  
- GID (Group ID)  
- Домашний каталог  
- Командная оболочка  

## 2. Команды терминала с примерами

```bash
man ls                  # справка по команде
cd /home/user           # переход в каталог
ls -l /home/user        # просмотр содержимого
du -sh ~/Documents      # размер каталога
mkdir mydir             # создать каталог
rmdir mydir             # удалить пустой каталог
rm file.txt             # удалить файл
rm -ri mydir            # удалить каталог с подтверждением
chmod u+x filename      # добавить право на выполнение
chmod 755 filename      # установить права
history                 # история команд
!5                      # выполнить 5-ю команду из истории
!!                      # повторить последнюю команду
Ctrl+R                  # поиск по истории
```

## 3. Что такое файловая система?

Файловая система — способ организации данных на носителях.

| ФС    | Характеристика |
|-------|----------------|
| Ext2  | Без журналирования, до 2 ТБ |
| Ext3  | С журналированием |
| Ext4  | До 1 ЭБ, современная |
| JFS   | Быстрое восстановление |
| XFS   | Высокая производительность |
| Btrfs | Контроль целостности, snapshot'ы |

## 4. Как посмотреть смонтированные ФС?

```bash
mount
cat /proc/mounts
cat /etc/fstab
df
```

## 5. Как удалить зависший процесс?

1. Найти PID:
   ```bash
   ps aux
   top
   htop
   ```
2. Завершить:
   ```bash
   kill PID        # мягко
   kill -9 PID     # принудительно
   killall имя_процесса
   pkill имя_процесса
   ```
