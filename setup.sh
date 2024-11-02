#!/bin/bash
set -e

# Define the URL for the Azure repo
AZURE_REPO_URL="https://dev.azure.com/taskdevai/_git/Client%20Azure"

# Clone the Azure repo if it doesn’t already exist
if [ ! -d "client-azure-repo" ]; then
  git clone "$AZURE_REPO_URL" client-azure-repo
fi

# Navigate to the cloned repo and checkout the desired branch
cd client-azure-repo
git checkout -b fix/tasknumber || git checkout fix/tasknumber
