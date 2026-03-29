# Maroc Live 📺

Maroc Live is a modern, high-quality, fully functional Flutter application that serves as a **Moroccan Live Stream Directory**. It allows users to search, filter by category, favorite, and play live TV channels using HLS (`.m3u8`).

---

## ✨ Features

- **Live TV Directory**: A comprehensive list of 16+ Moroccan TV channels.
- **HLS Streaming**: Robust video playback with support for tokens and custom headers.
- **Smart Stream Resolution**:
  - `normal`: Standard GET requests.
  - `with-headers`: Secure streams requiring specific Origin/Referer headers.
  - `laayone-compatible`: Dynamic token fetching logic before playing.
  - `tele-maroc`: Support for automatic 302 redirects.
- **Favorites System**: Save your favorite channels using `shared_preferences`.
- **Category Filtering**: High-quality UI chips to filter by (All, Arriadia Sports, 2M, Arriadia HD, Arriadia SAT, etc.).
- **Modern Search**: Quick real-time filtering by channel name.
- **Premium UI**: Modern dark theme with zinc/grey typography and blue accents (Material 3).

---

## 🛠️ Tech Stack & Packages

- **Framework**: [Flutter](https://flutter.dev/)
- **State Management**: [Provider](https://pub.dev/packages/provider)
- **Local Storage**: [shared_preferences](https://pub.dev/packages/shared_preferences)
- **Video Player**: [video_player](https://pub.dev/packages/video_player) + [chewie](https://pub.dev/packages/chewie)
- **HTTP Client**: [http](https://pub.dev/packages/http)
- **Networking**: [cached_network_image](https://pub.dev/packages/cached_network_image)
- **Icons**: [Lucide Icons](https://lucide.dev/) (standard Icons used for speed)
- **Typography**: [Google Fonts (Inter)](https://pub.dev/packages/google_fonts)

---

## 📁 Project Structure

```text
lib/
├── models/
│   └── channel.dart         # Channel data model
├── constants/
│   ├── channels.dart        # Full list of Moroccan channels
│   └── app_theme.dart       # Design tokens & Material 3 Dark Theme
├── services/
│   ├── favorites_service.dart # Persistence logic
│   └── stream_service.dart    # Token extraction & stream URL resolution
├── providers/
│   └── channel_provider.dart  # Business logic & UI state
├── widgets/
│   ├── channel_card.dart      # Custom card UI with logo & heart anim
│   ├── category_chips.dart    # Horizontal category selector
│   └── search_bar_widget.dart # Styled search input
└── screens/
    ├── home_screen.dart       # Channel grid, search & filters
    └── player_screen.dart     # Full-screen video player with auto-hiding overlay
```

---

## 🚀 How to Run

### 1. Prerequisites
- [Flutter SDK installed](https://docs.flutter.dev/get-started/install)
- An Android Emulator (recommended) or Physical Device

### 2. Setup
Clone the project and install dependencies:
```bash
flutter pub get
```

### 3. Generate App Icon (Optional)
If you update the icon in `assets/icon/app_icon.png`, regenerate it:
```bash
dart run flutter_launcher_icons:main
```

### 4. Run the App
```bash
# Debug mode
flutter run

# Release mode (Android APK)
flutter build apk --release
```

---

## ⚠️ Important Configuration

### Android Release Permissions
For the video player to work in a real device (Release APK), the `android/app/src/main/AndroidManifest.xml` must include:
- `INTERNET` permission.
- `usesCleartextTraffic="true"` (to allow non-HTTPS streams).

This has already been configured in this codebase.

---

## 👨‍💻 Developer
**Made By Abdellah El idrissi**
