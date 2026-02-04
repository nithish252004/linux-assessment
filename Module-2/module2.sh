#i/bin/bash

echo "1 . List all the files in the current Directory and Append the Output to another file"
find . -type f -size +1M > new_file.txt
echo "Saved in new_file.txt"

echo "2 . Replace all localhost with 127.0.0.1 in config.txt"
sed 's/localhost/127.0.0.1/g' config.txt > updated_config.txt
echo "Updated file saved as updated_config.txt"


echo "3 . Search for lines containing the word ERROR in a log file but exclude lines containing DEBUG"
grep "ERROR" log.txt | grep -v "DEBUG" log.txt > filtered_log.txt
echo "Saved in filtered_log.txt"

echo "4 . Finding the tasks with highest memory usage and then kill it"
pid=$(ps aux --sort=-%mem | awk 'NR==2{print $2}')
cmd=$(ps aux --sort=-%mem | awk 'NR==2{print $11}')
echo "Command = $cmd and its PID is $pid"
#kill $pid
echo "Kill pid is commented"

echo "5 . Finding the default gateway"
ip route | grep default | awk '{print $3}' > gateway.txt
echo "Saved in gateway.txt"
