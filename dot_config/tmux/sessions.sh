#!/bin/bash
# TMUX Session Templates
# ======================
# Scripts for creating pre-configured development sessions

# Function to create a development session
dev_session() {
    local session_name=${1:-"dev"}
    local project_path=${2:-"$HOME"}
    
    # Create session if it doesn't exist
    if ! tmux has-session -t "$session_name" 2>/dev/null; then
        # Create session and first window
        tmux new-session -d -s "$session_name" -c "$project_path"
        
        # Window 1: Editor
        tmux rename-window -t "$session_name:1" "editor"
        tmux send-keys -t "$session_name:1" "nvim" Enter
        
        # Window 2: Terminal
        tmux new-window -t "$session_name" -n "terminal" -c "$project_path"
        
        # Window 3: Git (if in git repo)
        if [ -d "$project_path/.git" ]; then
            tmux new-window -t "$session_name" -n "git" -c "$project_path"
            tmux split-window -t "$session_name:git" -h -p 50
            tmux send-keys -t "$session_name:git.0" "git status" Enter
            tmux send-keys -t "$session_name:git.1" "git log --oneline -10" Enter
        fi
        
        # Select first window
        tmux select-window -t "$session_name:1"
    fi
    
    # Attach to session
    tmux attach-session -t "$session_name"
}

# Function to create a monitoring session
monitor_session() {
    local session_name="monitor"
    
    if ! tmux has-session -t "$session_name" 2>/dev/null; then
        tmux new-session -d -s "$session_name"
        
        # Split into 4 panes
        tmux split-window -h
        tmux split-window -v
        tmux select-pane -t 0
        tmux split-window -v
        
        # Setup monitoring commands
        tmux send-keys -t "$session_name:0.0" "htop" Enter
        tmux send-keys -t "$session_name:0.1" "df -h" Enter
        tmux send-keys -t "$session_name:0.2" "free -h && echo && uptime" Enter
        tmux send-keys -t "$session_name:0.3" "watch -n 1 'ps aux | head -10'" Enter
        
        tmux select-pane -t 0
    fi
    
    tmux attach-session -t "$session_name"
}

# Function to create a full-stack development session
fullstack_session() {
    local session_name=${1:-"fullstack"}
    local project_path=${2:-"$HOME"}
    
    if ! tmux has-session -t "$session_name" 2>/dev/null; then
        # Create session
        tmux new-session -d -s "$session_name" -c "$project_path"
        
        # Window 1: Frontend
        tmux rename-window -t "$session_name:1" "frontend"
        tmux split-window -t "$session_name:frontend" -h -p 30
        tmux send-keys -t "$session_name:frontend.0" "nvim" Enter
        
        # Window 2: Backend
        tmux new-window -t "$session_name" -n "backend" -c "$project_path"
        tmux split-window -t "$session_name:backend" -h -p 30
        tmux send-keys -t "$session_name:backend.0" "nvim" Enter
        
        # Window 3: Servers
        tmux new-window -t "$session_name" -n "servers" -c "$project_path"
        tmux split-window -t "$session_name:servers" -h
        tmux send-keys -t "$session_name:servers.0" "# Frontend server" Enter
        tmux send-keys -t "$session_name:servers.1" "# Backend server" Enter
        
        # Window 4: Database/Logs
        tmux new-window -t "$session_name" -n "data" -c "$project_path"
        tmux split-window -t "$session_name:data" -v
        tmux send-keys -t "$session_name:data.0" "# Database commands" Enter
        tmux send-keys -t "$session_name:data.1" "# Log monitoring" Enter
        
        tmux select-window -t "$session_name:1"
    fi
    
    tmux attach-session -t "$session_name"
}

# Main script logic
case "${1:-help}" in
    "dev")
        dev_session "$2" "$3"
        ;;
    "monitor")
        monitor_session
        ;;
    "fullstack")
        fullstack_session "$2" "$3"
        ;;
    "help"|*)
        echo "TMUX Session Templates"
        echo "======================"
        echo ""
        echo "Usage: $0 <command> [options]"
        echo ""
        echo "Commands:"
        echo "  dev [name] [path]       - Create development session"
        echo "  monitor                 - Create system monitoring session"
        echo "  fullstack [name] [path] - Create full-stack development session"
        echo "  help                    - Show this help"
        echo ""
        echo "Examples:"
        echo "  $0 dev myproject ~/projects/myproject"
        echo "  $0 fullstack webapp ~/code/webapp"
        echo "  $0 monitor"
        ;;
esac