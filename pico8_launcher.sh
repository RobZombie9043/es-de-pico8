#!/system/bin/sh

ROM_PATH="$1"
SYSTEM_NAME="$3"

# Only continue if system is pico8
if [ "$SYSTEM_NAME" != "pico8" ]; then
    exit 0
fi

# Clean the ROM path from \ escapes (only \ space for now)
ROM_PATH_CLEANED="$(echo "$ROM_PATH" | sed 's/\\ / /g')"

ROM_DIR="$(dirname "$ROM_PATH_CLEANED")"
ROM_FILE="$(basename "$ROM_PATH_CLEANED")"
DESKTOP_FILE="$ROM_DIR/pico8.desktop"

# Strip all extensions to get the true basename
ROM_BASENAME="$(echo "$ROM_FILE" | sed 's/\.[^.]*$//' | sed 's/\.[^.]*$//')"

# Set execArgs
if [ "$ROM_BASENAME" = "Splore" ]; then
    UPDATED_EXECARGS="execArgs=-splore"
else
    WIN_ROM_FILE="F:\\\\$ROM_FILE"
    UPDATED_EXECARGS="execArgs=-run \"$WIN_ROM_FILE\""
fi

# Confirm desktop file exists and is writable
if [ ! -f "$DESKTOP_FILE" ] || [ ! -w "$DESKTOP_FILE" ]; then
    exit 1
fi

# If execArgs exists, replace it. Otherwise, insert it below [Extra Data].
if grep -q "^execArgs=" "$DESKTOP_FILE"; then
    sed "s|^execArgs=.*|$UPDATED_EXECARGS|" "$DESKTOP_FILE" > "$DESKTOP_FILE.tmp"
else
    awk -v new="$UPDATED_EXECARGS" '
        /^\[Extra Data\]/ {
            print
            print new
            next
        }
        { print }
    ' "$DESKTOP_FILE" > "$DESKTOP_FILE.tmp"
fi

# Move temp file into place
mv "$DESKTOP_FILE.tmp" "$DESKTOP_FILE"