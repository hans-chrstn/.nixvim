#!/usr/bin/env bash
set -e

PLUGIN_NAME=$1
if [ -z "$PLUGIN_NAME" ]; then
  echo "Usage: nix run .#new-plugin -- <plugin-name>"; exit 1;
fi

PLUGIN_DIR="src/plugins/$PLUGIN_NAME"
PLUGIN_PATH="$PLUGIN_DIR/default.nix"
MAIN_CONFIG="src/plugins.nix"

if [ -d "${PLUGIN_DIR}" ]; then
  echo "Error: Plugin directory '${PLUGIN_DIR}' already exists."; exit 1;
fi

mkdir -p "$PLUGIN_DIR"
sed "s/NEW_PLUGIN_NAME/$PLUGIN_NAME/g" templates/plugin.nix > "$PLUGIN_PATH"
echo "Created new plugin module for '$PLUGIN_NAME'."

newLine="  $PLUGIN_NAME.enable = true;"
sed -i "\$i\\$newLine" "$MAIN_CONFIG"

echo "Formatting files with Alejandra..."
alejandra "$PLUGIN_PATH" "$MAIN_CONFIG"

echo "Staging changes..."
git add "$PLUGIN_PATH" "$MAIN_CONFIG"

echo "Enabled '$PLUGIN_NAME' in '$MAIN_CONFIG'!"
