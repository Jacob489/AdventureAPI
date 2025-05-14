# Interactive Text Adventure

## Description
This Bash script interacts with the Adventure API to create an interactive text-based adventure experience. The script initiates a new adventure session, retrieves the narration and choices from the API, and allows the user to make choices that influence the progression of the story.

## Features

* Session Initialization: Starts a new adventure session with the adventure named "brookmere-may6-0704pm."

* Narration Retrieval: Fetches the current scene's narration, providing the user with the text that describes the scenario.

* Choice Interaction: Presents the user with available choices from the current scene, allowing them to make decisions that affect the story's progression.

* Dynamic Progression: Based on the user's choices, the story advances, with new choices being provided as they continue to play.

* Looping Interaction: The script continuously retrieves the next piece of narration and presents the choices until the user reaches the end of the adventure or chooses to quit.

## How It Works

* Session Initialization: The script first initializes a new adventure session with a specific adventure name (brookmere-may6-0704pm).

* Narration and Choices: It retrieves the current scene's narration and displays it. If there are choices available, these are shown to the user.

* User Input: The script waits for the user's input to select one of the available choices, sending that choice back to the API.

* Repeat: The process repeats until the user decides to quit or until the adventure ends.

## Requirements

* Curl: The script uses curl to send HTTP requests to the Adventure API.

* jq (Optional): Although jq is not strictly required, it is used to parse and format the API responses for better readability.
 
# To run, type these commands in bash:
Make the script executable:
1. (First time only)
```
chmod +x team_assignment.sh
```
2. (Every time)
```
./team_assignment.sh
```
3. If the adventure ends, re-run command #2 to launch the adventure from the beginning

## Note

The adventure’s available choices may be limited in some parts of the story, depending on the design of the adventure. The API returns only the available choices for the current scene.

The script currently supports the "brookmere-may6-0704pm" adventure, but other adventures can be explored by modifying the adventure_name parameter in the script.

## Example Output:
```
Initializing adventure session...
Session ID: abc123def456

Fetching narration...
Story:
There is a heavy gold chain around your neck. At the end of the chain is a golden charm, worked in precious gems, in the shape of a dragon’s head...

Available choices:
- Continue to next page

Sending first choice: Continue to next page
Advanced to node: 2
```
