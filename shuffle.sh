f1="Flashing"
f2="Not_Flashing"
f3="Unknown"

f1t="Flashing_Test"
f2t="Not_Flashing_Test"
f3t="Unknown_Test"

if [ ! -d "$f1t" ]; then
    mkdir $f1t
    a=$(ls $f1/ -1 | wc -l)
    b=$(($a/10))
    echo "Moving $b files from $f1 to $f1t"
    ls $f1/ |sort -R| tail -n $b |while read file; do
        mv $f1/$file $f1t/$file 
    done
fi

if [ ! -d "$f2t" ]; then
    mkdir $f2t
    a=$(ls $f2/ -1 | wc -l)
    b=$(($a/10))
    echo "Moving $b files from $f2 to $f2t"
    ls $f2/ |sort -R| tail -n $b |while read file; do
        mv $f2/$file $f2t/$file 
    done
fi

if [ ! -d "$f3t" ]; then
    mkdir $f3t
    a=$(ls $f3/ -1 | wc -l)
    b=$(($a/10))
    echo "Moving $b files from $f3 to $f3t"
    ls $f3/ |sort -R| tail -n $b |while read file; do
        mv $f3/$file $f3t/$file 
    done
fi
