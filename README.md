# MiLab2

A new Flutter project.

## Automation (Maestro)

Automation end-to-end ada di `automation/`. Detail lengkap: [`automation/README.md`](automation/README.md).

### Update APK di emulator

```powershell
adb devices                  # pastikan emulator-5554 muncul
flutter build apk --debug
adb install -r build\app\outputs\flutter-apk\app-debug.apk
```

Kalau `INSTALL_FAILED_UPDATE_INCOMPATIBLE: ... signatures do not match`:

```powershell
adb uninstall com.example.Milab2
adb install -r build\app\outputs\flutter-apk\app-debug.apk
```

### Run semua script Maestro

```powershell
C:\maestro\maestro\bin\maestro.bat test automation\flows\
```

Satu flow saja / pin device:

```powershell
C:\maestro\maestro\bin\maestro.bat test automation\flows\01_home_menu.yaml
C:\maestro\maestro\bin\maestro.bat test automation\flows\ --udid emulator-5554
```

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
