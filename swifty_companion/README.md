# Swifty Companion

A mobile application developed as part of the 42 school curriculum to introduce mobile development. The app allows users to search and view detailed profiles of 42 students using the official 42 API.

## Description

This project introduces mobile application development using Flutter, focusing on:
- Mobile programming with Dart
- API integration with OAuth2 authentication
- Modern app architecture and state management
- Responsive UI design
- Error handling and user experience

## Technologies

- **Flutter**: Cross-platform mobile development framework
- **Bloc Pattern**: For state management
- **Dio**: HTTP client for API calls
- **GetIt**: Dependency injection
- **flutter_dotenv**: Environment variables management
- **shared_preferences**: Local storage

## 42 API

The application uses the 42 intranet API which:
- Requires OAuth2 authentication
- Provides student profiles, skills, and projects data
- Has rate limiting and token expiration handling

## Features

### Mandatory
- Two views: Search and Profile
- Comprehensive error handling
- Student profile display:
    - Basic info (login, email, mobile, level)
    - Profile picture
    - Location & wallet info
    - Skills with levels and percentages
    - Completed and failed projects
- Responsive layout
- Secure OAuth2 implementation

### Bonus
- Automatic token refresh on expiration

## Project Structure
```
lib/
  ├── config/               # App configuration
  ├── core/                # Core functionality
  │   ├── errors/         # Error handling
  │   ├── network/        # API clients
  │   └── utils/          # Utilities
  ├── data/               # Data layer
  │   ├── models/         # Data models
  │   ├── repositories/   # Repository implementations
  │   └── datasources/    # Remote/local data sources
  ├── domain/             # Business logic
  │   ├── entities/       # Business entities
  │   └── repositories/   # Repository interfaces
  └── presentation/       # UI layer
      ├── bloc/          # State management
      ├── pages/         # App screens
      └── widgets/       # Reusable widgets
```

## Setup

### Option 1: Using the Setup Script

1. Clone the repository
```bash
git clone <repository-url>
cd swifty_companion
```

2. Create `.env` file with your 42 API credentials:
```
API_UID=your_42_client_id
API_SECRET=your_42_client_secret
API_URL=https://api.intra.42.fr
```

3. Run the setup script
```bash
chmod +x rebuild+run.sh
./rebuild+run.sh
```

This script will:
- Clean the Flutter project
- Stop any running Android/Flutter processes
- Remove cache and build directories
- Get packages
- Run the app

### Option 2: Manual Setup

1. Clone the repository
```bash
git clone <repository-url>
cd swifty_companion
```

2. Create `.env` file with your 42 API credentials
3. Install dependencies:
```bash
flutter pub get
```

4. Run the app:
```bash
flutter run
```

## Security Note

The project requires proper handling of API credentials. Never commit the `.env` file or share API credentials publicly.