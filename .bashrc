SCHRODINGER=/scr/jtran/builds/2017-4/build; export SCHRODINGER; SCHRODINGER_SRC=/scr/jtran/builds/2017-4/source; export SCHRODINGER_SRC; SCHRODINGER_LIB=/software/lib; export SCHRODINGER_LIB
echo Loaded build 2017-4 of maestro

alias src='cd $SCHRODINGER_SRC'
alias src_msv='cd $SCHRODINGER_SRC/mmshare/python/modules/schrodinger/application/msv'
alias build_modules='cd $SCHRODINGER/mmshare-v*/python/modules && make schrodinger_modules && cd -'
alias build='$SCHRODINGER_SRC/mmshare/build_tools/buildinger.sh'
alias test_msv='cd $SCHRODINGER/mmshare*/python/test && make msv_test && cd -'
alias test_msv_fast='cd $SCHRODINGER/mmshare*/python/test && make unittest TEST_ARGS="application/msv --fast" && cd -'
alias maestro='$SCHRODINGER/maestro --console'
alias build='$SCHRODINGER_SRC/mmshare/build_tools/buildinger.sh'
alias standalone_msv='$SCHRODINGER/run $SCHRODINGER/mmshare-v*/python/scripts/msv.py --console'
alias ssch='source $SCHRODINGER_SRC/mmshare/build_env'
export PATH=$PATH:~/repo/work_scripts/
