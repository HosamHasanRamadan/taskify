<p align="center">
<img src="https://user-images.githubusercontent.com/28815699/222177846-ffa3bde8-c84a-4b60-b42f-11a922642be7.png" width=20% height=20%>
</p>

# Taskify
Taskify is a task management app that allows users to create, organize and track their tasks. 

## Getting Started
Prerequisites:
- Flutter 3.3.10
- Java 11
- Xcode 13.4.1
- VsCode or android studio with flutter and dart extensions installed



## Supported platforms
- [x] Web 
- [x] IOS 
- [x] Android
- [ ] Mac [Not Tested]
- [ ] Windows [Not Tested]

## App Features
- [x] kanban board for tasks, where users can create, edit, and move tasks between different columns 
- [X] Export or share project as CSV file
- [x] A timer function that allows users to start and stop tracking the time spent on each task.
- [x] A history of completed tasks, including the time spent on each task and the date it was completed.
- [x] Cloud synchronization: Allow users to synchronize their tasks and time tracking data across multiple devices using Firebase.
- [x] Customizable themes: Allow users to customize the look and feel of the app by choosing from a selection of pre-defined color schemes.
- [x] Offline functionality: Allow the app to work offline and automatically synchronize data when a connection is re-established.

## CI/CD
Thanks to Codemagic, Whenever a commit is made to the main branch, Codeemagic initiates a pipeline that produces a fresh android release to app distribution for testing. Additionally, it updates the web app in the process.
