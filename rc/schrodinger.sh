### Bash settings for schrodinger development

############## Environment Setup Functions
set_schrodinger_v () {
    SCHRODINGER=/scr/jtran/builds/$1/build
    export SCHRODINGER
    SCHRODINGER_SRC=/scr/jtran/builds/$1/source
    export SCHRODINGER_SRC
    SCHRODINGER_LIB=/software/lib
    export SCHRODINGER_LIB
}

schrodinger_v () {
    echo '$SCHRODINGER: '$SCHRODINGER
    echo '$SCHRODINGER_SRC: '$SCHRODINGER_SRC
}

schropy3 () {
    export SCHRODINGER_PYTHON3=true
    export SCHRODINGER=/scr/jtran/builds/2018-1py3/build
}
schropy2 () {
    unset SCHRODINGER_PYTHON3
    export SCHRODINGER=/scr/jtran/builds/2018-1/build
}

############## Environment Setup
# Set variables
set_schrodinger_v 2018-1
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


############## General Functions
testdinger () {
    ## Function to run unit tests
    start_dir=$PWD
    ## Default, run failed tests from last run
    test_args=$failed_tests
    build_modules
    while getopts "fdrn:" opt; do
      case $opt in
        f)
            cd $SCHRODINGER_SRC/mmshare/python/test
            test_args=$(find . -name "*.py" | sed 's/\.\///g' | fzf)
          ;;
        d)
            cd $SCHRODINGER_SRC/mmshare/python/test
            test_args=$(find . -type d | sed 's/\.\///g' | fzf)
          ;;
        n)
            test_args=$OPTARG
          ;;
        r)
            test_args=$old_test_args
        ;;
        \?)
          echo "Invalid option: -$OPTARG" >&2
          ;;
      esac
    done
    cd $SCHRODINGER/mmshare*/python/test
    failed_tests=$(script -q /dev/null make unittest TEST_ARGS="$(echo $test_args)" | tee /dev/tty | egrep -o '[A-Za-z][^ ]+::[^ ]+::[^ ]+')
    old_test_args=$test_args
    cd $start_dir
    unset OPTIND
}

rbt () {
    ## Function for saving rbt ids for branches so I don't have to type in
    ## rbt -r and remember what number the review was.
    repo=$(basename `git rev-parse --show-toplevel`)
    branch=$(git branch | grep \* | cut -d ' ' -f2)
    rbt_id=$(grep "$repo:$branch" ~/.rbtids | cut -d":" -f3)
    if [ -z "$rbt_id" ]; then
        rbt_id=$(/usr/local/bin/rbt post --open --bugs-closed $branch --summary $branch: | tee /dev/tty | egrep -o '[0-9]+' | head -1)
        echo -e "$repo:$branch:$rbt_id\n" >> ~/.rbtids
    else
        /usr/local/bin/rbt post -r $rbt_id
    fi
}
