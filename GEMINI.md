# Gemini Code Understanding

## Project Overview

### Project Goal
Build a task management (TODO) application in Flutter to teach state management using the Bloc pattern and Clean Architecture principles.

### Key Technologies & Patterns
- **State Management:** Use the `flutter_bloc` package. All feature-level state logic must be handled by Blocs or Cubits.
- **Architecture:** Follow Clean Architecture principles with a feature-first structure. The main directories under `lib/` should be `core/` and `features/`. The application is also structured as a monorepo with separate packages for `todos_api`, `local_storage_todos_api`, and `todos_repository`.
- **Code Style:** Adhere to Dart's official style guide and the linting rules provided by `very_good_cli`. Use sealed classes for Bloc states and events.
- **Dependencies:** Key dependencies are `flutter_bloc`, `bloc`, `equatable`, `shared_preferences`, and `todos_api`/`todos_repository` local packages.

### Role of AI
The AI should act as a teaching assistant and expert pair programmer. When asked for code, prioritize generating boilerplate, specific functions, or well-defined widgets. When asked for explanations, provide clear, concise answers with analogies relevant to a student audience. Encourage proactive prompting that focuses on understanding concepts and strategies.

## Building and Running

### Prerequisites
- Flutter SDK
- A configured emulator or a physical device

### Key Commands
- **Get dependencies:** `very_good packages get --recursive`
- **Run the app:** `flutter run lib/main_development.dart`
- **Run tests:** `flutter test --coverage`
