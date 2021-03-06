alias ds='cd $SCHRODINGER_SRC'
alias dmsv='cd $SCHRODINGER_SRC/mmshare/python/modules/schrodinger/application/msv'
alias dschr='cd $dschr'
alias dgui='cd $dgui'
alias dprot='cd $dprot'
alias dt='cd $dt'
alias dtprot='cd $dtprot'
alias dtmsv='cd $dtmsv'
alias dtgui='cd $dtgui'
alias build_docs='cd $SCHRODINGER/mmshare* && make code_docs_venv && cd python && make apidocs'
alias build_scripts='cd $SCHRODINGER/mmshare-v*/python/scripts/ && make install ; cd -'
alias build_modules='cd $SCHRODINGER/mmshare-v*/python/modules && make schrodinger_modules ; cd -'
alias build='$SCHRODINGER_SRC/mmshare/build_tools/buildinger.sh'
alias test_msv='build_modules &&cd $SCHRODINGER/mmshare*/python/test && make msv_test ; cd -'
alias test_msv_fast='build_modules && cd $SCHRODINGER/mmshare*/python/test && make unittest TEST_ARGS="application/msv --fast" ; cd -'
alias test_msv_stu='build_modules && build_scripts && $SCHRODINGER/utilities/py.test $SCHRODINGER/mmshare-v*/python/scripts/test/msv_stu'
alias test_param_stu='build_modules && build_scripts && $SCHRODINGER/utilities/py.test $SCHRODINGER/mmshare-v*/python/scripts/test/params_stu'
alias maestro='build_modules && $SCHRODINGER/maestro -console'
alias maestrosrc='cd $SCHRODINGER_SRC/maestro-src'
alias mmshare='cd $SCHRODINGER_SRC/mmshare'
alias build='$SCHRODINGER_SRC/mmshare/build_tools/buildinger.sh'
alias ssch='source $SCHRODINGER_SRC/mmshare/build_env'
alias makegif='ffmpeg -i in.mov -s 900x600 -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=2 --delay=10 > '
alias msv='build_modules && $SCHRODINGER/run $SCHRODINGER/mmshare-v*/python/scripts/msv.py --console'
alias bm='build_modules && maestro'
alias schrun='$SCHRODINGER/run'
alias runsnake='/usr/bin/python ~/bin/runsnake.py'
alias pmsv='rm myprof.prof ; msv && runsnake myprof.prof'
alias g='git'
alias td='testdinger'
export PATH=$PATH:~/repo/work_scripts/
alias test_targs='build_modules && cd $SCHRODINGER/mmshare*/python/test ; make unittest TEST_ARGS="$targs" ; cd -'
alias msv1='schrun multiseqviewer.py'
alias updatelibs='$SCHRODINGER_SRC//mmshare/build_tools/schrodinger_lib_sync/copy_schrodinger_lib.sh $SCHRODINGER_LIB NYC Darwin-x86_64'

