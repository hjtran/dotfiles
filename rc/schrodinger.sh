### Bash settings for schrodinger development

# Set variables
SCHRODINGER=/scr/jtran/builds/2017-4/build; export SCHRODINGER; SCHRODINGER_SRC=/scr/jtran/builds/2017-4/source; export SCHRODINGER_SRC; SCHRODINGER_LIB=/software/lib; export SCHRODINGER_LIB
ds=$SCHRODINGER_SRC
dmsv=$SCHRODINGER_SRC'/mmshare/python/modules/schrodinger/application/msv'
dschr=$SCHRODINGER_SRC'/mmshare/python/modules/schrodinger'
dgui=$dmsv'/gui'
dprot=$dschr'/protein'
dt=$SCHRODINGER_SRC'/mmshare/python/test'
dtprot=$dt'/protein/'
dtmsv=$dt'/application/msv/'
dtgui=$dt'/application/msv/gui'

# Load aliases
source $dotfiles'/alias/schrodinger.sh'


### Functions
rbt () {
    ## Function for saving rbt ids for branches so I don't have to type in
    ## rbt -r and remember what number the review was.
    repo=$(basename `git rev-parse --show-toplevel`)
    branch=$(git branch | grep \* | cut -d ' ' -f2)
    rbt_id=$(grep "$repo:$branch" ~/.rbtids | cut -d":" -f3)
    if [ -z "$rbt_id" ]; then
        rbt_id=$(/usr/local/bin/rbt post | tee /dev/tty | egrep -o '[0-9]+' | head -1)
        echo -e "$repo:$branch:$rbt_id\n" >> ~/.rbtids
    else
        /usr/local/bin/rbt post -r $rbt_id
    fi
}

testdinger () {
    ## Function to run unit tests
    build_modules
    cd $SCHRODINGER/mmshare*/python/test
    make unittest TEST_ARGS="$1"
    cd -
}