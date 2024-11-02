#!/bin/bash
set -e

# Define the URL for the Azure repo
AZURE_REPO_URL="https://dev.azure.com/taskdevai/_git/Client%20Azure"
CLONE_DIR="client-azure-repo"

# Get the PAT from an environment variable
AZURE_PAT="$AZURE_DEVOPS_PAT"  # Ensure this variable is set in your environment

echo "Starting setup script..."

# Clone the Azure repo if it doesn’t already exist
if [ ! -d "$CLONE_DIR" ]; then
  echo "Cloning the Azure repository..."
  git clone https://$AZURE_PAT@$AZURE_REPO_URL "$CLONE_DIR"
else
  echo "Azure repository already exists, skipping clone."
fi

# Navigate to the cloned repo and checkout the desired branch
cd "$CLONE_DIR" || { echo "Failed to change directory to $CLONE_DIR"; exit 1; }
echo "Checked out to $CLONE_DIR."

# Attempt to checkout the desired branch
BRANCH_NAME="your-feature-branch"  # Replace with your desired branch name
echo "Attempting to checkout the desired branch '$BRANCH_NAME'..."
if git checkout -b "$BRANCH_NAME"; then
  echo "Checked out new branch '$BRANCH_NAME'."
else
  echo "Branch '$BRANCH_NAME' already exists, checking it out."
  git checkout "$BRANCH_NAME"
fi

# Go back to the root workspace
cd .. || { echo "Failed to change directory to the parent folder"; exit 1; }

# Create a symlink in the main workspace pointing to the Azure repo folder
if [ ! -L "azure-repo" ]; then
  echo "Creating symlink to the Azure repo..."
  ln -s "$CLONE_DIR" azure-repo
  echo "Symlink created: azure-repo -> $CLONE_DIR"
else
  echo "Symlink 'azure-repo' already exists."
fi

echo "Setup script completed successfully."
