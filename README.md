# 🏋️‍♂️ Weight Loss Tracker App

A beautifully designed Flutter android app that helps users monitor and achieve their weight goals. Includes features like daily health tips, weight history charts, goal setting, Firebase integration, and more — all wrapped in a dark modern UI. Ideal for anyone pursuing a healthier lifestyle.

## 🚀 Features

* 📊 **Track Weight Progress** over time
* 📅 **Set and View Goals** for better motivation
* 🔔 **Daily Reminders** to log weight
* 📚 **Health & Nutrition Tips** daily
* 🌙 **Full Dark Mode UI** with modern navigation
* 🔥 **Firebase Integration** for secure data storage
* 📈 **Chart Visualizations** of weight history
* 📦 **Cross-Platform Support**: Android, Web, Windows

## 🧰 Technologies Used

* **Flutter** (3.x)
* **Dart**
* **Firebase Firestore** (Cloud database)
* **Firebase Core & Auth**
* **Provider** (State management)
* **shared\_preferences** (Local storage)
* **fl\_chart** (Graph plotting)
* **Flutter Local Notifications**
* **Google Fonts**
* **Android SDK / Emulator**
* **Visual Studio Code**

## 🗂️ Project Structure

```
📁 lib/
 ┣ 📂 components/        # Reusable widgets
 ┣ 📂 screens/           # UI screens
 ┣ 📂 models/            # Data models
 ┣ 📂 services/          # Firebase & storage services
 ┣ 📜 main.dart          # App entry point

📁 android/              # Android-specific config
📁 ios/                  # iOS-specific config
📁 web/                  # Web build
📁 windows/              # Windows desktop build
📄 pubspec.yaml          # Project dependencies
```

## ⚙️ Setup Instructions

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/ArihantKhaitan/weight_loss_tracker_app.git
cd weight_loss_tracker_app
```

### 2️⃣ Install Flutter Packages

```bash
flutter pub get
```

### 3️⃣ Connect Firebase

* Go to [Firebase Console](https://console.firebase.google.com/)
* Create a project → Add an Android app
* Download `google-services.json` and place it inside `android/app/`
* Enable Firestore in the Firebase console

### 4️⃣ Run the App

**On Emulator or Real Device:**

```bash
flutter run
```

**Build for Android APK:**

```bash
flutter build apk --release
```

**Build for Web:**

```bash
flutter build web
```

**Build for Windows Desktop:**

```bash
flutter build windows
```

## 🔐 Firebase Configuration

Ensure the following Firebase packages are added in `pubspec.yaml`:

```yaml
firebase_core: ^2.0.0
cloud_firestore: ^4.0.0
firebase_auth: ^5.0.0
```

Also, initialize Firebase in `main.dart`:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
```

## 💡 How to Use

* Launch the app and sign in.
* Add your current weight daily.
* Set a target weight and track your progress.
* View charts of your weight changes.
* Get tips and motivational prompts to stay consistent.

## 🧪 Debugging

* **Device not detected?**

  ```bash
  flutter doctor
  flutter devices
  ```
* **Missing packages?**

  ```bash
  flutter pub get
  ```
* **Firebase issues?**

  * Ensure your `google-services.json` is placed correctly.
  * Rebuild the app: `flutter clean && flutter run`

---

## 📜 License

This project is licensed under the **MIT License** — feel free to use and modify with attribution.

---

## 👤 Author

**Arihant Khaitan**

🔗 [GitHub](https://github.com/ArihantKhaitan)

---

## 🤝 Contributions

Pull requests and feedback are welcome!
Feel free to open an issue if you find a bug or want to suggest a new feature.

---

Let me know if you want a version with badges or GIF demo too!
