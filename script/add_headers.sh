#/bin/bash
#echo 'exsample：for a in `find ./ -name "*.h" -exec basename {} \;`; do echo "#import \"$a\"" >> DTModelHeaders.h;  done'
#exit ()
if [ $# -gt 1 ];then
  path=$1
  name=$2
else
  echo "useage: ./add_headers.sh path header.h"
  exit 1
fi

for a in `find $path -name "*.h" -exec basename {} \;`;
do
  if [[ $a != $name ]]; then
    import="#import \"$a\""
    grep -q "$import" $name; test $? -eq 1 && echo $import >> $name;
  fi
done

