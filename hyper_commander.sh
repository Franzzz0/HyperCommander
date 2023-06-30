#! /usr/bin/env bash
print_menu() {
    echo "
------------------------------
| Hyper Commander            |
| 0: Exit                    |
| 1: OS info                 |
| 2: User info               |
| 3: File and Dir operations |
| 4: Find Executables        |
------------------------------"
}
file_actions_menu() {
    while true; do
        echo "
---------------------------------------------------------------------
| 0 Back | 1 Delete | 2 Rename | 3 Make writable | 4 Make read-only |
---------------------------------------------------------------------"
        read user_input
        case "$user_input" in
            0)
                break;;
            1)
                rm "$1"
                echo "$1 has been deleted."
                break;;
            2)
                echo "Enter the new file name:"
                read new_name
                mv "$1" "$new_name"
                echo "$1 has been renamed as $new_name"
                break;;
            3)
                chmod 666 "$1"
                echo "Permissions have been updated."
                ls -l "$1"
                break;;
            4)
                chmod 664 "$1"
                echo "Permissions have been updated."
                ls -l "$1"
                break;;
            *)
                continue;;
        esac
    done
}
files_dirs_menu() {
    while true; do 
        echo "
The list of files and directories:"
        arr=(*)
        for item in "${arr[@]}"; do
            if [[ -f "$item" ]]; then
                echo "F $item"
            elif [[ -d "$item" ]]; then
                echo "D $item"
            fi
        done        
        echo "
---------------------------------------------------
| 0 Main menu | 'up' To parent | 'name' To select |
---------------------------------------------------"
        read user_input
        if [[ "$user_input" == 0 ]]; then
            break
        elif [[ "$user_input" == "up" ]]; then
            cd ..
        elif [[ -f "$user_input" ]]; then
            file_actions_menu "$user_input"
        elif [[ -d "$user_input" ]]; then
            cd "$user_input"
        else
            echo "Invalid input!"
        fi
    done
}
executable_search() {
    echo "
Enter an executable name:"
    read file_name
    file_path=$(which "$file_name")
    if [ $? -eq 1 ]; then
        echo "
The executable with that name does not exist!
"
    else
        echo "
Located in: $file_path

Enter arguments:"
        read arguments
        $file_name $arguments
    fi
}
echo "Hello $USER!"
while true; do
    print_menu
    read user_input
    case "$user_input" in
        0)
            echo "Farewell!"
            break;;
        1)
            uname -on;;
        2)
            whoami;;
        3)
            files_dirs_menu;;
        4)
            executable_search;;
        *)
            echo "Invalid option!";;
    esac    
done