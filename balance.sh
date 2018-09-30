f1="Flashing"
f2="Not_Flashing"


f1d="Not_Flashing_Removed"

if [ ! -d "$f1d" ]; then
    mkdir $f1d
    a=$(ls $f1/ -1 | wc -l)
    b=$(ls $f2/ -1 | wc -l)
    c=$(($b-$a))
    echo "Moving $c files from $f2 to $f1d"
    ls $f2/ |sort -R| tail -n $c |while read file; do
        mv $f2/$file $f1d/$file 
    done
fi

