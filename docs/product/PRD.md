# Welmae - Product Requirements Document (PRD)

## 📋 **Doküman Bilgileri**

- **Versiyon**: 1.0.0
- **Oluşturulma Tarihi**: 29 Ağustos 2025
- **Son Güncelleme**: 29 Ağustos 2025
- **Hazırlayan**: AI Assistant
- **Onaylayan**: Senol (Product Owner)
- **Durum**: Draft - Geliştirme Aşamasında

---

## 🎯 **1. Ürün Özeti**

### **1.1 Ürün Vizyonu**
Welmae, seyahat tutkunlarının deneyimlerini paylaşabilecekleri, birlikte seyahat planlayabilecekleri ve sosyal bir seyahat topluluğu oluşturabilecekleri kapsamlı bir mobil platformdur.

### **1.2 Temel Değer Önerisi**
- **Seyahat Deneyimlerini Paylaşma**: Kullanıcılar seyahatlerini fotoğraf, video ve hikayelerle paylaşabilir
- **Birlikte Seyahat Planlama**: Arkadaşlarla ortak seyahat planları oluşturulabilir
- **Sosyal Seyahat Ağı**: Benzer ilgi alanlarına sahip seyahatçılarla bağlantı kurulabilir
- **Seyahat Rehberi**: Kullanıcı deneyimlerine dayalı güvenilir seyahat önerileri

### **1.3 Hedef Kitle**
- **Birincil**: 25-45 yaş arası seyahat tutkunları
- **İkincil**: 18-24 yaş arası genç seyahatçılar
- **Üçüncül**: 45+ yaş arası deneyimli seyahatçılar

---

## 🚀 **2. Ürün Hedefleri**

### **2.1 Kısa Vadeli Hedefler (3-6 ay)**
- MVP ile temel seyahat paylaşım özelliklerini sunmak
- 10,000+ aktif kullanıcıya ulaşmak
- iOS ve Android platformlarında stabil çalışan uygulama

### **2.2 Orta Vadeli Hedefler (6-12 ay)**
- Sosyal özellikler ve grup seyahat planlaması
- 100,000+ aktif kullanıcı
- Web platformu eklemek

### **2.3 Uzun Vadeli Hedefler (12+ ay)**
- AI destekli seyahat önerileri
- 1M+ aktif kullanıcı
- Uluslararası pazarlara açılmak

---

## 🎨 **3. Kullanıcı Deneyimi Gereksinimleri**

### **3.1 Kullanıcı Arayüzü Prensipleri**
- **Basitlik**: Karmaşık özellikler basit arayüzlerle sunulmalı
- **Tutarlılık**: Tüm ekranlarda tutarlı tasarım dili
- **Erişilebilirlik**: Farklı yetenek seviyelerindeki kullanıcılar için uygun
- **Hızlılık**: 2 saniyeden az yükleme süreleri

### **3.2 Responsive Tasarım**
- **Mobil Öncelikli**: Önce mobil tasarım, sonra tablet ve web
- **Adaptif Layout**: Farklı ekran boyutlarına uyum
- **Touch Friendly**: Dokunmatik etkileşimler için optimize

### **3.3 Erişilebilirlik**
- **WCAG 2.1 AA** standartlarına uygunluk
- **Screen Reader** desteği
- **Yüksek Kontrast** modları
- **Büyük Yazı Tipi** seçenekleri

---

## 🔧 **4. Teknik Gereksinimler**

### **4.1 Platform Gereksinimleri**
- **iOS**: iOS 13.0+ (iPhone 6s+)
- **Android**: Android 7.0+ (API level 24+)
- **Web**: Modern tarayıcılar (Chrome 80+, Safari 13+, Firefox 75+)

### **4.2 Performans Gereksinimleri**
- **Uygulama Başlatma**: < 3 saniye
- **Ekran Geçişleri**: < 300ms
- **Görsel Yükleme**: < 2 saniye
- **Offline Çalışma**: Temel özellikler için

### **4.3 Güvenlik Gereksinimleri**
- **Kullanıcı Kimlik Doğrulama**: JWT token tabanlı
- **Veri Şifreleme**: AES-256
- **API Güvenliği**: HTTPS, rate limiting
- **Gizlilik**: GDPR uyumlu veri işleme

