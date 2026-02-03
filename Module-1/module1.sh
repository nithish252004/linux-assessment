#!/bin/bash
#Module 1 

#TASK 1
echo "1 . Create a file and add executable permission to all users"

touch testing_file.txt
chmod 755 testing_file.txt
ls -lstr | grep testing_file

#TASK 2
echo "2 . Removing write permission for group user alone"
touch testing1_file.txt
echo "Before changing mode"
chmod 664 testing1_file.txt
ls -l testing1_file.txt 
chmod g-w testing1_file.txt
echo "After changing mode"
ls -l testing1_file.txt

#TASK 3
echo "3 . Create a file and add softlink in another directory"
mkdir -p softlink/dir1
mkdir -p softlink/dir2
touch softlink/dir2/original.txt
ln -s ./softlink/dir2/original.txt softlink/dir1/softlink.txt
ls -l softlink/dir1

#TASK 4
echo "4 . List all active process in the system"
ps -aux

#TASK 5
echo "5 . Create 3 files in dir and redirect output of list command sorted by timestamp to a file"
mkdir test
touch test/file1.txt
sleep 1
touch test/file2.txt
sleep 1
touch test/file3.txt
sleep 1
ls -lt test > test/sorted_files.txt
echo "Inside the sorted_files.txt"
cat test/sorted_files.txt
