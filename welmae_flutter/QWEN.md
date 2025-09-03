# Welmae Flutter Project Context

## Project Overview

This is a Flutter project named "Welmae". It appears to be a travel planning and social application. Key features visible from the code include:

- User authentication (login, register, forgot password)
- Destination exploration and search
- Trip planning tools
- Social features (posts, favorites, friends, group travel)
- User profiles
- Notifications
- Theme management (light/dark mode)
- Location-based services (using geolocator and geocoding)
- Weather integration

The project structure follows a layered architecture, separating concerns into `app`, `core`, `data`, `domain`, `presentation`, `providers`, `screens`, `services`, `shared`, `utils`, and `widgets` directories within `lib`.

## Technology Stack

- **Framework**: Flutter (Dart)
- **State Management**: Provider
- **Networking**: http package
- **Location Services**: geolocator, geocoding
- **Media Handling**: image_picker
- **UI/UX**: Material Design 3 (Material You)

## Development Conventions

### Architecture

The project uses a layered architecture:
- `app`: Contains app-level configurations like themes.
- `core`: Likely contains core business logic, constants, and utilities.
- `data`: Data layer, handling API calls, local storage, etc.
- `domain`: Business logic and models.
- `presentation`: UI components (widgets, screens).
- `providers`: State management using Provider.
- `screens`: Individual app screens.
- `services`: Service layer for interacting with external APIs or device features.
- `shared`: Shared components, constants, or utilities.
- `utils`: Utility functions.
- `widgets`: Reusable UI components.

### Theming

The project has a comprehensive theming system defined in `lib/app/theme/`. It includes:
- `theme.dart`: Defines the main `AppTheme` class with light and dark themes, following Material Design 3 guidelines.
- `colors.dart`: Defines color constants for both light and dark themes.
- `typography.dart`: Defines text styles and a custom `AppTypography` class.
- `dimensions.dart`: Defines spacing, sizes, and other dimensional constants.

The `AppProvider` manages the theme mode (light, dark, system) and provides methods to toggle it.

### State Management

State management is handled using the `Provider` package. The main providers identified are:
- `AppProvider`: Manages global app state like theme, language, currency, user login status, notifications, location services, search history, favorites, recent destinations, settings, statistics, and cache.
- `UserProvider`: Likely manages user-specific data (not fully explored).

### Routing

Navigation is handled by `MaterialApp`'s `routes` and `onGenerateRoute` in `main.dart`. Named routes are used for most screens.

### UI Components

UI components are built using Flutter's Material widgets. Custom widgets are organized under `lib/widgets` and used in screens.

## Building and Running

To build and run this Flutter project, you will typically use the Flutter CLI tools.

1.  **Prerequisites**:
    *   Install Flutter SDK (version ^3.9.0 as per `pubspec.yaml`).
    *   Install dependencies: Run `flutter pub get` in the project root.

2.  **Running the App**:
    *   Connect a device or start an emulator.
    *   Run `flutter run` in the project root directory.

3.  **Building the App**:
    *   For Android: `flutter build apk` or `flutter build appbundle`.
    *   For iOS: `flutter build ios`. (Requires Xcode and CocoaPods setup).
    *   For web: `flutter build web`.
    *   Specific instructions might be in platform-specific directories (`android`, `ios`).

4.  **Testing**:
    *   Run tests with `flutter test`.

5.  **Code Analysis**:
    *   Run static analysis with `flutter analyze`.
    *   The project uses `flutter_lints` for code quality rules (configured in `analysis_options.yaml`).

This context provides a foundational understanding of the Welmae Flutter project for future development tasks.