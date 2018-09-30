rm random_8789_labeled.csv

# Output flashing
echo "-------- WRITING FLASHING --------"
search_dir="Flashing"
for entry in "$search_dir"/*
do
    A=$(echo $entry | tr "_" "\n")
    ARRAY=($A)
    # Remove "foo from "fo/Forward"
    one=${Array{0}}
    one=$(basename $one)
    
    two=${Array[1]} 
    three=${Array[2]} 
    four=${Array[3]} 
    five=${Array[4]} 

    line=$"$one, $two, $three, $four, $five, 0"
    echo $line >> random_8789_labeled.csv
done

# Output Not_Flashing
echo "-------- WRITING NOT_FLASHING --------"
search_dir="Not_Flashing"
for entry in "$search_dir"/*
do
    A=$(echo $entry | tr "_" "\n")
    ARRAY=($A)
    # Remove "foo from "fo/Forward"
    one=${Array{1}}
    one=$(basename $one)
    
    two=${Array[2]} 
    three=${Array[3]} 
    four=${Array[4]} 
    five=${Array[5]} 

    line=$"$one, $two, $three, $four, $five, 1"
    echo $line >> random_8789_labeled.csv
done

# Output Unknown
echo "-------- WRITING UNKNOWN --------"
search_dir="Flashing"
for entry in "$search_dir"/*
do
    A=$(echo $entry | tr "_" "\n")
    ARRAY=($A)
    # Remove "foo from "fo/Forward"
    one=${Array{0}}
    one=$(basename $one)
    
    two=${Array[1]} 
    three=${Array[2]} 
    four=${Array[3]} 
    five=${Array[4]} 

    line=$"$one, $two, $three, $four, $five, 2"
    echo $line >> random_8789_labeled.csv
done
