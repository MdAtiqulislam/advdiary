# Advocates Diary (advdiary)

A Flutter case-diary app for advocates — manage cases, notes, court dates and reference books in one place.

[![Google Play](https://img.shields.io/badge/Google_Play-Download-414141?style=for-the-badge&logo=google-play&logoColor=white)](https://play.google.com/store/apps/details?id=com.lawsuitbd.advdiary)


## Features

- Case management: add/update cases, case details, categories and archive
- Notes: add and organize case notes
- Calendar view for hearings and deadlines
- Books & book details (legal references)
- bKash payment integration
- OTP auto-complete for phone verification
- Bottom navigation with app bar and themed UI

## Tech Stack

- Flutter (Dart)
- GetX for state management, routing and dependency injection
- REST API backend
- Firebase (push notifications / services where configured)

## Getting Started

```bash
flutter pub get
flutter run
```

Build a release APK:

```bash
flutter build apk --release
```

## Project Structure

```
lib/
├── app/modules/   # Feature modules (cases, notes, calendar, books, payments, auth)
├── controllers/   # Shared GetX controllers
├── models/        # Data models
├── services/      # API and platform services
├── theme/         # App theme
└── main.dart      # App entry point
```

## Notes

- App label: "Advocates Diary" (Android)
- No secrets or keystores are committed to this repository.
