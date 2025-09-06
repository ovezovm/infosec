
# Лабораторная работа №6
**Тема:** Знакомство с SELinux  
**Автор:** Овезов Мерген  

---

## 1. Цель работы
- Развить навыки администрирования ОС Linux.  
- Получить первое практическое знакомство с технологией **SELinux**.  
- Проверить работу SELinux на практике совместно с веб‑сервером Apache.

---

## 2. Выполнение лабораторной работы

### 2.1 Подготовка
- Установили Apache:
```bash
sudo dnf install httpd
```
- Задали имя сервера в конфигурации.
- Открыли порты для работы с протоколом HTTP.

---

### 2.2 Проверка работы SELinux и Apache
1. Проверили режим SELinux:
```bash
getenforce
sestatus
```
Ожидаемый результат: `Enforcing`, политика `targeted`.

2. Проверили работу веб‑сервера:
```bash
service httpd status
# или
/etc/rc.d/init.d/httpd status
```
Если не работает — запустили:
```bash
sudo systemctl start httpd
```
_Рис. 1: запуск http_

---

### 2.3 Определение контекста безопасности Apache
```bash
ps auxZ | grep httpd
# или
ps -eZ | grep httpd
```
Записали SELinux‑контекст процесса.  
_Рис. 2: контекст безопасности http_

---

### 2.4 Переключатели SELinux для Apache
```bash
sestatus -b | grep httpd
```
Многие параметры находятся в положении `off`.  
_Рис. 3: переключатели SELinux для http_

---

### 2.5 Анализ политик SELinux
```bash
seinfo
```
Определили множество пользователей, ролей, типов.

---

### 2.6 Проверка контекста каталогов и файлов
```bash
ls -lZ /var/www
ls -lZ /var/www/html
```
В `/var/www/html` изначально нет файлов.

---

### 2.7 Создание тестового файла
От root:
```bash
echo "Test" > /var/www/html/test.html
ls -Z /var/www/html/test.html
```
Контекст по умолчанию: `httpd_sys_content_t`.

Проверили доступ в браузере:  
`http://127.0.0.1/test.html` — файл отображается.  
_Рис. 4: создание html-файла и доступ по http_

---

### 2.8 Изучение контекстов httpd
```bash
man httpd_selinux
```
Основной контекст для веб‑контента — `httpd_sys_content_t`.

---

### 2.9 Изменение контекста на Samba
```bash
chcon -t samba_share_t /var/www/html/test.html
ls -Z /var/www/html/test.html
```
Проверка в браузере: доступ запрещён (`Forbidden`).  
_Рис. 5: ошибка доступа после изменения контекста_

---

### 2.10 Анализ ситуации
- Права доступа позволяют чтение, но SELinux блокирует доступ из-за несоответствия контекста.
- Проверили логи:
```bash
ls -l /var/www/html/test.html
tail /var/log/messages
cat /var/log/audit/audit.log | grep test.html
```
_Рис. 6: лог ошибок_

---

### 2.11 Изменение порта Apache
В `/etc/httpd/conf/httpd.conf`:
```
Listen 80
```
заменили на:
```
Listen 81
```
_Рис. 7: переключение порта_

Перезапустили Apache:
```bash
sudo systemctl restart httpd
```
Если порт не разрешён SELinux:
```bash
sudo semanage port -a -t http_port_t -p tcp 81
semanage port -l | grep http_port_t
```

---

### 2.12 Проверка доступа на новом порту
Вернули контекст:
```bash
chcon -t httpd_sys_content_t /var/www/html/test.html
```
Проверили в браузере:  
`http://127.0.0.1:81/test.html` — файл доступен.  
_Рис. 8: доступ по http на 81 порт_

---

### 2.13 Возврат настроек
- В конфиге Apache вернули `Listen 80`.
- Удалили привязку порта:
```bash
semanage port -d -t http_port_t -p tcp 81
```
- Удалили тестовый файл:
```bash
rm /var/www/html/test.html
```

---

## 3. Выводы
- Получены базовые навыки работы с SELinux.
- На практике проверено влияние контекста безопасности на доступ к файлам веб‑сервера.
- Освоена работа с изменением портов Apache и разрешениями SELinux.

---

## 4. Список литературы
- SELinux в CentOS  
- Веб‑сервер Apache
