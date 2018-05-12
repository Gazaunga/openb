rm -rf "$HOME/.cache/"
rm -rf "$HOME/.thumbnails"
rm -rf "$HOME/.local/share/Trash"
exec dbus-launch openbox-session
#tint2 -c ~/.config/tint2/unleashed-workspace.tint2rc &
#tint2 -c ~/.config/tint2/unleashed-taskbar.tint2rc &
tint2 -c ~/.config/tint2/launchy.tint2rc &
