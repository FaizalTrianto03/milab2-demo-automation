# Maestro Automation — MiLab2

Automation ditulis dari label asli yang ada di source code (`lib/app/modules/**`).
Satu file = satu task besar. Tidak ada subflow, tidak ada variabel.

Widget yang tidak punya teks (icon bottom navbar, icon AppBar) dan input field dikasih
`Semantics(identifier: ...)` di source code, supaya automation bisa nge-tap pakai `id`,
bukan koordinat.

## Jalankan

### 1. Update APK di emulator

Setiap kali source code diubah, APK lama di emulator harus diganti dulu.

```powershell
adb devices                  # pastikan emulator-5554 muncul
flutter build apk --debug
adb install -r build\app\outputs\flutter-apk\app-debug.apk
```

Kalau muncul `INSTALL_FAILED_UPDATE_INCOMPATIBLE: ... signatures do not match`,
uninstall dulu (aman, semua flow pakai `launchApp: { clearState: true }`):

```powershell
adb uninstall com.example.Milab2
adb install -r build\app\outputs\flutter-apk\app-debug.apk
```

Opsional, biar app nggak nyangkut di state lama:

```powershell
adb shell am force-stop com.example.Milab2
```

### 2. Run semua flow

Emulator harus nyala dan app harus sudah terpasang.

```powershell
C:\maestro\maestro\bin\maestro.bat test automation\flows\
```

Satu flow saja:

```powershell
C:\maestro\maestro\bin\maestro.bat test automation\flows\01_home_menu.yaml
```

Pin device tertentu (kalau ada lebih dari satu device/emulator):

```powershell
C:\maestro\maestro\bin\maestro.bat test automation\flows\ --udid emulator-5554
```

> `maestro.bat` tidak ada di PATH, jadi harus disebut pakai path lengkap
> (`C:\maestro\maestro\bin\maestro.bat`).

## Isi

| File | Task |
| --- | --- |
| `flows/01_home_menu.yaml` | Home → Our Product → detail produk → My Class → detail kelas → Download Task → download modul |
| `flows/02_lost_found.yaml` | Bottom nav Lost & Found → Item Details → Claim → form Report Lost Item |
| `flows/03_profile.yaml` | Bottom nav Profile → Main Info / Contact / Settings |

## Identifier yang dipakai (`tapOn: { id: ... }`)

| Identifier | Widget |
| --- | --- |
| `nav_home` | icon Home di bottom navbar |
| `nav_lost_found` | icon Lost & Found di bottom navbar |
| `nav_profile` | icon Profile di bottom navbar |
| `report_lost_item` | icon `+` di AppBar Lost & Found |
| `our_product_info` | icon `i` di AppBar Our Product |
| `home_view_all` | tombol `View All` di Home |
| `report_item_name` | input `Item Name` di form Report Lost Item |
| `report_location` | input `Location` di form Report Lost Item |
| `report_notes` | input `Additional Notes` di form Report Lost Item |

`Semantics(identifier: ...)` di Flutter otomatis bikin SemanticsNode sendiri, jadi
identifier-nya tidak ikut ke-merge ke string label gabungan dan tetap stabil walau
ukuran layar beda.

## Label yang dipakai (diambil langsung dari layar, bukan dari tebakan)

| Layar | Label |
| --- | --- |
| Home | `Hi, Faizallll`, `Other Services`, `Discover more possibilities`, `View All`, `Learn More`, `Menu Utama`, `My Class`, `Download Task`, `Schedule`, `Remember`, `Bad Student` |
| Our Product | `Our Product`, `.*SIMUTU Lab.*`, `.*About MiLab.*`, `.*Featured Service.*`, `.*About This Service.*`, `24/7`, `Get Started` |
| My Class | `My Classes`, `.*Pemrograman Mobile E.*`, `Class`, `Schedule` |
| Detail kelas | `.*Final Grade.*`, `.*Modul 1.*`, `Grade: A`, `Check Presence`, `.*Presence 1.*`, `.*Presence 2.*` |
| Download Task | `Download Task`, `.*Pemrograman Mobile E.*` |
| Download modul | `.*Course Materials.*`, `6 Modules Available`, `.*Module 1.*`, `.*Module 1 Files.*`, `.*Module Guide.*`, `.*Practice Files.*`, `.*Additional Resources.*`, `.*Downloading Files for Module 1.*` |
| Lost & Found | `Lost & Found`, `Lost Items`, `Help others find their belongings`, `.*Laptop Charger.*`, `.*Claimed.*`, `.*Unclaimed.*` |
| Item Details | `Item Details`, `.*Item Name.*`, `.*Location.*`, `.*Notes.*`, `.*Posted.*`, `Contact`, `Claim`, `.*Processing your claim.*` |
| Form Report | `.*Report Lost Item.*`, `.*Fill in the details below.*`, `Item Name`, `Location`, `Additional Notes`, `Add Photos`, `Cancel`, `Submit Report`, `.*Item has been reported successfully.*` |
| Profile | `Profile`, `.*Main Info.*`, `.*Contact.*`, `.*Settings.*`, `Ahmad Faizal`, `210123456`, `Switch to Assistant Mode`, `.*Switching to assistant mode.*`, `Contact Information`, `Account Settings`, `Role Management`, `Account Actions` |

