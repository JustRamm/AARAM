# AARAM - AI-Powered Government Document Manager

A comprehensive Flutter application that serves as a personal AI assistant for managing government documents with DigiLocker integration.

## 🌟 Features

### Core Features
- **DigiLocker Integration**: Secure access to all government documents
- **AI-Powered Assistant**: Intelligent chatbot for document-related queries
- **Document Management**: Organize and track all your government documents
- **Expiry Reminders**: Never miss important document renewal dates
- **Multi-language Support**: Available in English and Malayalam
- **Cross-platform**: Works on Android, iOS, Web, Windows, and macOS

### Key Functionalities
- **Document Vault**: Secure storage and organization of documents
- **Application Tracking**: Real-time status updates for government applications
- **Form Auto-filling**: AI-powered form completion using verified documents
- **One-click Renewals**: Streamlined document renewal process
- **Secure Sharing**: Encrypted document sharing with access controls
- **Payment Integration**: In-app government fee payments

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/aaram-document-manager.git
   cd aaram-document-manager
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

### Platform-specific Setup

#### Android
```bash
flutter run -d android
```

#### iOS
```bash
flutter run -d ios
```

#### Web
```bash
flutter run -d chrome
```

#### Windows
```bash
flutter run -d windows
```

#### macOS
```bash
flutter run -d macos
```

## 📱 Screenshots

### Main Features
- **Splash Screen**: Animated loading with brand identity
- **Welcome Screen**: Feature introduction and navigation
- **Authentication**: Email/Phone + OTP or password login
- **DigiLocker Connect**: Secure OAuth 2.0 integration
- **KYC Completion**: User information verification
- **Dashboard**: Document overview and quick actions
- **AI Chatbot**: Intelligent document assistance
- **Document Vault**: Organized document storage
- **Profile Management**: User settings and preferences

## 🏗️ Project Structure

```
lib/
├── main.dart                 # App entry point
├── providers/               # State management
│   ├── auth_provider.dart   # Authentication state
│   └── theme_provider.dart  # Theme and language state
├── screens/                 # UI screens
│   ├── splash_screen.dart
│   ├── welcome_screen.dart
│   ├── login_screen.dart
│   ├── signup_screen.dart
│   ├── home_screen.dart
│   ├── ai_chatbot_screen.dart
│   ├── profile_screen.dart
│   ├── notifications_screen.dart
│   ├── document_vault_screen.dart
│   ├── document_detail_screen.dart
│   ├── digilocker_connect_screen.dart
│   └── kyc_completion_screen.dart
├── widgets/                 # Reusable components
│   ├── custom_button.dart
│   └── custom_text_field.dart
└── utils/                  # Utility functions
    └── responsive_utils.dart
```

## 🛠️ Technologies Used

- **Framework**: Flutter
- **Language**: Dart
- **State Management**: Provider
- **UI Components**: Material Design 3
- **HTTP Client**: http package
- **Local Storage**: shared_preferences
- **Secure Storage**: flutter_secure_storage
- **URL Launcher**: url_launcher
- **Fonts**: Google Fonts (Poppins)

## 🌐 Supported Languages

- **English**: Default language
- **Malayalam**: Full localization support

## 🔐 Security Features

- **Encrypted Storage**: All documents are encrypted at rest
- **Secure Authentication**: OAuth 2.0 with DigiLocker
- **Data Protection**: Compliant with India's Digital Personal Data Protection Act
- **Access Controls**: Role-based document access
- **Audit Trail**: Complete activity logging

## 📋 Supported Documents

- **Aadhaar Card**: UIDAI integration
- **PAN Card**: Income Tax Department
- **Driving License**: RTO services
- **Passport**: MEA passport services
- **Voter ID**: Election Commission
- **Birth Certificate**: CRS integration
- **And more...**

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **DigiLocker**: For secure document integration
- **UIDAI**: For Aadhaar services
- **Government of India**: For digital initiatives
- **Flutter Team**: For the amazing framework

## 📞 Support

For support and queries:
- **Email**: support@aaram.app
- **Website**: https://aaram.app
- **Documentation**: https://docs.aaram.app

## 🔄 Version History

- **v1.0.0**: Initial release with core features
- **v1.1.0**: Added Malayalam language support
- **v1.2.0**: Enhanced AI chatbot capabilities
- **v1.3.0**: Improved document management features

---

**Made with ❤️ for India's Digital Transformation** 