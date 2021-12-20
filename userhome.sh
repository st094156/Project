#!/bin/bash

opt=
filename=
loginname=


for arg in "$@"
do
    
    if [[ "$opt" == 1 && -z "$filename" ]] #filename
    then
        filename=$arg
        opt=2
    fi
    
    if [[ -z "$opt_f" && "$arg" == "-f" ]]
    then
        opt=1 #Значит следующий файл
    else
        opt=2 #Значит следующий пользователь
    fi
    
    if [[ "$opt" == 2 && -z "$loginname" ]] #loginname
    then
        loginname=$arg
    fi
done

if [[ -z "$filename" ]]
then
    filename="etc/passwd"
    cd /
fi

if [[ -z "$loginname" ]]
then
    loginname=$USER
fi

if [[ ! -f "$filename" ]]
then
    echo -e "\033[31mERROR: file '$filename' doesn't exist." >&2
    exit 2
fi

endname="$(grep "^${loginname}:" "$filename")"

if [[ -z "$endname" ]]
then
    echo -e "\033[31mERROR: login '$loginname' doesn't exist." >&2
    exit 1
fi

#echo "$endname"

endname="${endname%:*}"
endname="${endname##*:}"
echo "$endname"
                
exit 0
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
