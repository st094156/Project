#!/bin/bash

opt_v=
opt_d=
opt_rzd= 

for arg in "$@"
do
    if [[ -z "$opt_rzd" && "${arg:0:1}" == "-" ]]
    then
        case $arg in
        --) opt_rzd=1
            ;;
        -h) echo "This command will rename files by adding suffic after file's names:"
            echo "$0 [-h] [-v] [-d] [--] [suffix] [files]"
            echo "-h: print help;"
            echo "-v: verbose output: print source and renamed files;"
            echo "-d: dry run: no rename."
            exit 0
            ;;
        -v) opt_v=1
            ;;
        -d) opt_d=1
            ;;
        *)  echo -e "\033[31mERROR: Invalid option '$arg'. Type $0 -h for help." >&2
            exit 2
            ;;
        esac
    fi
done



opt_rzd=
suf=
filename=
error=

for src in '$@'
do
    if [[ "$opt_rzd" || "${src:0:1}" != "-" ]]
    then
        if [[ -z $suf ]]
        then
            suf=$src
        else
            filename=1
            name="${src%.*}"
            ext="${src#$name}"
            
            if [[ ! -f $src ]]
            then
                echo -e "\033[31mERROR: file '$src' doesn't exist. Type $0 -h for help." >&2
                error=1
            else
                if [[ "$opt_d" || "$opt_v" ]]
                then
                    echo "'$src' -> '$name$suf$ext'"
                fi
                
                if [[ -z "$opt_d" ]]
                then
                    if ! mv -- "$src" "$name$suf$ext"
                    then
                        error=1
                    fi
                fi
            fi
        fi
    elif [[ "$src" == "--" ]]
    then
        opt_rzd=1
    fi
done


if [[ -z "$suf" ]]
then
    echo -e "\033[31mERROR: No suffix given. Type $0 -h for help." >&2
    exit 2
fi


if [[ -z "$filename" ]]
then
    echo -e "\033[31mERROR: No file names. Type $0 -h for help." >&2
    exit 2
fi
        
    
if [[ -n $error ]]
then
    exit 1
else
    exit 0
fi
    
    
    
    
 
