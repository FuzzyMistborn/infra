#!/bin/bash
# Identifies which docker containers need updating based on git diff

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOST="${1:-}"

if [ -z "$HOST" ]; then
    echo "Usage: $0 <hostname>"
    echo "Available hosts:"
    grep -E '^\[.*\]$' "$SCRIPT_DIR/hosts.ini" | grep -v ':children' | tr -d '[]'
    exit 1
fi

# Get list of changed image names from git diff
echo "Checking git diff for image changes..."
changed_images=$(git diff HEAD@{1} HEAD -- services/*/compose.yaml services/*/compose.yml 2>/dev/null | \
    grep -E '^\+.*image:' | \
    sed 's/^+.*image: //' | \
    sed 's/\"//g' | \
    awk -F: '{print $1}' | \
    sort -u)

if [ -z "$changed_images" ]; then
    echo "No image changes detected in git diff"
    exit 0
fi

echo "Changed images found:"
echo "$changed_images" | sed 's/^/  - /'
echo ""

# Find the compose file for the host
compose_file="$SCRIPT_DIR/services/$HOST/compose.yaml"
if [ ! -f "$compose_file" ]; then
    compose_file="$SCRIPT_DIR/services/$HOST/compose.yml"
fi

if [ ! -f "$compose_file" ]; then
    echo "Error: No compose file found for host '$HOST'"
    exit 1
fi

echo "Analyzing $compose_file..."
echo ""

# Find containers using the changed images
containers=""
while IFS= read -r image; do
    [ -z "$image" ] && continue
    
    # Escape special characters for grep
    escaped_image=$(echo "$image" | sed 's/[\/&]/\\&/g')
    
    # Find service names that use this image
    # Looking for pattern:
    #   service_name:
    #     image: <matching_image>
    service_names=$(awk -v img="$image" '
        /^  [a-z0-9_-]+:$/ { 
            service = $1
            gsub(/:/, "", service)
        }
        /^    image:/ {
            if ($0 ~ img) {
                print service
            }
        }
    ' "$compose_file")
    
    if [ -n "$service_names" ]; then
        echo "Image $image is used by:"
        echo "$service_names" | sed 's/^/  - /'
        containers="$containers $service_names"
    fi
done <<< "$changed_images"

# Remove duplicates and format
final_containers=$(echo "$containers" | tr ' ' '\n' | grep -v '^$' | sort -u | tr '\n' ' ' | sed 's/ $//')

echo ""
echo "================================"
echo "Summary for host: $HOST"
echo "================================"
if [ -n "$final_containers" ]; then
    echo "Containers to update: $final_containers"
    echo ""
    echo "Run this command to update:"
    echo "  just docker"
    echo "  # Then specify: $HOST"
    echo "  # And containers: $final_containers"
    echo ""
    echo "Or use ansible directly:"
    echo "  ansible-playbook docker.yml -e \"host=$HOST\" -e \"containers_to_update='$final_containers'\""
else
    echo "No containers need updating on this host"
fi
