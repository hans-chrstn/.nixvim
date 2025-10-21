#!/usr/bin/env bash
set -e

COMPONENT_NAME=$1
if [ -z "$COMPONENT_NAME" ]; then
  echo "Usage: nix run .#new-component -- <component-name>"; exit 1;
fi

COMPONENT_DIR="src/components/$COMPONENT_NAME"
COMPONENT_PATH="$COMPONENT_DIR/default.nix"
MAIN_CONFIG="src/default.nix"

if [ -d "${COMPONENT_DIR}" ]; then
  echo "Error: component directory '${COMPONENT_DIR}' already exists."; exit 1;
fi

mkdir -p "$COMPONENT_DIR"
sed "s/NEW_COMPONENT_NAME/$COMPONENT_NAME/g" templates/component.nix > "$COMPONENT_PATH"
echo "Created new component module for '$COMPONENT_NAME'."

newLine="  $COMPONENT_NAME.enable = true;"
sed -i "\$i\\$newLine" "$MAIN_CONFIG"

echo "Formatting files with Alejandra..."
alejandra "$COMPONENT_PATH" "$MAIN_CONFIG"

echo "Staging changes..."
git add "$COMPONENT_PATH" "$MAIN_CONFIG"

echo "Enabled '$COMPONENT_NAME' in '$MAIN_CONFIG'!"
