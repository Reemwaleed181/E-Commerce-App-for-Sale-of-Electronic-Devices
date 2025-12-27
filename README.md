# E-Commerce App for Sale of Electronic Devices

A modern, feature-rich Flutter e-commerce application specializing in electronic devices including smartphones, laptops, headphones, smartwatches, and gift bundles with integrated payment processing.

## 🚀 Features

### Product Categories
- **📱 Mobile Phones**: iPhones, Samsung Galaxy, and other premium smartphones
- **💻 Laptops**: MacBook, HP, Lenovo, ASUS with detailed specifications  
- **🎧 Headphones**: Apple AirPods, Beats, JBL with noise cancellation options
- **⌚ Smartwatches**: Apple Watch, Huawei, and various other brands
- **🎁 Gift Bundles**: Curated electronic device packages

### Core Functionality
- **🔍 Smart Search**: Real-time product search with filtering
- **🛒 Shopping Cart**: Add to cart with quantity management using Provider state management
- **💳 Payment Processing**: Multiple payment methods including credit card, cash on delivery, and digital wallet
- **👤 User Profile**: Customizable user information and settings with image picker
- **📊 Analytics**: Beautiful charts and statistics with FL Chart
- **🎨 Modern UI**: Clean, responsive design with Google Fonts and custom themes
- **📱 Cross-Platform**: Runs on Android, iOS, Windows, and Linux

### Payment Features
- **Credit Card Processing**: Secure card payment with form validation
- **Cash on Delivery**: COD option with delivery address management
- **Digital Wallet**: Integrated wallet payment system
- **Payment Animation**: Smooth animations and loading states
- **Order Confirmation**: Real-time payment status and confirmation

### Technical Features
- **State Management**: Provider pattern for cart and app state
- **Image Handling**: Advanced image picker for user profiles
- **HTTP Integration**: API service layer for data management
- **Local Storage**: SharedPreferences for user settings
- **Navigation**: Intuitive bottom navigation and drawer menu
- **Responsive Design**: Adaptive layouts for different screen sizes
- **Form Validation**: Comprehensive input validation across all forms
- **Typography**: Google Fonts integration for beautiful text rendering

## 🛠️ Tech Stack

- **Framework**: Flutter 3.7.2+
- **Language**: Dart
- **State Management**: Provider
- **Charts**: FL Chart
- **UI Components**: Material Design with custom theming
- **Storage**: SharedPreferences
- **HTTP**: Native Dart HTTP package
- **Typography**: Google Fonts
- **Icons**: Font Awesome Flutter, Cupertino Icons
- **Forms**: Custom form validation and input handling

## 📦 Key Dependencies

```yaml
dependencies:
  flutter: sdk
  provider: ^6.1.2              # State management
  fl_chart: ^0.69.0             # Beautiful charts
  image_picker: ^0.8.4+3        # Image selection
  http: ^1.2.2                  # HTTP requests
  shared_preferences: ^2.3.2    # Local storage
  awesome_dialog: ^3.2.1        # Beautiful dialogs
  font_awesome_flutter: ^10.1.0 # Icon library
  google_fonts: ^6.3.0          # Typography
  intl: ^0.18.0                 # Internationalization
  timezone: ^0.9.4              # Timezone handling
  readmore: ^3.0.0              # Text expansion
  flutter_svg_provider: ^1.0.7  # SVG support
  drop_down_list: ^0.0.8        # Dropdown components
  cupertino_icons: ^1.0.8       # iOS style icons
```

## 🎨 Design Features

- **Color Scheme**: Modern orange (#FF6B00) primary color with clean white backgrounds
- **Typography**: Google Fonts with bold, readable fonts and proper hierarchy
- **Cards**: Elevated cards with rounded corners for product display
- **Navigation**: Bottom navigation bar with intuitive icons
- **Responsive**: Adapts to different screen sizes and orientations
- **Animations**: Smooth transitions and loading states
- **Forms**: Clean, validated input fields with helpful error messages

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


## 🛒 App Workflow

1. **Browse Products**: Users can explore different categories of electronic devices
2. **Search & Filter**: Advanced search functionality to find specific products
3. **Product Details**: Detailed product pages with specifications and images
4. **Add to Cart**: Seamless cart management with quantity controls
5. **Payment Processing**: Multiple payment options with secure processing
6. **Order Confirmation**: Real-time payment status and order confirmation
7. **User Profile**: Customizable user profiles with image upload capabilities

## 💳 Payment Methods

- **Credit/Debit Card**: Secure card processing with validation
- **Cash on Delivery**: Pay when your order arrives at your doorstep
- **Digital Wallet**: Quick payments through integrated wallet system

## 🎯 Target Audience

This app is designed for:
- Tech enthusiasts looking for latest electronic devices
- Students and professionals seeking laptops and mobile devices
- Music lovers interested in high-quality headphones
- Anyone looking for electronic gift bundles
- Users who prefer flexible payment options

## 🔧 Configuration

The app includes:
- Asset management for high-quality product images
- Cross-platform compatibility (Android, iOS, Web, Windows, Linux)
- Responsive layouts for different screen sizes
- Material Design components with custom theming
