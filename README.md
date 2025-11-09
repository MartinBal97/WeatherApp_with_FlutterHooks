# weatherapp_with_flutterhooks

## Weather App

### Description

The Weather App is a mobile application developed with Flutter that allows users to get weather information for any city. It uses an API service to display data such as temperature, humidity, wind speed, and more. The app includes a location-based search feature based on latitude and longitude coordinates, along with an intuitive interface for displaying current weather information.

### Technologies

- **Flutter**: Framework used for mobile app development.
- **Riverpod**: State management.
- **Flutter Hooks**: Manages widget lifecycle and state.
- **OpenWeatherMap API**: API used to fetch weather data.

### Features

- **City Search**: Users can search for weather data by entering any city's name.
- **Geolocation**: The app fetches the user's current location using latitude and longitude.
- **Main Screen**: Displays essential weather information such as temperature, humidity, wind speed, and general conditions.
- **Favorites**: Users can add cities to their favorites list and quickly view their weather data.
- **Local Storage**: The app stores the weather data locally, ensuring it remains available even if the user closes and reopens the app.
- **User-Friendly Interface**: The interface is easy to navigate, designed for a smooth user experience.

### App Flow

The app flow was designed using Excalidraw to illustrate the navigation between screens and how different components interact. Below, you can find a link to the app flow diagram:

[[View app flow diagram on Excalidraw](https://excalidraw.com/#json=Loh77t3bZ1NscbF4UtyuN,URRYIDrSX5ITVTBioj7-fw)](#)

### Key Folders and Files Explained

- **lib/**: Contains the main source code of the application.
  - **core/**:
    - **constants/**: Defines global constants used in the application.
    - **services/**: Contains reusable services, in this case, Local Storage.
    - **theme/**: Defines the visual theme of the application.
    - **utils/**: Contains utility functions.
  - **data/**:
    - **models/**: Defines data model classes
    - **repository/**: Contains data access logic
  - **presentation/**:
    - **controllers/**: Contains application state controllers
    - **screens/**: Defines application screens
  - **widgets/**: Contains reusable custom widgets.
  - **main.dart**: The main entry point of the application.

## Prerequisites

- Flutter version 3.29.1

## Installation Steps

1. Clone this repository to your local machine:

    ```bash
    git clone https://github.com/MartinBal97/WeatherApp_with_FlutterHooks.git
    ```

2. Install the project dependencies:

    ```bash
    flutter pub get
    ```

3. Run the app on an emulator or physical device:

    ```bash
    flutter run
    ```

## API Key

To access the OpenWeatherMap API, you will need an API key. You can get it [here](https://home.openweathermap.org/users/sign_up). Once you have the key, add it to the app's configuration file.

## Getting Started

1. Copy the .env.template file and rename it to .env.
2. Add the corresponding key to the .env file.
