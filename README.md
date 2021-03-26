# curvenote GitHub Action: Push

## Description
This GitHub action allows you to automate pushing files and folders
from GitHub to [curvenote](https://curvenote.com). It uses the
open-source [curvenote Python client](https://pypi.org/project/curvenote/).
Currently, only markdown files are supported.

## Basic Usage
To upload a single file on every push:
```
name: curvenote push
on: [push]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout
      uses: actions/checkout@v2
    - name: curvenote push
      uses: curvenote/push-to-curvenote@main
      with:
        path: notes_202101.md
        project: Team Notes
        article: Notes from Jan 2021
        team: curvenote
      env:
        CURVENOTE_TOKEN: ${{ secrets.CURVENOTE_TOKEN }}
```
This requires your curvenote API token saved in your GitHub secrets under
`CURVENOTE_TOKEN`.

If the `Team Notes` Project does not yet exist, it will be created under
team `curvenote`. If `Team Notes` Project does exist, the team will be ignored.
Similarly, if the Article `Notes from Jan 2021` does not exist, it will be
created in the `Team Notes` Project and `notes_2021.md` will be pushed
as the first version of that article. If `Notes from Jan 2021` Article does
exist, `notes_2021.md` will be pushed as a new version of the Article.

To upload all files in a folder on every push:
```
name: curvenote push
on: [push]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout
      uses: actions/checkout@v2
    - name: curvenote push
      uses: curvenote/push-to-curvenote@main
      with:
        path: notes
        project: Team Notes
      env:
        CURVENOTE_TOKEN: ${{ secrets.CURVENOTE_TOKEN }}
```
Similar to above, `Team Notes` Project will be created if it does not
exist. (This time, no team was specified, so it is created under the
account associated with the `CURVENOTE_TOKEN`.) Then, all files within
the `notes` folder will be pushed as new Articles or new Versions of
existing Articles to the `Team Notes` Project. Individual Article
names cannot be specified in this case; they are determined from the
file names.

## Realistic Usage
Likely you do only want to push to curvenote when files change. This
requires a few extra lines in your workflow. First, you must fetch
the complete git history on `checkout`. Then, you must provide the
previous commit when files were pushed to curvenote. Just follow
this example:
```
name: curvenote push
on: [push]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout
      uses: actions/checkout@v2
      with:
        fetch-depth: 0
    - name: curvenote push
      uses: curvenote/push-to-curvenote@main
      with:
        path: notes_202101.md
        project: Team Notes
        article: Notes from Jan 2021
        team: curvenote
        previous_commit: ${{ github.event.before }}
      env:
        CURVENOTE_TOKEN: ${{ secrets.CURVENOTE_TOKEN }}
```
If you want to push multiple files or folders to curvenote, simply
reuse the curvenote push step multiple times, each with different `path`.
