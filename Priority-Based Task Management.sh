#!/bin/bash

# Associative array to store tasks and their priorities
declare -A tasks

# Function to add a task with a specific priority
add_task() {
    local task="$1"
    local priority="$2"

    tasks["$task"]=$priority
    echo "Task added: $task (Priority: $priority)"
}

# Function to view tasks based on priority
view_tasks() {
    local priority="$1"
    local count=0

    echo "Tasks with Priority $priority:"
    for task in "${!tasks[@]}"; do
        if [ "${tasks[$task]}" -eq "$priority" ]; then
            echo "$task"
            count=$((count + 1))
        fi
    done

    if [ "$count" -eq 0 ]; then
        echo "No tasks found with Priority $priority."
    fi
}

# Function to view all tasks
view_all_tasks() {
    echo "All Tasks:"
    for task in "${!tasks[@]}"; do
        echo "$task (Priority: ${tasks[$task]})"
    done

    if [ "${#tasks[@]}" -eq 0 ]; then
        echo "No tasks found."
    fi
}

# Function to mark a task as completed
complete_task() {
    local task="$1"

    if [ -n "${tasks[$task]}" ]; then
        unset tasks["$task"]
        echo "Task marked as completed: $task"
    else
        echo "Task not found: $task"
    fi
}

# Function to delete a task
delete_task() {
    local task="$1"

    if [ -n "${tasks[$task]}" ]; then
        unset tasks["$task"]
        echo "Task deleted: $task"
    else
        echo "Task not found: $task"
    fi
}

# Main menu
while true; do
    echo "Priority-Based Task Management System"
    echo "1. Add Task"
    echo "2. View Tasks by Priority"
    echo "3. View All Tasks"
    echo "4. Mark Task as Completed"
    echo "5. Delete Task"
    echo "6. Exit"
    read -p "Enter your choice: " choice

    case "$choice" in
        1)
            read -p "Enter task description: " task
            read -p "Enter priority (1, 2, or 3): " priority
            add_task "$task" "$priority"
            ;;
        2)
            read -p "Enter priority to view tasks (1, 2, or 3): " priority
            view_tasks "$priority"
            ;;
        3)
            view_all_tasks
            ;;
        4)
            read -p "Enter task to mark as completed: " task
            complete_task "$task"
            ;;
        5)
            read -p "Enter task to delete: " task
            delete_task "$task"
            ;;
        6)
            echo "Exiting. Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid choice. Please try again."
            ;;
    esac
done
