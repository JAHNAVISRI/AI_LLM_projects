#!/bin/bash

exec() {
    script_command=$1
    while [ "$(squeue -u 016653039 | wc -l)" -ne 1 ]; do
        echo "busy"
        sleep 45
    done
    $script_command
}

# Sequential execution of commands
exec "bash exec.sh 1 10" 
exec "bash exec.sh 1 20" 
exec "bash exec.sh 1 30" 
exec "bash exec.sh 1 40" 
exec "bash exec.sh 1 50" 
exec "bash exec.sh 1 100" 
exec "bash exec.sh 1 150" 
exec "bash exec.sh 1 200" 
exec "bash exec.sh 1 250" 
exec "bash exec.sh 1 300" 


exec "bash exec.sh 2 10"
exec "bash exec.sh 2 20"
exec "bash exec.sh 2 30"
exec "bash exec.sh 2 40"
exec "bash exec.sh 2 50"
exec "bash exec.sh 2 100"
exec "bash exec.sh 2 150"
exec "bash exec.sh 2 200"
exec "bash exec.sh 2 250"
exec "bash exec.sh 2 300"


exec "bash exec.sh 3 10"
exec "bash exec.sh 3 20"
exec "bash exec.sh 3 30"
exec "bash exec.sh 3 40"
exec "bash exec.sh 3 50"
exec "bash exec.sh 3 100"
exec "bash exec.sh 3 150"
exec "bash exec.sh 3 200"
exec "bash exec.sh 3 250"
exec "bash exec.sh 3 300"

exec "bash exec.sh 7 10"
exec "bash exec.sh 7 20"
exec "bash exec.sh 7 30"
exec "bash exec.sh 7 40"
exec "bash exec.sh 7 50"
exec "bash exec.sh 7 100"
exec "bash exec.sh 7 150"
exec "bash exec.sh 7 200"
exec "bash exec.sh 7 250"
exec "bash exec.sh 7 300"



exec "bash exec.sh 5 10"
exec "bash exec.sh 5 20"
exec "bash exec.sh 5 30"
exec "bash exec.sh 5 40"
exec "bash exec.sh 5 50"
exec "bash exec.sh 5 100"
exec "bash exec.sh 5 150"
exec "bash exec.sh 5 200"
exec "bash exec.sh 5 250"
exec "bash exec.sh 5 300"

exec "bash exec.sh 6 10"
exec "bash exec.sh 6 20"
exec "bash exec.sh 6 30"
exec "bash exec.sh 6 40"
exec "bash exec.sh 6 50"
exec "bash exec.sh 6 100"
exec "bash exec.sh 6 150"
exec "bash exec.sh 6 200"
exec "bash exec.sh 6 250"
exec "bash exec.sh 6 300"
