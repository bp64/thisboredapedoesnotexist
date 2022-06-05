usage() {
   # function defining expected usage of script
   echo "Usage: download_apes.sh [-h] <dest_dir>"
}

exit_abnormal() {
    # signal an abnormal exit from the program
    usage
    exit 1
}

# parse all options (no long options in bash scripts)
# one at a time into the "option" var
while getopts ":h" option; do
   case $option in 
      h) # display usage
         usage
         exit;;
      
      *) # extra args
         exit_abnormal;;
   esac
done

# check 1 argument passed in
if [ ! $# -eq 1 ]
then
    echo "script requires 1 arguments"
    exit_abnormal
fi

# download apes images
git clone https://github.com/skogard/apebase apebase

RAW_DIR="apebase/ipfs"
if [ ! -d $RAW_DIR ] 
then
    rm -rf apebase
    echo "issue with fat ape data source"
    exit 1
fi

DEST_DIR=$1
if [ ! -d $DEST_DIR ] 
then
    mkdir -p $DEST_DIR
fi

for f in $RAW_DIR/*;
do
    mv "$f" "$DEST_DIR/$(basename $f).png"; 
done
rm -rf apebase

echo "done!"
