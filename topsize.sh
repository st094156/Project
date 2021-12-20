#!/bin/bash

opt_h=
opt_N=
opt_minsize=
opt_rzd= 
dirr=

for arg in "$@"
do
    if [[ "$opt_rzd" || ("${arg:0:1}" != "-" && "$opt_minsize" != "-1" ) ]]
    then
        if [[ -z "$dirr" ]]
        then
            dirr=$arg 
        else
            echo -e "\033[31mERROR: Invalid option '$arg'. Type $0 --help for help." >&2
            exit 1
        fi
    fi
    
    if [[ "$opt_minsize" == "-1" ]]
    then
        opt_minsize=$arg
    fi
    
    if [[ -z "$opt_rzd" && "${arg:0:1}" == "-" ]]
    then
        case $arg in
        --help) echo "This command will show N most big files bigger than minsize"
            echo "$0 [--help] [-h] [-N] [-s minsize] [--] [dir]"
            echo "--help: print help;"
            echo "-h: show size in better format;"
            echo "-N: Number of files; Default: 10"
            echo "-s minsize: Minimum size; Default: 1 Byte"
            exit 0
            ;;
        --) opt_rzd=1
            ;;
        -h) opt_h=1
            ;;
        -1* | -2* | -3* | -4* | -5* | -6* | -7* | -8* | -9*) opt_N=$arg
            ;;
        -s) opt_minsize=-1
            ;;
            
        *)  
            if [[ "${arg#-}" =~ $re ]]
            then
                opt_N=$arg
            else
                echo -e "\033[31mERROR: Invalid option '$arg'. Type $0 --help for help." >&2
                exit 1
            fi
            ;;
        esac
    fi
    
done

if [[ -z "$opt_N" ]]
    then 
        opt_N=-10
    fi
    
if [[ -z "$opt_minsize" ]]
    then 
        opt_minsize=1c
    fi
    
if [[ -z "$dirr" ]]
    then
        dirr=.
    fi
    
    
#echo $opt_h
#echo $opt_N
#echo $opt_minsize
#echo $dirr
   



if [[ -z "$opt_N" ]]
    then 
        if [[ -z "$opt_h" ]]
            then
                find "$dirr" -type f -size "+${opt_minsize}" -exec du -b {} \; | sort -hr
            else
                find "$dirr" -type f -size "+${opt_minsize}" -exec du -bh {} \; | sort -hr
            fi
    else
        if [[ -z "$opt_h" ]]
            then
                find "$dirr" -type f -size "+${opt_minsize}" -exec du -b {} \; | sort -hr | head $opt_N
            else
                find "$dirr" -type f -size "+${opt_minsize}" -exec du -bh {} \; | sort -hr | head $opt_N
            fi
    fi


exit 0
