# pixabay

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## flutter luncher icon

STEP-1 : visit official package README file and copy configure by searching pubspect.yaml

STEP-2 : replace  `flutter_launcher_icons` with `flutter_icons` in pubspec file config section

STEP-3 : disable iOS icon generation in pubspec file config section

STEP-4 : goto android/local.properties and add following 3 lines 
```
flutter.minSdkVersion=24
flutter.targetSdkVersion=30
flutter.compileSdkVersion=30
```

STEP-5 : run this command : flutter pub run flutter_launcher_icons:main