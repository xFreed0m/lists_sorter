# lists_sorter
short (and lazy) bash script to transform pass-lists to length-based dictionaries

## What is this
This is a combination of three different bash scripts I've wrote in order to automated some 
of the tasks when trying to transform multiple lists into a dictionary.

## What does it do
This script is very simple - you change every value in brackets with capital text in it e.g - _[FULL PATH TO TXT FILES]_
Then the script will perform in three steps:
1. remove non-ASCII printable characters, tabs and blank spaces
2. process the newly created files and will split them to a length based files (between 1 to 64 chars],
take the values in the loop to merge the length you wrote and merge into a central file (based on the length).
3. will sort the files alphabetically and will remove duplicates

### Issues, bugs and other code-issues
Yeah, I know, this code isn't the best. I'm fine with it as I'm not a developer and this is part of my learning process.
If there is an option to do some of it better, please, let me know.

_Not how many, but where._
