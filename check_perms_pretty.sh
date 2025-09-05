#!/bin/bash
# Проверка комбинаций прав доступа к директории
# Автор: Овезов Мерген (пример для лабораторной)

TESTDIR=~/permtest
TESTFILE=file.txt

# Создаём тестовую директорию и файл
rm -rf "$TESTDIR"
mkdir "$TESTDIR"
echo "hello" > "$TESTDIR/$TESTFILE"

printf "%-6s %-6s %-4s %-4s %-4s %-6s %-6s\n" "Octal" "Rights" "ls" "cd" "cat" "create" "rm"
echo "-----------------------------------------------------------"

# Перебор всех комбинаций прав (0..7)
for mode in {0..7}; do
    chmod $mode$mode$mode "$TESTDIR" 2>/dev/null
    rights=$(stat -c "%A" "$TESTDIR" | cut -c 2-4)  # rwx-представление

    # Проверка операций
    ls "$TESTDIR" >/dev/null 2>&1 && ls_res="+" || ls_res="-"
    cd "$TESTDIR" >/dev/null 2>&1 && cd_res="+" || cd_res="-"
    cat "$TESTDIR/$TESTFILE" >/dev/null 2>&1 && cat_res="+" || cat_res="-"
    echo "test" > "$TESTDIR/newfile" 2>/dev/null && create_res="+" || create_res="-"
    rm -f "$TESTDIR/$TESTFILE" >/dev/null && rm_res="+" || rm_res="-"

    # Восстанавливаем файл для следующей итерации
    echo "hello" > "$TESTDIR/$TESTFILE"

    # Вывод строки
    printf "%-6s %-6s %-4s %-4s %-4s %-6s %-6s\n" "$mode$mode$mode" "$rights" "$ls_res" "$cd_res" "$cat_res" "$create_res" "$rm_res"
done

# Удаляем тестовую директорию
rm -rf "$TESTDIR"
