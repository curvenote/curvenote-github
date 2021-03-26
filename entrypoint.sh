#! /bin/bash -l
cd /github/workspace
if [[ $5 != "0000000000000000000000000000000000000000" ]]
then
    files=`git diff --name-only $5 HEAD`
fi
if ! [[ $files ]] || [[ $files == *"$1"* ]]
then
    echo "pushing $1 to curvenote"
    python -m curvenote push --article "$3" --team "$4" "/github/workspace/$1" "$2"
else
    echo "not pushing $1 to curvenote"
fi
