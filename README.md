# Welmae - Flutter Mobile App

## 📱 Proje Hakkında

Welmae, seyahat ve keşif odaklı bir mobil uygulama projesidir. Flutter framework kullanılarak geliştirilmiş olup, iOS ve Android platformlarında çalışmaktadır.

## 🚀 Teknolojiler

- **Framework**: Flutter 3.35.2
- **Dil**: Dart
- **Platform**: iOS, Android, Web
- **State Management**: StatefulWidget + setState
- **Navigation**: BottomNavigationBar + Named Routes
- **UI Components**: Material Design 3

## 🏗️ Proje Yapısı

```
welmae_flutter/
├── lib/
│   ├── main.dart                 # Ana uygulama girişi
│   └── screens/                  # Ekran bileşenleri
│       ├── onboarding_screen.dart    # Onboarding ekranı
│       ├── home_screen.dart          # Ana sayfa
│       ├── explore_screen.dart       # Keşfet ekranı
│       ├── trips_screen.dart         # Seyahatler ekranı
│       ├── profile_screen.dart       # Profil ekranı
│       └── destination_detail_screen.dart # Destinasyon detay ekranı
├── android/                      # Android platform dosyaları
├── ios/                         # iOS platform dosyaları
└── pubspec.yaml                 # Flutter bağımlılıkları
```

## ✨ Özellikler

### 🔐 Onboarding
- 3 sayfalık tanıtım deneyimi
- Skip ve Get Started butonları
- Sayfa göstergeleri

### 🏠 Ana Sayfa
- Kişiselleştirilmiş header
- Arama çubuğu
- Hızlı aksiyonlar
- Öne çıkan destinasyonlar
- Özel teklif banner'ı
- Son seyahatler listesi

### 🔍 Keşfet
- Kategori filtreleme
- Destinasyon arama
- Grid layout ile kart görünümü
- Favori ekleme/çıkarma
- Detay sayfasına yönlendirme

### ✈️ Seyahatler
- Seyahat istatistikleri
- Yaklaşan/Geçmiş seyahatler
- Tab navigasyonu
- Detaylı seyahat kartları
- Durum göstergeleri

### 👤 Profil
- Gradient avatar
- Kullanıcı istatistikleri
- Hızlı aksiyonlar
- Ayarlar (switch'ler)
- Menü öğeleri
- Çıkış yapma fonksiyonu

### 🗺️ Destinasyon Detay
- Hero image carousel
- Destinasyon bilgileri
- Açıklama ve özellikler
- Galeri
- Yorumlar önizlemesi
- Harita placeholder
- Rezervasyon butonu

## 🎨 Tasarım

- **Renk Paleti**: Mavi tonları (#2563EB ana renk)
- **Material Design 3**: Modern ve tutarlı UI
- **Responsive Layout**: Farklı ekran boyutlarına uyumlu
- **Custom Components**: Özel tasarlanmış widget'lar

## 🚀 Kurulum ve Çalıştırma

### Gereksinimler
- Flutter SDK 3.35.2+
- Android Studio / Xcode
- CocoaPods (iOS için)

### Adımlar
1. Repository'yi klonlayın:
```bash
git clone <repository-url>
cd welmae_flutter
```

2. Bağımlılıkları yükleyin:
```bash
flutter pub get
```

3. iOS için CocoaPods yükleyin:
```bash
cd ios && pod install && cd ..
```

4. Uygulamayı çalıştırın:
```bash
# Android
flutter run -d android

# iOS
flutter run -d ios

# Web
flutter run -d chrome
```

## 📱 Build Alma

### Android APK
```bash
flutter build apk --release
```

### Android App Bundle
```bash
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

## 🔧 Geliştirme Notları

- **Navigation**: Named routes kullanılarak yönetiliyor
- **State Management**: Basit state yönetimi için StatefulWidget kullanılıyor
- **Error Handling**: Image loading hatalarında fallback UI gösteriliyor
- **Performance**: Lazy loading ve efficient list rendering

## 📋 Yapılacaklar

- [ ] Figma tasarımlarına tam uyum
- [ ] State management (Provider/Bloc) entegrasyonu
- [ ] API entegrasyonu
- [ ] Local storage
- [ ] Push notifications
- [ ] Deep linking
- [ ] Unit tests
- [ ] Widget tests
- [ ] Integration tests

## 🤝 Katkıda Bulunma

1. Fork yapın
2. Feature branch oluşturun (`git checkout -b feature/amazing-feature`)
3. Commit yapın (`git commit -m 'Add amazing feature'`)
4. Push yapın (`git push origin feature/amazing-feature`)
5. Pull Request oluşturun

## 📄 Lisans

Bu proje MIT lisansı altında lisanslanmıştır.

## 👨‍💻 Geliştirici

- **Senol** - *Initial work* - [GitHub](https://github.com/yourusername)

## 🙏 Teşekkürler

- Flutter team
- Material Design team
- Figma design inspiration
