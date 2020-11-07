#!/bin/bash

# This script will retitle all .mkv/.mp4 metadata to their file names. Will also rename directories to the file name
function usage {
  echo "Usage: "
  echo "sudo ./ubuntu_video_rename.sh install_dependencies"
  echo "sudo ./ubuntu_video_rename.sh clean <directory_to_search>"
  echo "sudo ./ubuntu_video_rename.sh clean \"$(pwd)\""
}

function install_dependencies {
  sudo apt update
  sudo apt install -y mkvtoolnix atomicparsley mediainfo
}

function file_rename {
  list=$1
  file_type=$2
  if [[ ! -z "${list}" ]]
  then
    for file in "${list}"
    do
      printf "Checking ${file_type}: ${file}\n"
      x="${file}"
      if [[ "${file_type}" == "mkv" ]]
        then
    	  y="${x%.mkv}"
      elif [[ "${file_type}" == "mp4" ]]
    	then
    	  y="${x%.mp4}"
      fi      
      title=${y##*/}
      current_title=$(mediainfo "${file}" | grep -e "Movie name" | awk -F  ":" '{print $2}' | sed 's/^ *//')
      printf "Current Title: ${current_title}\nProposed Title: ${title}\n"
      if [[ "${title}" != "${current_title}" ]]
      then    	
        if [[ "${file_type}" == "mkv" ]]
        then
    	  mkvpropedit "${file}" -e info -s title="${title}"
    	  printf "Complete!\nCleaned ${file_type} Title: ${title}\n"
    	elif [[ "${file_type}" == "mp4" ]]
    	then
    	  AtomicParsley "${file}" --title "${title}" --comment "" --overWrite
    	  printf "Complete!\nCleaned ${file_type} Title: ${title}\n"
    	fi    	
      else
        printf "Titles already the same, no need to update: ${file}\n"
      fi    
      # Rename Directory of Folder
      rename_directory "${directory}" "${title}"
    done
  else
    printf "Found no ${file_type} Files in ${directory}\n"
  fi
}

function find_files {
  for directory in "${directories[@]}"
  do
    mp4_list=("${directory}"/*.mp4)
    mkv_list=("${directory}"/*.mkv)
    if [[ ! -z "${mkv_list}" ]]
    then
      echo "Processing MKV Files"
      file_rename "${mkv_list}" "mkv"
    else
      printf "Found no mkv Files in ${directory}\n"
    fi
    sleep 1
    if [[ ! -z "${mp4_list}" ]]
    then
      echo "Processing MP4 Files"
      file_rename "${mp4_list}" "mp4"
    else
      printf "Found no mp4 Files in ${directory}\n"
    fi
    sleep 1
  done
}

function find_directories {
  shopt -s dotglob
  shopt -s nullglob
  i=0
  while read line
  do
    if [[ -d "${line}" ]]
    then
      directories[ $i ]="${line}" 
      echo "Found Valid Directory: ${directories[i]} Count: ${i}"       
      (( i++ ))
    fi
  done < <(find "${relative_directory}" -maxdepth 2 -type d | while read dir; do echo $dir; done)  
  printf 'Directory: %s\n' "${directories[@]}"
}

function rename_directory {
  parentdir="$(dirname "${1}")"
  original_directory="${1}"
  proposed_directory="${parentdir}/${2}"
  if [[ "${original_directory}" != "${proposed_directory}" ]]
  then    
    sudo mv "${1}" "${parentdir}/${2}"
    echo "Renamed folder: ${parentdir}/${2}"
  else
    echo "Folder name looks good to go! No changes needed"
  fi 
}

# Clean function clean will take the directory where this script is called from and 
function clean {  
  find_directories
  find_files
  printf "Done Changing Titles\n"
}

function main {
if [[ $# -le 0 ]] ; then
  usage
  exit 0
elif [[ $1 == "install_dependencies" ]] ; then
  install_dependencies
elif [[ $1 == "clean" ]] ;then
  relative_directory="${2}"
  clean
fi
}

main