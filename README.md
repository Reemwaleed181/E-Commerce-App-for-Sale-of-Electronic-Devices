# Quick Cart - E-Commerce App for Electronic Devices

A modern, feature-rich Flutter e-commerce application specializing in electronic devices including smartphones, laptops, headphones, smartwatches, and gift bundles.

## 🚀 Features

### Product Categories
- **📱 Mobile Phones**: iPhones, Samsung Galaxy, Google Pixel
- **💻 Laptops**: MacBook, HP, Lenovo, ASUS with detailed specifications  
- **🎧 Headphones**: Apple AirPods, Beats, JBL with noise cancellation options
- **⌚ Smartwatches**: Various brands and models
- **🎁 Gift Bundles**: Curated electronic device packages

### Core Functionality
- **🔍 Smart Search**: Real-time product search with filtering
- **🛒 Shopping Cart**: Add to cart with quantity management using Provider state management
- **👤 User Profile**: Customizable user information and settings
- **📊 Analytics**: Beautiful charts and statistics with FL Chart
- **🎨 Modern UI**: Clean, responsive design with custom themes
- **📱 Cross-Platform**: Runs on Android, iOS, Windows, and Linux

### Technical Features
- **State Management**: Provider pattern for cart and app state
- **Image Handling**: Advanced image picker for user profiles
- **HTTP Integration**: API service layer for data management
- **Local Storage**: SharedPreferences for user settings
- **Navigation**: Intuitive bottom navigation and drawer menu
- **Responsive Design**: Adaptive layouts for different screen sizes

## 🛠️ Tech Stack

- **Framework**: Flutter 3.7.2+
- **Language**: Dart
- **State Management**: Provider
- **Charts**: FL Chart
- **UI Components**: Material Design with custom theming
- **Storage**: SharedPreferences
- **HTTP**: Native Dart HTTP package
- **Icons**: Font Awesome Flutter, Cupertino Icons

## 📦 Key Dependencies

```yaml
dependencies:
  flutter: sdk
  provider: ^6.1.2           # State management
  fl_chart: ^0.69.0          # Beautiful charts
  image_picker: ^0.8.4+3     # Image selection
  http: ^1.2.2               # HTTP requests
  shared_preferences: ^2.3.2  # Local storage
  awesome_dialog: ^3.2.1     # Beautiful dialogs
  font_awesome_flutter: ^10.1.0 # Icon library
```

## 🎨 Design Features

- **Color Scheme**: Modern orange (#FF6B00) primary color with clean white backgrounds
- **Typography**: Bold, readable fonts with proper hierarchy
- **Cards**: Elevated cards with rounded corners for product display
- **Navigation**: Bottom navigation bar with intuitive icons
- **Responsive**: Adapts to different screen sizes and orientations

## 📱 Screenshots

The app includes a comprehensive image gallery showcasing various electronic devices with high-quality product images stored in the `images2/` directory.

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.7.2 or higher
- Dart SDK
- Android Studio / VS Code
- iOS Simulator / Android Emulator

### Installation

1. Clone the repository:
```bash
git clone https://github.com/Reemwaleed181/E-Commerce-App-for-Sale-of-Electronic-Devices.git
```

2. Navigate to project directory:
```bash
cd E-Commerce-App-for-Sale-of-Electronic-Devices
```

3. Install dependencies:
```bash
flutter pub get
```

4. Run the app:
```bash
flutter run
```

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry point
├── homepage.dart            # Main home screen
├── cart.dart               # Shopping cart functionality
├── profile.dart            # User profile management
├── categories/             # Category-specific screens
│   ├── Mobile.dart
│   ├── laptop.dart
│   ├── Headphone.dart
│   ├── Watch.dart
│   └── Gifts.dart
├── items/                  # Individual item detail screens
├── services/               # API and data services
└── components/            # Reusable UI components
```

## 🛒 App Workflow

1. **Browse Products**: Users can explore different categories of electronic devices
2. **Search & Filter**: Advanced search functionality to find specific products
3. **Product Details**: Detailed product pages with specifications and images
4. **Add to Cart**: Seamless cart management with quantity controls
5. **User Profile**: Customizable user profiles with preferences

## 🎯 Target Audience

This app is designed for:
- Tech enthusiasts looking for latest electronic devices
- Students and professionals seeking laptops and mobile devices
- Music lovers interested in high-quality headphones
- Anyone looking for electronic gift bundles

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 👨‍💻 Developer

**Reem Waleed** - [@Reemwaleed181](https://github.com/Reemwaleed181)

---

⭐ If you found this project helpful, please give it a star on GitHub!
