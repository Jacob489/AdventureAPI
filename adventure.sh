#!/bin/bash

# Adventure Client Script - Interactive Adventure Flow
# Requirements: curl, jq
# Name: team_assignment.sh

API_URL="https://adventure-api-673835650363.us-west1.run.app"
ADVENTURE_NAME="brookmere-may6-0704pm"

# Initialize session
echo "📘 Initializing your adventure: $ADVENTURE_NAME..."
INIT_RESPONSE=$(curl -s -X POST "$API_URL/init" \
  -H "Content-Type: application/json" \
  -d "{\"adventure_name\": \"$ADVENTURE_NAME\"}")

SESSION_ID=$(echo "$INIT_RESPONSE" | jq -r '.session_id')

if [ "$SESSION_ID" == "null" ] || [ -z "$SESSION_ID" ]; then
  echo "❌ Failed to initialize session."
  exit 1
fi

echo "✅ Session started! Session ID: $SESSION_ID"
echo "🧭 Entering the story..."

while true; do
  # Get current narration
  NARRATE_RESPONSE=$(curl -s -X POST "$API_URL/narrate" \
    -H "Content-Type: application/json" \
    -d "{\"session_id\": \"$SESSION_ID\"}")

  NARRATION=$(echo "$NARRATE_RESPONSE" | jq -r '.narrated_scene.narration')
  CHOICES=$(echo "$NARRATE_RESPONSE" | jq -r '.narrated_scene.choices[]?.original_choice_text')

  echo ""
  echo "📖 NARRATION:"
  echo "$NARRATION"
  echo ""

  # If no choices are available, end the adventure
  if [ -z "$CHOICES" ]; then
    echo "🏁 The adventure has ended. Thanks for playing!"
    break
  fi

  echo "🎯 CHOICES:"
  IFS=$'\n' read -r -d '' -a CHOICE_ARRAY < <(echo "$CHOICES" && printf '\0')
  for i in "${!CHOICE_ARRAY[@]}"; do
    echo "$((i + 1)). ${CHOICE_ARRAY[$i]}"
  done

  # Prompt user for a choice
  echo ""
  read -p "Type the number of your choice (or 'quit' to exit): " USER_INPUT

  if [[ "$USER_INPUT" == "quit" ]]; then
    echo "👋 Exiting the adventure. Goodbye!"
    break
  fi

  if ! [[ "$USER_INPUT" =~ ^[0-9]+$ ]]; then
    echo "❌ Invalid input. Please enter a number."
    continue
  fi

  INDEX=$((USER_INPUT - 1))
  if [ "$INDEX" -lt 0 ] || [ "$INDEX" -ge "${#CHOICE_ARRAY[@]}" ]; then
    echo "❌ Choice out of range. Try again."
    continue
  fi

  SELECTED_CHOICE="${CHOICE_ARRAY[$INDEX]}"
  echo "🗡️ You chose: \"$SELECTED_CHOICE\""

  # Send choice to API
  CHOICE_RESPONSE=$(curl -s -X POST "$API_URL/choice" \
    -H "Content-Type: application/json" \
    -d "{\"session_id\": \"$SESSION_ID\", \"choice\": \"$SELECTED_CHOICE\"}")

  # Check if the adventure has moved to a new node
  NEW_NODE=$(echo "$CHOICE_RESPONSE" | jq -r '.current_node')
  echo "➡️ Moved to node: $NEW_NODE"
done
