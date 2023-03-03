<p align="center">
<img src="https://user-images.githubusercontent.com/28815699/222177846-ffa3bde8-c84a-4b60-b42f-11a922642be7.png" width=30% height=30%>
</p>

[![Codemagic build status](https://api.codemagic.io/apps/63f294eb923707492588140f/63f294eb923707492588140e/status_badge.svg)](https://codemagic.io/apps/63f294eb923707492588140f/63f294eb923707492588140e/latest_build)

# Taskify

Taskify is a task management app that allows users to create, organize and track their tasks.

## Getting Started

### Prerequisites

- Flutter 3.3.10
- Java 11
- Xcode 13.4.1
- Vscode or android studio with flutter and dart extensions installed

### Installation

If you're new to Flutter the first thing you'll need is to follow the [setup instructions](https://docs.flutter.dev/get-started/install).

### Debug Builds

- Use `flutter run -d DEVICE_ID` to deploy a test build
To get a list of available `DEVICE_ID`, use `flutter run`.
- Typical values are: `windows`, `linux`, `macos`, `chrome`.
- Add `--release` to deploy an optimized build.

### Release Builds

- Use `flutter build PACKAGE_TYPE` to build a release package.
- To get a list of available `PACKAGE_TYPE`, use `flutter build`.
- Typical values are `windows`, `linux` ,`apk` , `ios`.

## Demo build

- Web : <https://taskify.codemagic.app/>

## Supported platforms

- [x] Web
- [x] IOS
- [x] Android
- [ ] Mac [Not Tested]
- [ ] Windows [Not Tested]

## App Features

- [x] Kanban board for tasks, where users can create, edit, and move tasks between different columns.
- [x] Export or share project as CSV file
- [x] A timer function that allows users to start and stop tracking the time spent on each task.
- [x] A history of completed tasks, including the time spent on each task and the date it was completed.
- [x] Cloud synchronization: Allow users to synchronize their tasks and time tracking data across multiple devices using Firebase.
- [x] Customizable themes: Allow users to customize the look and feel of the app by choosing from a selection of pre-defined color schemes.
- [x] Offline functionality: Allow the app to work offline and automatically synchronize data when a connection is re-established.
- [x] With deep linking feature, users can easily share links to their projects.

## CI/CD

Thanks to Codemagic, Whenever a tagged commit is made to the main branch, Codemagic initiates a pipeline that produces a fresh android release to app distribution and github releases. Additionally, it updates the web app in the process.
