#!/bin/sh
recursive=  CWD=$PWD
echo "Enter the directory to put your images"
read dir_to
while getopts r:d: opt; do
  case $opt in
  r)
      recursive=1
      ;;
  d)
      CWD=$OPTARG
      ;;
  esac
done

shift $((OPTIND - 1))


function Sorter {
echo "Entering $CWD"
FILES_AND_DIRS=$(ls $CWD)
cd $CWD
for x in $FILES_AND_DIRS; do
    echo "Processing file ${x}"
    if [ -d "$x" ] && [ -n "$recursive" ] 
    then
            echo "Entering $x"
            CWD=$x Sorter
    fi           
    if [ -f "$x" ] && echo $x | grep -q -E '^.*(jpg|png|gif)$' 
    then
            echo "Found image $x"
            ( feh "$x" & )
            read confirm 
            killall feh
            [ "$confirm" != "" ] && move_to_dir_if_exist $dir_to $x
    fi   
done
}

function move_to_dir_if_exist {
MYDIR=$1
MYFILE=$2
echo "Copying $1 into $2"
if [ -d $MYDIR ] 
then
    mv $MYFILE $MYDIR
fi
}

Sorter
