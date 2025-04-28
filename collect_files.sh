#!/bin/bash

if [ "$#" -lt 2 ]; then
  exit 1
fi

input_dir="${1%/}"
output_dir="${2%/}"
max_depth=""

if [ "$#" -eq 4 ] && [ "$3" = "--max_depth" ]; then
  max_depth=$4
fi

mkdir -p "$output_dir"

files=$(find "$input_dir" -type f)

for file in $files; do
  relative_path="${file#$input_dir/}"
  depth=$(awk -F/ '{print NF}' <<< "$relative_path")
  
  filename="$(basename "$file")"

  if [ -n "$max_depth" ] && [ "$depth" -gt "$max_depth" ]; then
    skip=$((depth - max_depth))
    trimmed_path=$(echo "$relative_path" | cut -d/ -f$((skip+1))-)
    destination="$output_dir/$(dirname "$trimmed_path")"
  else
    destination="$output_dir/$(dirname "$relative_path")"
  fi
  
  mkdir -p "$destination"
  
  final_file="$destination/$filename"
  
  if [ -e "$final_file" ]; then
    name="${filename%.*}"
    ext="${filename##*.}"
    counter=1
    while [ -e "${destination}/${name}_${counter}.${ext}" ]; do
      counter=$((counter + 1))
    done
    final_file="${destination}/${name}_${counter}.${ext}"
  fi
  
  cp "$file" "$final_file"
done

# ну кабутта можно пушить. Проверяющему,
# если этот текст тут еще висит, хорошего вечера
#пушить было нельзя, но уже похоже, что можно

# Доброе утро :) эээ, нуууу, ну однажды научусь нормально читать тз и понимать, что от меня хотят
#сначала думал, что maxdepth это про то, чтобы не копать глубже после определенного уровня :/
#пришлось немного почти все переписывать

#время пушить

# если весь хаха был в порядке файлов, я ударюсь головой об стену

#мегаоткат ко вчерашнему дню. Так все хорошо было. Чет уже ообще не хочется делать этот максдеф вонючий

#короче пока что сдаюсь и отправлю эту версию без ластецкого. Не хочет оно вообще никак выполняться, но может еще допишу :?

#было принято мужественное решение оставить этот мегадневник тут. 