# AARAM - AI-Powered Government Document Manager

A comprehensive Flutter application that serves as a personal AI assistant for all government documents. It integrates with DigiLocker to fetch verified records, provides AI-powered form filling, tracks application statuses, sends expiry reminders, and helps automate document renewals.

## 🌟 Features

### Core Functionality
- **DigiLocker Integration**: One-time login to fetch and verify all official documents
- **AI Form Filling**: Uses data from DigiLocker to fill forms for passport renewals, Aadhaar updates, PAN corrections, driving licence renewals, etc.
- **Expiry Dashboard**: Tracks expiry dates of all documents and sends reminders
- **One-Click Renewals**: Auto-fills forms, attaches verified documents, and submits them
- **Multi-Document Update Flow**: Updates details across multiple IDs in the correct order
- **Real-Time Tracking**: Live application status with push notifications

### User Experience
- **Encrypted Vault**: Stores documents securely with shareable links
- **Multilingual Support**: English and Malayalam language support
- **AI Chatbot Helpdesk**: Answers document-related queries instantly
- **Responsive Design**: Works seamlessly on mobile, web, and desktop platforms

## 🚀 Quick Start

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/JustRamm/AARAM.git
   cd AARAM
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   # For Windows
   flutter run -d windows
   
   # For Web
   flutter run -d chrome
   
   # For Android
   flutter run -d android
   ```

## 📱 Screenshots

The app includes the following screens:
- **Splash Screen**: Professional loading animation with government branding
- **Welcome Screen**: Introduction to app features
- **Authentication**: Login/Signup with DigiLocker integration
- **Home Dashboard**: Document overview, quick actions, and government services
- **AI Chatbot**: Intelligent assistance for document queries
- **Document Vault**: Secure storage and management
- **Notifications**: Real-time updates and reminders
- **Profile**: User settings and language preferences

## 🛠️ Technology Stack

- **Framework**: Flutter
- **Language**: Dart
- **State Management**: Provider
- **UI Components**: Material Design 3
- **HTTP Client**: Dio
- **Local Storage**: Shared Preferences
- **Secure Storage**: Flutter Secure Storage
- **URL Launcher**: For external government portals

## 🌐 Deployment

### Web Deployment (Vercel)
The app is configured for deployment on Vercel:

1. **Connect to GitHub**: Link your GitHub repository to Vercel
2. **Automatic Deployment**: Vercel will automatically build and deploy your app
3. **Custom Domain**: Configure your custom domain in Vercel dashboard

### Build Commands
```bash
# Build for web
flutter build web --release

# Build for Windows
flutter build windows

# Build for Android
flutter build apk --release
```

## 📋 Project Structure

```
lib/
├── main.dart                 # App entry point
├── providers/               # State management
│   ├── auth_provider.dart
│   └── theme_provider.dart
├── screens/                 # UI screens
│   ├── splash_screen.dart
│   ├── welcome_screen.dart
│   ├── login_screen.dart
│   ├── signup_screen.dart
│   ├── home_screen.dart
│   ├── ai_chatbot_screen.dart
│   ├── profile_screen.dart
│   ├── notifications_screen.dart
│   └── document_vault_screen.dart
├── services/               # Business logic
│   ├── ai_service.dart
│   └── government_api_service.dart
├── utils/                  # Utilities
│   └── responsive_utils.dart
└── widgets/               # Reusable widgets
    └── custom_button.dart
```

## 🔧 Configuration

### Environment Variables
Create a `.env` file in the root directory:
```env
# API Keys (for future integration)
DIGILOCKER_CLIENT_ID=your_digilocker_client_id
DIGILOCKER_CLIENT_SECRET=your_digilocker_client_secret
AI_SERVICE_API_KEY=your_ai_service_api_key
```

### Platform Support
- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ Windows
- ✅ macOS

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Government of India for DigiLocker integration
- Flutter team for the amazing framework
- Material Design for UI components
- All contributors and supporters

## 📞 Support

For support, email support@aaram.gov.in or create an issue in this repository.

---

**AARAM** - Automated Application & Records Assistant Manager
*Empowering citizens with intelligent document management* 