---

## 📱 **5. Temel Özellikler**

### **5.1 Kullanıcı Yönetimi**
- **Kayıt ve Giriş**: Email, telefon, sosyal medya ile
- **Profil Yönetimi**: Fotoğraf, bio, seyahat tercihleri
- **Arkadaş Sistemi**: Takip etme, takip edilme
- **Bildirimler**: Push, email, in-app

### **5.2 Seyahat Paylaşımı**
- **Post Oluşturma**: Fotoğraf, video, metin, konum
- **Seyahat Günlüğü**: Günlük girişler, rota takibi
- **Etiketleme**: Kişiler, yerler, aktiviteler
- **Beğeni ve Yorum**: Sosyal etkileşim

### **5.3 Seyahat Planlama**
- **Rota Oluşturma**: Harita tabanlı planlama
- **Grup Planlaması**: Ortak seyahat organizasyonu
- **Bütçe Takibi**: Harcama yönetimi
- **Hatırlatıcılar**: Önemli tarihler ve görevler

### **5.4 Keşfet ve Arama**
- **Popüler Destinasyonlar**: Trend seyahat noktaları
- **Kullanıcı Önerileri**: Deneyim tabanlı tavsiyeler
- **Filtreleme**: Bütçe, süre, aktivite türü
- **Harita Görünümü**: Coğrafi keşif

---

## 🔄 **6. Kullanıcı Akışları**

### **6.1 Yeni Kullanıcı Onboarding**
1. **Uygulama İndirme** → App Store/Play Store
2. **Kayıt** → Email/telefon ile hesap oluşturma
3. **Profil Kurulumu** → Fotoğraf, isim, ilgi alanları
4. **İlk Seyahat Ekleme** → Demo seyahat oluşturma
5. **Arkadaş Bulma** → Kişi listesinden arkadaş ekleme

### **6.2 Seyahat Paylaşım Akışı**
1. **Seyahat Başlatma** → Yeni seyahat oluşturma
2. **İçerik Ekleme** → Fotoğraf, video, metin ekleme
3. **Konum Belirleme** → Harita üzerinde işaretleme
4. **Etiketleme** → Kişiler, yerler, aktiviteler
5. **Paylaşım** → Sosyal medyada paylaşma

### **6.3 Grup Seyahat Planlama**
1. **Grup Oluşturma** → Arkadaşlarla grup kurma
2. **Rota Planlama** → Ortak rota belirleme
3. **Görev Dağılımı** → Sorumlulukların paylaşımı
4. **Bütçe Yönetimi** → Ortak harcama takibi
5. **Seyahat Gerçekleştirme** → Planlanan rotayı takip etme

---

## 📊 **7. Veri Gereksinimleri**

### **7.1 Kullanıcı Verileri**
- **Kişisel Bilgiler**: Ad, soyad, email, telefon
- **Profil Bilgileri**: Fotoğraf, bio, seyahat tercihleri
- **Sosyal Veriler**: Arkadaş listesi, takip edilenler
- **Tercih Verileri**: Seyahat stilleri, bütçe aralıkları

### **7.2 Seyahat Verileri**
- **Seyahat Detayları**: Tarih, süre, bütçe, rota
- **İçerik Verileri**: Fotoğraf, video, metin, konum
- **Etkileşim Verileri**: Beğeni, yorum, paylaşım
- **Meta Veriler**: Zaman damgası, cihaz bilgisi

### **7.3 Analitik Veriler**
- **Kullanım Metrikleri**: Ekran görüntüleme, özellik kullanımı
- **Performans Verileri**: Yükleme süreleri, hata oranları
- **Kullanıcı Davranışları**: Navigasyon paternleri, tercihler

---

## 🔒 **8. Gizlilik ve Güvenlik**

### **8.1 Veri Gizliliği**
- **Kullanıcı Onayı**: Açık rıza ile veri toplama
- **Veri Minimizasyonu**: Sadece gerekli verilerin toplanması
- **Şeffaflık**: Veri kullanımı hakkında açık bilgilendirme
- **Kullanıcı Hakları**: Veri erişimi, düzeltme, silme

