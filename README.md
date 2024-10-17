# pixabay

I'm pleased to demonstarate a flutter project, which integrates the Pixabay API and adheres to industry-standard code quality guidelines.

Web-Preview : https://pixabayapp.web.app

To review my coding approach, I invite you to explore [Git commit history](https://github.com/jayjayesh/pixabayApp/network), where you'll find regular, task-based updates demonstrating my commitment to transparent and organized development.

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


## flutter sdk version

Flutter 3.22.2 • channel stable • https://github.com/flutter/flutter.git
Framework • revision 761747bfc5 (4 months ago) • 2024-06-05 22:15:13 +0200
Engine • revision edd8546116
Tools • Dart 3.4.3 • DevTools 2.34.3