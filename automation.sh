#!/bin/bash

# 스크립트가 실행되는 디렉토리
WORK_DIR="/home/u/aflfast/forfuzzing"

# count 값을 저장할 파일
COUNT_FILE="$WORK_DIR/count.txt"

# count 파일이 없으면 초기화
if [ ! -f "$COUNT_FILE" ]; then
  echo 1 > "$COUNT_FILE"
fi

# 현재 count 값 읽기
count=$(cat "$COUNT_FILE")

# 출력 디렉토리 생성
OUTPUT_DIR="$WORK_DIR/output$count"
mkdir -p "$OUTPUT_DIR"

# afl-fuzz 실행
timeout 5h ./afl-fuzz -i in -o "$OUTPUT_DIR" -m none -C  -- ./main2 @@ &> "$OUTPUT_DIR/log.txt"

# top 실행
timeout 5h top -b -n6 -d3600 > "$OUTPUT_DIR/top.txt"

# count 값 증가 후 저장
count=$((count + 1))
echo $count > "$COUNT_FILE"