### **8.2 Güvenlik Önlemleri**
- **Veri Şifreleme**: Aktarım ve depolama sırasında
- **Erişim Kontrolü**: Rol tabanlı yetkilendirme
- **Güvenlik Testleri**: Düzenli penetrasyon testleri
- **İzleme ve Loglama**: Güvenlik olaylarının takibi

---

## 📈 **9. Başarı Metrikleri**

### **9.1 Kullanıcı Metrikleri**
- **Aktif Kullanıcı Sayısı**: DAU, WAU, MAU
- **Kullanıcı Tutma Oranı**: 1, 7, 30 günlük retention
- **Kullanıcı Büyüme Hızı**: Aylık yeni kullanıcı artışı
- **Kullanıcı Memnuniyeti**: App Store puanları, kullanıcı geri bildirimleri

### **9.2 İçerik Metrikleri**
- **Seyahat Paylaşım Sayısı**: Günlük, haftalık, aylık
- **Etkileşim Oranları**: Beğeni, yorum, paylaşım oranları
- **İçerik Kalitesi**: Kullanıcı raporları, moderasyon metrikleri
- **Trend İçerikler**: Popüler destinasyonlar, aktiviteler

### **9.3 Teknik Metrikleri**
- **Uygulama Performansı**: Crash oranı, yükleme süreleri
- **API Performansı**: Response time, error rate
- **Sistem Uptime**: 99.9% hedef
- **Güvenlik Olayları**: Tespit edilen güvenlik açıkları

---

## 🚧 **10. Kısıtlamalar ve Riskler**

### **10.1 Teknik Kısıtlamalar**
- **Platform Sınırlamaları**: iOS ve Android API kısıtlamaları
- **Veri Depolama**: Kullanıcı başına maksimum veri miktarı
- **API Limitleri**: Üçüncü parti servis kullanım sınırları
- **Offline Çalışma**: Sınırlı offline özellikler

### **10.2 İş Kısıtlamaları**
- **Bütçe Sınırlamaları**: Geliştirme ve operasyon maliyetleri
- **Zaman Kısıtlamaları**: MVP lansman tarihi
- **Regülasyon Uyumluluğu**: GDPR, KVKK gibi yasal gereklilikler
- **Pazar Rekabeti**: Mevcut seyahat uygulamaları

### **10.3 Riskler ve Azaltma Stratejileri**
- **Teknik Riskler**: Düzenli kod review, test otomasyonu
- **Güvenlik Riskleri**: Güvenlik testleri, güncellemeler
- **Kullanıcı Kabulü**: Beta testleri, kullanıcı geri bildirimleri
- **Performans Riskleri**: Load testing, monitoring

---

## 📅 **11. Zaman Çizelgesi**

### **11.1 Faz 1: MVP (3 ay)**
- **Ay 1**: Temel kullanıcı yönetimi ve seyahat paylaşımı
- **Ay 2**: Sosyal özellikler ve temel arama
- **Ay 3**: Test, optimizasyon ve lansman hazırlığı

### **11.2 Faz 2: Gelişmiş Özellikler (3 ay)**
- **Ay 4-5**: Grup seyahat planlama ve bütçe yönetimi
- **Ay 6**: Web platformu ve gelişmiş analitik

### **11.3 Faz 3: Ölçeklendirme (6 ay)**
- **Ay 7-9**: AI özellikleri ve kişiselleştirme
- **Ay 10-12**: Uluslararası pazarlar ve gelişmiş özellikler

---

## 📋 **12. Onay ve İmza**

| Rol | Ad | Tarih | İmza |
|-----|-----|-------|------|
| Product Owner | Senol | 29.08.2025 | [ ] |
| Technical Lead | AI Assistant | 29.08.2025 | [ ] |
| Design Lead | TBD | TBD | [ ] |
| Development Lead | TBD | TBD | [ ] |

---

## 📝 **13. Değişiklik Geçmişi**

| Versiyon | Tarih | Değişiklik | Yazan |
|----------|-------|------------|-------|
| 1.0.0 | 29.08.2025 | İlk versiyon | AI Assistant |

---

## 🔗 **İlgili Dokümanlar**

- [User Stories](./user-stories.md)
- [Technical Architecture](../technical/architecture.md)
- [API Documentation](../technical/api.md)
- [Design System](../design/design-system.md)
- [Task Matrix](../project/task-matrix.md)
