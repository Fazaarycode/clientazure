#!/bin/bash
set -e

# Define the URL for the Azure repo
AZURE_REPO_URL="https://dev.azure.com/taskdevai/_git/Client%20Azure"

echo "Starting setup script..."

# Clone the Azure repo if it doesn’t already exist
if [ ! -d "client-azure-repo" ]; then
  echo "Cloning the Azure repository..."
  git clone "$AZURE_REPO_URL" client-azure-repo
else
  echo "Azure repository already exists, skipping clone."
fi

# Navigate to the cloned repo and checkout the desired branch
cd client-azure-repo || { echo "Failed to change directory to client-azure-repo"; exit 1; }
echo "Checked out to client-azure-repo."

echo "Attempting to checkout the desired branch..."
if git checkout -b your-feature-branch; then
  echo "Checked out new branch 'your-feature-branch'."
else
  echo "Branch 'your-feature-branch' already exists, checking it out."
  git checkout your-feature-branch
fi

# Go back to the root workspace
cd .. || { echo "Failed to change directory to the parent folder"; exit 1; }

# Create a symlink in the main workspace pointing to the Azure repo folder
if [ ! -L "azure-repo" ]; then
  echo "Creating symlink to the Azure repo..."
  ln -s client-azure-repo azure-repo
  echo "Symlink created: azure-repo -> client-azure-repo"
else
  echo "Symlink 'azure-repo' already exists."
fi

echo "Setup script completed successfully."
