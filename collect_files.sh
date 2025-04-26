#!/bin/bash

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 input_dir output_dir"
  exit 1
fi

input_dir="$1"
output_dir="$2"

mkdir -p "$output_dir"

echo "Input Directory: $input_dir"
echo "Output Directory: $output_dir"

for file in $(find "$input_dir" -type f); do #https://losst.pro/komanda-find-v-linux файндом отсюда пользоваться смотрел как. Решает все проблемы этого мира (файнд, не сайт)
  filename=$(basename "$file")
  destination="$output_dir/$filename"

  if [ -e "$destination" ]; then
    name="${filename%.*}"
    ext="${filename##*.}"
    counter=1

    while [ -e "$output_dir/${name}_${counter}.${ext}" ]; do
      counter=$((counter + 1))
    done

    cp "$file" "$output_dir/${name}_${counter}.${ext}"
  else
    cp "$file" "$destination"
  fi
done

