#! /bin/bash -l
cd /github/workspace
files=`git diff --name-only $5 HEAD`
if ! [[ $files ]] || [[ $files == *"$1"* ]]
then
    echo "pushing $1 to curvenote"
    python -m curvenote push --article "$3" --team "$4" "/github/workspace/$1" "$2"
else
    echo "not pushing $1 to curvenote"
fi
