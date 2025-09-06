# Лабораторная работа №5
**Тема:** Дискреционное разграничение прав в Linux. Исследование влияния дополнительных атрибутов  
**Автор:** Овезов Мерген  

---

## 1. Цель работы
- Изучить механизмы изменения идентификаторов, применения **SetUID** и **Sticky-битов**.
- Получить практические навыки работы в консоли с дополнительными атрибутами.
- Рассмотреть работу механизма смены идентификатора процессов пользователей.
- Исследовать влияние бита **Sticky** на запись и удаление файлов.

---

## 2. Выполнение лабораторной работы

### 2.1 Подготовка
- Проверили наличие компилятора:
```bash
gcc -v
```
- Отключили SELinux до перезагрузки:
```bash
setenforce 0
getenforce   # Permissive
```
_Рис. 1: подготовка к работе_

---

### 2.2 Изучение механики SetUID

#### Создание программы `simpleid.c`
```c
#include <sys/types.h>
#include <unistd.h>
#include <stdio.h>

int main() {
    uid_t uid = geteuid();
    uid_t r_uid = getuid();
    gid_t gid = getgid();
    printf("e_uid = %d, r_uid = %d, gid = %d\n", uid, r_uid, gid);
    return 0;
}
```
Компиляция:
```bash
gcc simpleid.c -o simpleid
```
Запуск:
```bash
./simpleid
id
```
_Рис. 3: результат программы simpleid_

---

#### Программа `simpleid2.c` с выводом действительных идентификаторов
```c
#include <sys/types.h>
#include <unistd.h>
#include <stdio.h>

int main() {
    uid_t real_uid = getuid();
    uid_t e_uid = geteuid();
    gid_t gid = getgid();
    printf("real_uid = %d, e_uid = %d, gid = %d\n", real_uid, e_uid, gid);
    return 0;
}
```
Компиляция и запуск:
```bash
gcc simpleid2.c -o simpleid2
./simpleid2
```

---

#### Установка SetUID
От root:
```bash
chown root:guest /home/guest/simpleid2
chmod u+s /home/guest/simpleid2
ls -l simpleid2
```
Запуск от обычного пользователя:
```bash
./simpleid2
id
```
_Рис. 5: результат программы simpleid2_

---

#### Программа `readfile.c`
```c
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>

int main(int argc, char* argv[]) {
    unsigned char buffer[16];
    int fd = open(argv[1], O_RDONLY);
    read(fd, buffer, sizeof(buffer));
    for (int i = 0; i < sizeof(buffer); i++)
        printf("%02x ", (unsigned int)buffer[i]);
    printf("\n");
    close(fd);
    return 0;
}
```
Компиляция:
```bash
gcc readfile.c -o readfile
```

---

#### Проверка доступа через SetUID
- Запретили чтение файла `readfile.c` для обычных пользователей:
```bash
chown root:guest /home/guest/readfile.c
chmod 700 /home/guest/readfile.c
```
- Установили владельца root и SetUID для программы:
```bash
chown root:guest readfile
chmod u+s readfile
```
- Проверили чтение:
```bash
./readfile readfile.c
./readfile /etc/shadow
```
_Рис. 7: результат программы readfile_

---

### 2.3 Исследование Sticky-бита

1. Проверка наличия Sticky на `/tmp`:
```bash
ls -l / | grep tmp
```
2. Создание файла:
```bash
echo "test" > /tmp/file01.txt
```
3. Просмотр атрибутов и изменение прав:
```bash
ls -l /tmp/file01.txt
chmod o+rw /tmp/file01.txt
ls -l /tmp/file01.txt
```
4. Попытка дозаписи и перезаписи файла от другого пользователя:
```bash
echo "test2" >> /tmp/file01.txt
echo "test3" > /tmp/file01.txt
```
5. Попытка удаления файла от другого пользователя:
```bash
rm /tmp/file01.txt
```
6. Снятие Sticky-бита:
```bash
sudo chmod -t /tmp
```
7. Проверка удаления файла без Sticky:
```bash
rm /tmp/file01.txt
```
8. Возврат Sticky-бита:
```bash
sudo chmod +t /tmp
```
_Рис. 8: исследование Sticky-бита_

---

## 3. Выводы
- Изучены механизмы изменения идентификаторов, применения **SetUID** и **Sticky-бита**.
- Получены практические навыки работы в консоли с дополнительными атрибутами.
- Рассмотрена работа механизма смены идентификатора процессов пользователей.
- Исследовано влияние Sticky-бита на запись и удаление файлов.

---

## 4. Список литературы
- **КОМАНДА CHATTR В LINUX** — документация по использованию `chattr`.
