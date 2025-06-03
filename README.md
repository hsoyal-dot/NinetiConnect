# Nineti Connect

A fully functional Flutter app built with clean architecture and the BLoC pattern. It integrates DummyJSON APIs to provide user management, user detail views, post creation, and smooth pagination — all with a modern and minimalistic UI based on a Figma design.

![Made with Flutter](https://img.shields.io/badge/Made%20with-Flutter-blue?logo=flutter)
![State Management: BLoC](https://img.shields.io/badge/State-BLoC-yellow)

---

## Demo

https://drive.google.com/drive/folders/1YVCK5XLGurCG-cqtj8O9CiW0Awmx_sqf?usp=sharing  
<sub>A short screen recording demonstrating the app features with proper screenshots.</sub>

---

## Task Management

Project planning and issue tracking were handled via Jira.  
🔗 [View Jira Board](https://hsdot.atlassian.net/jira/software/projects/NIN/boards/100)

---

## Features

- API integration with [DummyJSON](https://dummyjson.com/users)
- Infinite scrolling and pagination
- Real-time search by user name
- User detail screen with posts and todos
- Create Post functionality (title + body)
- Local state update for new posts
- Pull-to-refresh support
- Responsive UI based on Figma design
- Dark/light theme ready
- Clean and modular codebase using BLoC

---

## Getting Started

### Prerequisites
- Flutter SDK (≥ 3.0)
- Dart (≥ 3.0)
- Android Studio / VS Code

### Installation

```bash
git clone https://github.com/your-username/nineti-connect.git
cd nineti-connect
flutter pub get
flutter run
```

---

## Architecture

The app is structured using Clean Architecture principles, with a feature-first directory layout and BLoC for state management.

```
lib/
├── assets/              # Vectors and SVGs
├── core/              # Constants, theme, assets
├── data/
│   ├── models/        # User, Post, Todo models
│   └── repo/          # UserRepository for API logic
├── presentation/
│   ├── user/     # User list UI and BLoC
│   ├── user_detail/   # User detail UI and BLoC
│   └── post_screen/   # Create post screen
├── main.dart
```

### State Management

- `flutter_bloc` for scalable state management
- Event-driven UI updates with `BlocBuilder`
- Pull-to-refresh integrated with BLoC triggers

---

## Tools & Libraries

- [Flutter](https://flutter.dev/)
- [flutter_bloc](https://bloclibrary.dev)
- [http](https://pub.dev/packages/http)
- [json_serializable](https://pub.dev/packages/json_serializable)
- [Jira](https://www.atlassian.com/software/jira) for issue tracking

---