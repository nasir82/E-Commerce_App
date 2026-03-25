<div align="center">

# 🛍️ Flutter E-Commerce App

A full-featured, production-ready e-commerce mobile application built with **Flutter** and powered by **Firebase**. Designed for a seamless shopping experience on both Android and iOS.

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart)](https://dart.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Enabled-FFCA28?logo=firebase)](https://firebase.google.com)
[![GetX](https://img.shields.io/badge/GetX-State_Management-8A2BE2)](https://pub.dev/packages/get)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

</div>

---

## 📱 App Preview

https://github.com/user-attachments/assets/5609a6d1-2355-4eaf-82c7-535484697db6

---

## ✨ Features

| Category | Features |
|----------|----------|
| **Authentication** | Email/Password Sign Up & Login, Google & Facebook OAuth, Email Verification, Forgot Password, Remember Me |
| **Onboarding** | Multi-page onboarding with smooth navigation, skip support |
| **Home** | Promo banners/slider, category browsing, featured products, search bar |
| **Shop / Store** | Browse by category & brand, tabbed store layout, subcategory filtering |
| **Product Details** | Image slider, variants (color/size), stock status, ratings & reviews, add to cart |
| **Cart & Checkout** | Persistent cart, quantity management, coupon codes, billing summary |
| **Orders** | Order placement, order history, order status tracking |
| **Wishlist** | Add/remove favourite products, persistent across sessions |
| **Profile** | Edit personal info, manage saved addresses, account settings |
| **Theme** | Full Light & Dark mode support, system theme sync |

---

## 📸 Screenshots

### Onboarding & Authentication

<table>
  <tr>
    <td align="center" width="25%">
      <b>Sign Up</b><br/>
      <img width="200" height="450" alt="Sign Up Screen" src="https://github.com/user-attachments/assets/51bab66f-b6b6-45f0-8e9b-4c215f57bb25" />
    </td>
    <td align="center" width="25%">
      <b>Sign In</b><br/>
      <img width="200" height="450" alt="Sign In Screen" src="https://github.com/user-attachments/assets/e5e4cdeb-a579-47ef-a990-4d77864e9265" />
    </td>
    <td valign="center" width="50%">
      <b>Sign Up</b>
      <ul>
        <li>Register with First name, Last name, Username, Email, Phone & Password</li>
        <li>Social sign-up via Google & Facebook</li>
        <li>Privacy Policy & Terms of Use agreement</li>
      </ul>
      <b>Sign In</b>
      <ul>
        <li>Login with email and password</li>
        <li>"Remember Me" & "Forgot Password?" support</li>
        <li>Social sign-in via Google & Facebook</li>
      </ul>
    </td>
  </tr>
</table>

---

### Home & Product Discovery

<table>
  <tr>
    <td align="center" width="25%">
      <b>Home</b><br/>
      <img width="200" height="450" alt="Home Screen" src="https://github.com/user-attachments/assets/7b4326f2-465b-4888-abf9-5042470dda3d" />
    </td>
    <td valign="center" width="50%">
      <ul>
        <li>Personalised greeting & search bar</li>
        <li>Promotional banner carousel/slider</li>
        <li>Popular categories with horizontal scroll</li>
        <li>Featured & trending products grid</li>
        <li>Bottom navigation: Home · Store · Wishlist · Profile</li>
      </ul>
    </td>
  </tr>
</table>

---

### Product Details

<table>
  <tr>
    <td align="center" width="25%">
      <img width="200" height="450" alt="Product Details" src="https://github.com/user-attachments/assets/88134ebd-dfdf-4635-990e-ff5b0c67e3a7" />
    </td>
    <td align="center" width="25%">
      <img width="200" height="450" alt="Product Details 2" src="https://github.com/user-attachments/assets/b205f320-0a09-46c8-aa56-91b33eb44cfc" />
    </td>
    <td valign="center" width="50%">
      <ul>
        <li>Full-screen image slider with zoom</li>
        <li>Product name, brand, price & stock status</li>
        <li>Attribute selectors: color, size & more</li>
        <li>Star rating summary & individual review cards</li>
        <li>Add to Cart button with quantity control</li>
        <li>Wishlist (favourite) toggle</li>
      </ul>
    </td>
  </tr>
</table>

---

### Cart & Checkout

<table>
  <tr>
    <td align="center" width="25%">
      <b>Checkout</b><br/>
      <img width="200" height="450" alt="Checkout Screen" src="https://github.com/user-attachments/assets/566b17b5-0734-4a77-bb78-337eb5f381ff" />
    </td>
    <td valign="center" width="50%">
      <ul>
        <li>Order summary with itemised product list</li>
        <li>Subtotal, shipping fee, tax & grand total breakdown</li>
        <li>Coupon / promo code input</li>
        <li>Saved payment method selection</li>
        <li>Saved shipping address with one-tap change</li>
        <li>Single-tap "Checkout" to place order</li>
      </ul>
    </td>
  </tr>
</table>

---

## 🏗️ Architecture & Project Structure

The app follows a **Feature-Based Architecture** with **MVC + GetX** for clean separation of concerns and scalable state management.

```
├── lib/
│   ├── app.dart                        # App entry point (GetMaterialApp)
│   ├── main.dart                       # Firebase init & app bootstrap
│   ├── firebase_options.dart           # Firebase configuration
│   │
│   ├── bindings/                       # GetX dependency injection
│   ├── routes/                         # Named route definitions
│   ├── localization/                   # i18n / multi-language support
│   │
│   ├── commons/
│   │   ├── styles/                     # Global spacing, divider styles
│   │   └── widgets/                    # Reusable UI components
│   │       ├── appbar/                 # Custom AppBar
│   │       ├── brand/                  # Brand card, showcase, title
│   │       ├── custom_shapes/          # Clippers, circles, curves
│   │       ├── images/                 # Circular & rounded image widgets
│   │       ├── layouts/                # Grid layout helpers
│   │       ├── loader/                 # Animation loaders
│   │       ├── products/               # Product cards (vertical/horizontal)
│   │       └── utils_widgets/          # Section headings, dividers
│   │
│   ├── data/
│   │   └── repositories/              # Firestore data access layer
│   │       ├── address/
│   │       ├── banner/
│   │       ├── brands/
│   │       ├── categories/
│   │       ├── order/
│   │       ├── product/
│   │       └── user/
│   │
│   ├── utils/
│   │   ├── constants/                  # App-wide constants & colors
│   │   ├── device/                     # Device utility helpers
│   │   ├── exceptions/                 # Custom exception handling
│   │   ├── formatters/                 # Currency, date formatters
│   │   ├── helpers/                    # General helper functions
│   │   ├── http/                       # HTTP client utilities
│   │   ├── local_storage/              # SharedPreferences wrapper
│   │   ├── logging/                    # Logging utilities
│   │   ├── popup/                      # Snackbar, dialog helpers
│   │   ├── shimmer/                    # Shimmer loading effects
│   │   ├── theme/                      # Light & dark theme definitions
│   │   └── validator/                  # Form field validators
│   │
│   └── features/
│       ├── authentications/            # Onboarding, Login, Sign Up, Email Verify
│       │   ├── controllers/
│       │   ├── data/
│       │   └── views/
│       ├── home/                       # Home screen, banners, categories
│       │   ├── controller/
│       │   ├── data/
│       │   └── views/
│       ├── shop/                       # Core shopping feature
│       │   ├── controllers/            # Cart, Order, Product, Checkout, Wishlist
│       │   ├── data/models/            # Product, Brand, Category, Order models
│       │   └── views/
│       │       ├── all_products/
│       │       ├── brand/
│       │       ├── cart/
│       │       ├── checkout/
│       │       ├── order/
│       │       ├── product_details/
│       │       ├── sub_category/
│       │       └── wish_list/
│       ├── store/                      # Store tab: tabbed category + brand browsing
│       └── personalizations/           # Profile, Settings, Address management
```

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|-----------|
| **Framework** | [Flutter](https://flutter.dev) (Dart) |
| **State Management** | [GetX](https://pub.dev/packages/get) |
| **Backend / Auth** | [Firebase Authentication](https://firebase.google.com/products/auth) |
| **Database** | [Cloud Firestore](https://firebase.google.com/products/firestore) |
| **Local Storage** | SharedPreferences |
| **Routing** | GetX Named Routes |
| **Theme** | Adaptive Light / Dark with `ThemeMode.system` |

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK `>=3.0.0`
- Dart SDK `>=3.0.0`
- A Firebase project with **Authentication** and **Firestore** enabled
- Android Studio / VS Code with Flutter plugin

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/flutter-ecommerce-app.git
   cd flutter-ecommerce-app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**

   - Create a project at [Firebase Console](https://console.firebase.google.com)
   - Enable **Email/Password**, **Google**, and **Facebook** sign-in methods
   - Enable **Cloud Firestore**
   - Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
   - Place them in the appropriate platform directories
   - Update `lib/firebase_options.dart` with your project config

4. **Run the app**
   ```bash
   flutter run
   ```

---

## 🔑 Key Design Decisions

**GetX for state management** — chosen for its minimal boilerplate, built-in dependency injection, and named route navigation, keeping controllers lean and views reactive.

**Feature-based folder structure** — each feature (`authentication`, `home`, `shop`, `personalizations`) is fully self-contained with its own controllers, models, and views, making it easy to scale or isolate modules.

**Repository pattern** — all Firestore interactions go through dedicated repository classes under `lib/data/repositories/`, keeping business logic decoupled from the data layer.

**Reusable widget library** — `lib/commons/widgets/` acts as an internal component library (product cards, appbars, image widgets, loaders), ensuring visual consistency across the app.

---

## 🤝 Contributing

Contributions are welcome! Please open an issue first to discuss what you'd like to change, then submit a pull request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

Distributed under the MIT License. See [`LICENSE`](LICENSE) for more information.

---

## 👨‍💻 Author

**Md Nasir Uddin**

[![Email](https://img.shields.io/badge/Email-nasirpks36%40gmail.com-D14836?logo=gmail)](mailto:nasirpks36@gmail.com)
[![GitHub](https://img.shields.io/badge/GitHub-Profile-181717?logo=github)](https://github.com/your-username)

---

<div align="center">

⭐ If you found this project helpful, please consider giving it a star!

</div>
