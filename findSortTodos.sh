git grep -n -w "FIXME\|TODO" | awk '{ print $1}' | while read fileline; do
    filename=`echo $fileline | cut -d: -f1`
    pureFilename=`echo $filename | rev | cut -d'/' -f1 | rev`
    lineno=`echo $fileline | cut -d: -f2`
    rawTime=`git blame -p -t $filename -L$lineno,$lineno | grep author-time | cut -d' ' -f2`
    userAndmsg=`git blame $filename -L$lineno,$lineno |awk -F'(' '{print $2}'`
    fileEnding=`echo ${pureFilename: -4}`
    if [[ "$pureFilename" == *"java"* ]] || [[ "$pureFilename" == *"ts"* ]]
    then
       echo "$rawTime $pureFilename: $userAndmsg"
    fi
done | sort | cut -d' ' -f2-
