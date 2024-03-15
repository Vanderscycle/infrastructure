#!/bin/bash

# Initialize variables
CERT="./kubeseal-public.pem"
DRY_RUN=false

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --cert)
      CERT="$2"
      shift # past argument
      shift # past value
      ;;
    --dry-run)
      DRY_RUN=true
      shift # past argument
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
    *)
      shift # past argument
      ;;
  esac
done

# Check if the kubeseal public certificate exists
if [ ! -f "$CERT" ]; then
    echo "Certificate file $CERT does not exist. Please ensure the kubeseal public certificate is available."
    exit 1
fi

# Function to check if path contains sub-chart pattern
contains_sub_chart() {
    [[ "$1" =~ charts/.+/charts ]]
}

# Function to seal secrets
seal_secret() {
    local secret_file="$1"
    local sealed_secret_file="$2"

    if $DRY_RUN; then
        echo "Dry run: Would seal $secret_file to $sealed_secret_file"
    else
        kubeseal --cert "$CERT" -f "$secret_file" -o yaml > "$sealed_secret_file"
        if [ $? -eq 0 ]; then
            echo "Sealed secret generated at $sealed_secret_file"
        else
            echo "Failed to seal secret at $secret_file"
        fi
    fi
}

# Find and process secrets
find ./charts -type f -name secret.yaml | while read -r secret_file; do
    if ! contains_sub_chart "$secret_file"; then
        sealed_secret_file=$(dirname "$secret_file")/sealed-secret.yaml
        seal_secret "$secret_file" "$sealed_secret_file"
    fi
done
