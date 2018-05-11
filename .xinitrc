rm -rf "$HOME/.cache/"
rm -rf "$HOME/.thumbnails"
rm -rf "$HOME/.local/share/Trash"
exec dbus-launch openbox-session
