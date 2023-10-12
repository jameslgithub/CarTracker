# cartracker

Flutter Google Maps Integration
This Flutter application integrates Google Maps API and allows for features such as displaying a map with a user's current location and drawing a polyline route from the user's current location to a specified destination (Parked vehicle location). 

## Prerequisites
To use this code, you must add the following dependencies to your pubspec.yaml file:

```yaml
Copy code
dependencies:
  flutter:
    sdk: flutter
  google_maps_flutter: ^2.0.3
  location: ^4.0.2
  flutter_polyline_points: ^0.3.0
```

Add the required dependencies to your pubspec.yaml.
Create a Flutter app and boot through an android emulator.
Run your app using flutter run.
Make sure to replace the API key in the getPolyPoints method with your own Google Maps API key for this code to work correctly.

