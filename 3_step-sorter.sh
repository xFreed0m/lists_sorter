#!/bin/bash

# Consider running the command below on the folder containing the files\folders
# to change every space in a file\folder name to an underscore - will prevent
# the script from failing on "ambigious redirection"
# find Password_lists/ -depth -name "* *" -execdir rename 's/ /_/g' "{}" \;

FILES1=[FULL PATH TO TXT FILES]
# with an asterisk in the end

# Step 1 - remove non-ASCII printable, tabs and empty lines
for f in $FILES1
do
	if [ -f "$f" ]; then
		echo "[*] Prepping $f now..."
		echo "[*] Removing non-ASCII chars"
		tr -cd '\12\15\40-\176' < $f > $f-v2
		echo "[*] Removing empty line"
		sed '/^$/d' $f-v2 > $f-v3
		echo "[*] Here's the head of the file:"
		head $f-v3
		echo "[*] Removing $f-v2"
		rm $f-v2
		echo "[+] Done prepping $f!"
		echo "[+] Moving $f-v3 to prepped folder"
		mv $f-v3 [FULL PATH TO PROCESSED FILES AFTER STEP 1]
	fi

done


################### line to break to separate scripts
###################!/bin/bash

FILES2=[FULL PATH TO PROCESSED FILES AFTER STEP 1]
# with an asterisk in the end

PREP2=[FULL PATH TO PROCESSED FILES AFTER STEP 2]
# with an asterisk in the end

# Step 2 - create a dir for each file, split the file to length-based
# other files, merge same length files to one
for f in $FILES2
do
	if [ -f "$f" ]; then
		echo "[*] Prepping2 $f now..."
		echo "[*] Creating a dir for each file"
		mkdir $f-dir
		echo "[*] Splitting into length-based files"
		[FULL PATH TO HASHCAT-UTILS SPLITLEN.BIN] $f-dir < $f
		#echo "[*] Removing $f"
		#rm $f
		echo "[+] Done prepping $f!"
    # Because splintlen.bin generate 1 digit with 0 before
    # - we do single digit length in a dedicated line
		cat $f-dir/08 >> $PREP2/08-merged
		cat $f-dir/09 >> $PREP2/09-merged
    # we do the two digit length in a loop
		for i in {10..16..1}
			do
				cat $f-dir/$i >> $PREP2/$i-merged
		done
		echo "[+] Moving $f-dir to prepped2 folder"
		mv $f-dir/ [FULL PATH TO PROCESSED FILES AFTER STEP 2]
	fi
done

################### line to break to separate scripts
###################!/bin/bash

FILES3=[FULL PATH TO PROCESSED FILES AFTER STEP 2]
# with an asterisk in the end

# Step 3 sort each file alphabetically then de-dupe it
for f in $FILES3
do
	if [ -f "$f" ]; then
		echo "[*] Sort and uniq are running on $f"
		sort $f | uniq > $f-SU.lst
		echo "[*] Here's the head of the file:"
		head $f-SU.lst
		#echo "[*] Removing $f-prepped3"
		#rm $f-prepped3
		echo "[+] Done prepping $f!"
		echo "[+] Moving $f-SU.lst to DONE folder"
		mv $f-SU.lst [FULL PATH TO FULLY PROCESS FILES]
	fi
done


# TODO: might want to remove each file after processed?