## Hal yang wajib diingat

1. **Tunggu Home dulu sebelum tap navbar.**
   `tapOn` tidak menunggu app selesai launch. Kalau langsung tap setelah `launchApp`,
   tap-nya mendarat di splash screen dan flow gagal. Selalu `assertVisible: "Hi, Faizallll"`
   dulu sebelum tap icon bottom navbar.

2. **Widget tanpa teks tidak punya label di accessibility tree.**
   Bottom navbar (`lib/app/widget/bottom_navbar.dart`) pakai `GestureDetector` + `Icon`,
   dan icon AppBar cuma `Icon` biasa. Keduanya sudah dibungkus `Semantics(identifier: ...)`,
   jadi tap pakai `id`, bukan koordinat.

3. **Flutter menggabungkan label anak jadi satu accessibility string.**
   Contoh nyata di layar: `"Pemrograman Mobile E\nMonday | \nSeat: A23"`,
   `"Main Info\nTab 1 of 3"`, `"Report Lost Item\nFill in the details below"`.
   Karena Maestro mencocokkan seluruh string, label polos seperti `"Main Info"` atau
   `"Pemrograman Mobile E"` TIDAK match. Pakai regex: `.*Pemrograman Mobile E.*`.
   Ini juga sebabnya `tapOn: "Download"` gagal — `"Download"` selalu menempel di akhir
   string `"Module 1\n... \nDownload"`. Pakai `.*Module 1.*` untuk tap kartunya.

4. **Jangan pakai `hideKeyboard` sebelum `Submit Report`.**
   Di form ini `hideKeyboard` ikut menutup bottom sheet-nya, jadi tombol Submit hilang.
   Tap `Submit Report` langsung saja, Maestro tetap bisa menemukannya.

5. **Jangan pakai `hideKeyboard` sebelum `Submit Report`.**
   Di form ini `hideKeyboard` ikut menutup bottom sheet-nya, jadi tombol Submit hilang.
   Tap `Submit Report` langsung saja, Maestro tetap bisa menemukannya.

6. **Snackbar pakai helper `AppSnackbar`, jangan `Get.snackbar`.**
   `Get.snackbar` GAGAL di app ini — GetX lookup `Overlay` lewat queue-nya sendiri dan
   melempar `Unhandled Exception: No Overlay widget found.` (dari
   `SnackbarController._configureOverlay`), jadi tidak ada snackbar yang pernah render.
   Semua call site sekarang pakai `lib/app/widget/app_snackbar.dart` yang memakai
   `ScaffoldMessenger` bawaan Flutter:

   ```dart
   AppSnackbar.show(context, title: "Switch Role", message: "Switching to assistant mode...");
   ```

   Kalau context-nya sudah/akan di-dispose (mis. dialog yang `Get.back()` sebelum
   lapor hasil), resolve messenger-nya dulu lalu pakai `AppSnackbar.showOn(messenger, ...)`.

7. **Jangan pasang `extendBodyBehindAppBar: true` di halaman yang ada tombol di atas.**
   Di Home, flag ini bikin AppBar menutupi area atas body sampai y≈324px, sementara
   rect accessibility tombol `View All` berpusat di y≈321px. Maestro tap pakai koordinat
   pusat rect itu, jadi tap-nya nyangkut di AppBar dan tidak ada yang terjadi
   (walaupun log-nya bilang `Tap on ... COMPLETED`). Flag-nya sudah dilepas dari
   `home_view.dart` dan spacer diringkas dari 80px ke 16px.

## Catatan

Kalau nambah widget baru yang mau di-tap automation tapi tidak punya teks (icon/button
tanpa label), bungkus pakai `Semantics(identifier: 'nama_id', child: ...)` lalu tap pakai
`tapOn: { id: "nama_id" }`. Contoh: `lib/app/widget/bottom_navbar.dart`.
