#!/bin/bash

# Default configuration
API_KEY="2598e287a1f64819bee150202241806"
BASE_URL="https://api.weatherapi.com/v1/current.json"
DEBUG=false

# Function to fetch weather data
fetch_weather() {
  local location="$1"
  local response

  echo "Fetching weather information for location: $location..."

  # Debug mode
  if [ "$DEBUG" = true ]; then
    echo "Executing curl command: curl -s \"${BASE_URL}?key=${API_KEY}&q=${location}\""
  fi

  # Fetch data from WeatherAPI
  response=$(curl -s "${BASE_URL}?key=${API_KEY}&q=${location}")

  # Check if response is empty
  if [[ -z "$response" ]]; then
    echo "Error: No response from WeatherAPI."
    return 1
  fi

  # Check for API errors
  if echo "$response" | grep -q '"error"'; then
    echo "Error: Failed to fetch weather data for $location."
    local error_message
    error_message=$(echo "$response" | jq -r '.error.message')
    echo "API Error Message: $error_message"
    return 1
  fi

  # Parse and display weather data
  display_weather "$response"
}

# Function to display weather data in a readable format
display_weather() {
  local data="$1"

  # Extract relevant information using jq
  local location=$(echo "$data" | jq -r '.location.name')
  local region=$(echo "$data" | jq -r '.location.region')
  local country=$(echo "$data" | jq -r '.location.country')
  local temperature_c=$(echo "$data" | jq -r '.current.temp_c')
  local condition=$(echo "$data" | jq -r '.current.condition.text')
  local wind_kph=$(echo "$data" | jq -r '.current.wind_kph')
  local humidity=$(echo "$data" | jq -r '.current.humidity')

  # Display weather information in a human-readable format
  echo "---------------------------------"
  echo "Current Weather for $location, $region, $country:"
  echo "Condition: $condition"
  echo "Temperature: $temperature_c°C"
  echo "Wind Speed: $wind_kph km/h"
  echo "Humidity: $humidity%"
  echo "---------------------------------"
}

# Function to display usage information
usage() {
  echo "Usage: $0 [-d] <location>"
  echo "Fetches current weather information for the specified location."
  echo ""
  echo "Options:"
  echo "  -d    Enable debug mode (displays curl commands)"
  echo "  -h    Display this help message"
  exit 1
}

# Parse command-line options
while getopts ":dh" opt; do
  case ${opt} in
    d)
      DEBUG=true
      ;;
    h)
      usage
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      usage
      ;;
  esac
done
shift $((OPTIND -1))

# Check if jq is installed
if ! command -v jq &> /dev/null; then
  echo "Error: jq is not installed. Please install jq to use this script."
  exit 1
fi

# Check if location is provided
if [ -z "$1" ]; then
  echo "Error: Location argument is required."
  usage
fi

# Call fetch_weather function with provided location argument
fetch_weather "$1"
#for basic use:
#./weather_script.sh New York
# for debug mode:
#./weather_script.sh -d New York
