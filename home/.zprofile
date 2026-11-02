# Start the desktop only for an interactive local login on the first console.
# Shared by both laptops; Niri starts Noctalia from its own configuration.
if [[ -o interactive && -o login && "$TTY" == /dev/tty1
      && -z "$SSH_CONNECTION" && -z "$SSH_CLIENT" && -z "$SSH_TTY"
      && -z "$DISPLAY" && -z "$WAYLAND_DISPLAY"
      && -z "$XDG_CURRENT_DESKTOP" ]] && (( $+commands[niri-session] )); then
    exec niri-session
fi
