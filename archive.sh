#!/bin/bash
###############################################################################
# @file archive.sh
# @version 2.0
#
# Corentin MICHEL corentin.michel@mailo.com
#
# A shell script written to be able to create enncrypted (or not) 7z archive
# with the maximum level in order to save storage space. You will have to use
# it as is with some arguments (files or folders). It will use autocompletion
# if it is set up in your terminal. 
#
# Usage:
# ./archive.sh file1 file2 Folder1/ Folder2
#
# Actually, 7z uses the same password to encrypt both the archive header and
# the actual file content.With the command-line argument -mhe=on (the default
# is off), you can choose to encrypt the header when using 7z to produce an
# encrypted archive. Whether or not you encrypt the file header, the actual
# file content is always encrypted as long as you enter a password.
#
# In both encrypted and unencrypted archives, 7z (as well as zip and rar) uses
# file headers just to make it quick and easy to browse through the files and
# directories that are contained within. Due to a long history, tar does not
# contain a file list like that.
#
# When it comes to encryption, 7z is secure enough (as long as you choose a
# good password). AES-256, which is secure, is the encryption method used by
# 7z. Since 7z is open source, its security cannot be compromised by either
# intentional or innocent security issues.
#
# Keep in mind that your 7z archive is encrypted using a password. That implies
# that if someone had your 7z file, he could test each potential password one
# at a time until he discovered your password.Choosing a strong password would
# therefore be your best option (a passphrase is a good choice because it is
# long enough and easy to remember).
#
# With the command-line argument -mhe=on (the default is off), you can choose
# to encrypt the header when using 7z to produce an encrypted archive.
###############################################################################

# Variable definitions
encrypt=false

# Warning : to not use with sudo
if [ "$UID" -eq "0" ]
then
    zenity --warning --height 80 --width 400 --title "EREUR" --text "Thanks not
    to run with sudo."
    exit
fi

# Usage displayed with zenity
print_usage() {
    zenity --warning --width=300 --height=100 --text "Please select elements to
    back up as arguments. Archive name will automatically be added as datetime
    to avoid overwriting. Direct arguments with spaces won’t be
    selected.\n\n./archive.sh (-e) file1 file2 Folder1 Folder2/\n\n-h to print
    help\n-e to encrypt archive with a password."
}

# Flags to use
MYDATE=$(date '+%Y%m%d_%H%M%S')
while getopts 'he' flag; do
    case "${flag}" in
        h) print_usage 
        exit 1 ;;
        e) encrypt=true ;;
        *) print_usage
        exit 1 ;;
    esac
done

if [[ $# -lt 1 ]];
# error and exit
then 
    print_usage
    exit 1 
else
# goes through archive maker
    FILES="$(realpath $@)"
    echo $FILES
    for i in $FILES
    do
# will append every file or folder given as argument in a "tar" archive
# will give an error if a file or folder name given as argument has spaces in
# it so don’t give names with spaces, or give folder n+1 to process
        tar -rhpvf $MYDATE.tar "$i"
    done

    if $encrypt
# will go through encryption process by asking a password to the user
# password will be asked twice
    then
        7z a -mx=9 -mhe -p -t7z $MYDATE.tar.7z $MYDATE.tar
    else
        7z a -mx=9 -mhe -t7z $MYDATE.tar.7z $MYDATE.tar
    fi
    
    for i in $FILES
# some recap print
    do 
        echo -e "\033[0;34m$i\033[0m"
    done
# removes tar archive
    rm $MYDATE.tar
    echo -e "\033[0;32m$MYDATE".tar.7z"\033[0m"
    zenity --info --width=300 --height=100 --text "Everything went well"
# use zenity to display "Everything went well" message
fi
