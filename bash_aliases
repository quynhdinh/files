#!/bin/bash

# Show where I'm copying
alias cp="cp -v"
alias mv="mv -v"
alias rm="rm -v"
#alias vim='nvim'
alias v='nvim'
alias s='source ~/.zshrc'
# Shortcuts
alias g="git"
alias lg="lazygit"
alias python="python3"
alias notebook="python3 -m notebook ~/workspace/"
alias ']'='xdg-open'
alias x='exit'
alias c='clear'
alias clean='make clean'
#
alias dcl='docker container ls'
alias dcu='docker compose up'
alias dcd='docker compose down'
alias jav='java -version'
alias idea='intellij-idea-community . >/dev/null 2>&1 &'
# copy and paste (on ubuntu machine run `sudo apt-get install xclip -y`)
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

function push_passwords(){
    echo 'Pushing passwords up Github'
    cp ~/Downloads/passwords/Passwords.kdbx ~/Documents/github/personal/password/
    cd ~/Documents/github/personal
    g add .
    g commit -m "commited at $(date +%F_%H-%M-%S)"
    g p
}
alias push_passwords=push_passwords

function pull_passwords(){
    cd ~/Documents/github/personal
    git pull
    cp ~/Documents/github/personal/password/Passwords.kdbx ~/Downloads/passwords/Passwords.kdbx
}
alias pull_passwords=pull_passwords

function set_upstream {
    CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD);
    echo "setting up stream branch $CURRENT_BRANCH"
    git push --set-upstream origin $CURRENT_BRANCH
}
alias up=set_upstream

function commit_misc {
    CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD);
    myArray=("a funny" "a lovely" "a cute" "an adorable" "a pretty" "an elegant" "a charming" "a gorgeous" "a stunning")
    num=${#myArray[@]}
    index=$((1 + $RANDOM % $num))
    adj=${myArray[$index]}
    echo "writing $adj commit and push to branch: $CURRENT_BRANCH"
    git add .
    git commit -m "$adj commit at $(date +%F_%H-%M-%S)"
}
alias misc=commit_misc

function commit_misc_then_push {
	commit_misc
    git push
}
alias miscp=commit_misc_then_push

function reset_hard_origin_branch {
    CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD);
    echo "git reset --hard origin/$CURRENT_BRANCH"
    git reset --hard origin/$CURRENT_BRANCH
}
alias reset=reset_hard_origin_branch

function create_java_project {
	artifact=$1
	echo "creating a java project named $artifact"
	bash ~/Documents/github/files/bin/mvn-java8 $1
	cd $artifact
}
alias java_quick=create_java_project

function init_contest_folder {
	folder=$1
	numberOfProblems="${2:-5}"
	echo "init a contest folder named $folder having $numberOfProblems problems"
	mkcd $folder
	chars=( {a..z} )
	for ((i=1; i<=numberOfProblems; i++))
	do
		problem=${chars[i]}
		mkdir $problem
		cp ~/Documents/github/cp/tem.cpp ./$problem/$problem.cpp
	done
	geany ./a/a.cpp &
}
alias contest=init_contest_folder

# if any argument provided, build that 
# else find any .cpp file in the current directory, build it
function compile_cpp_file {
    file_name=$1
    if [ $# -eq 0 ]
        then
            file_name=$(find . -maxdepth 1 -type f -name "*cpp" -print -quit)
    fi
    echo "Compiling $file_name"
    output_file="${file_name%.*}"
    g++ -std=c++17 -Wshadow -Wall -o $output_file $file_name -g -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG -DLOCAL
    find . -name "in*" -print0 | while read -d $'\0' file
    do
        echo "The result for $file is "
        ./$output_file < $file
        echo "==="
    done
}
alias cpp=compile_cpp_file

function make_cpp_file {
    file_name=$1
    if [ $# -eq 0 ]
        then
            file_name="sol.cpp"
    fi
    echo $file_name
	bash ~/Documents/github/files/bin/make_cpp_file $file_name
}
alias makecpp=make_cpp_file

function move_to_windows_from_wsl {
    echo "$1"
    sudo cp $1 /mnt/d/$1
}
alias mwin=move_to_windows_from_wsl

function make_sh_file {
	name=$1
	echo "creating a bash file named $name"
	bash ~/Documents/github/files/bin/create-script $1
}
alias makesh=make_sh_file
alias kkp='cd ~/Downloads/kafka_2.13-3.4.0/bin && ./kafka-console-producer.sh --bootstrap-server kafka:9092 --topic'
alias kkc='cd ~/Downloads/kafka_2.13-3.4.0/bin && ./kafka-console-consumer.sh --bootstrap-server kafka:9092 --topic'
alias ktp='cd ~/Downloads/kafka_2.13-3.4.0/bin && ./kafka-topics.sh --list --bootstrap-server kafka:9092'
