#!/bin/bash
#debug
#echo "$0, $1, $2, $3, $4"

if [[ ! -d "$1" ]]; then
{   
    echo "No $1 directory exists!"
    exit 1
}
fi

if [[ ! -f "$2" ]]; then
{
    echo "No template file exists!"
    exit 1
}
fi

if [[ ! $3 =~ ^[0-9]{2}/[0-9]{2}/[0-9]{4} ]]; then
{
    echo "Incorrect date format pleas use MM/DD/YYYY"
    exit 1
}
fi

if [[ ! -d "$4" ]]; then
{
    mkdir "$4"
}
fi

for files in $(ls $1) 
do
    if [[ $files =~ ^[0-9]{4}.item ]];then
    {
        awk -f 'awk1.awk' -v udate=$3 "$1/$files" > "g$files".sed
        check=$(sed -f sed1.sed "g$files".sed)
        if [[ "$check" == "DO NOTHING" ]]; then
        {  
            #echo "IT WORKED $files"
            #rm "g$files".sed
            continue
        }
        fi
        #echo "Here only once for $files"
        newfile=$(echo "$files" | awk -F '[.]' '{print ($1); }' )
        #echo "$newfile"
        sed -f "g$files".sed $2 > "$newfile".out
        mv "$newfile".out $4
        #rm "g$files".sed
    }
    fi
done #"$1/$files for ./data/item.item"
#echo "success"
