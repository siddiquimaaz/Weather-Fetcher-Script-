## 🌦️ Weather Fetcher Script

Welcome to the Weather Fetcher Script! This bash script is your terminal-based solution to quickly fetch and display current weather information for any location using the robust WeatherAPI.

## ✨ Features

- **🔍 Easy to Use**: Fetch weather information with a simple command.
- **🛠️ Debug Mode**: See the curl commands being executed for troubleshooting.
- **📊 Human-Readable Output**: Weather data is parsed and displayed clearly.
- **🔄 Error Handling**: Get informed of any issues with fetching the data.
- **💻 Cross-Platform**: Works on any Unix-like OS with bash and jq.

## 📋 Requirements

- **jq**: A lightweight and flexible command-line JSON processor. [Install jq](https://stedolan.github.io/jq/download/)

## 🛠️ Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/siddiquimaaz/weather-fetcher-script.git
2. Navigate to the script directory:
   cd weather-fetcher-script
3. Ensure the script is executable
   chmod +x weather_script.sh
## 🚀 Usage
# Basic Usage
Fetch the weather for a specific location:
```bash```
   ./weather_script.sh "<location>"
# Example:
```bash```
   ./weather_script.sh "New York"
# Debug Mode
Enable debug mode to see detailed curl command output:
```bash```
   ./weather_script.sh -d "<location>"
# Example:
```bash```
     ./weather_script.sh -d "New York"
# Help
Display usage information:
```bash```
   ./weather_script.sh -h
## 📊 Example Output
```bash```
---------------------------------
Current Weather for New York, New York, United States:
Condition: Partly cloudy
Temperature: 22°C
Wind Speed: 15 km/h
Humidity: 60%
---------------------------------

