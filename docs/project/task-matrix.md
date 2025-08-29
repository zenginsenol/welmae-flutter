# Welmae - Task Matrix ve Proje Yönetimi

## 📋 **Doküman Bilgileri**

- **Versiyon**: 1.0.0
- **Oluşturulma Tarihi**: 29 Ağustos 2025
- **Son Güncelleme**: 29 Ağustos 2025
- **Hazırlayan**: AI Assistant
- **Onaylayan**: Senol (Product Owner)
- **Durum**: Draft - Geliştirme Aşamasında

---

## 🎯 **1. Proje Genel Bakış**

### **1.1 Proje Hedefleri**
- **MVP**: 3 ay içinde temel seyahat paylaşım özellikleri
- **Kullanıcı Hedefi**: 10,000+ aktif kullanıcı
- **Platform**: iOS, Android, Web
- **Kalite**: %99.9 uptime, < 3s response time

### **1.2 Proje Fazları**
- **Faz 1 (Ay 1-3)**: MVP - Temel özellikler
- **Faz 2 (Ay 4-6)**: Sosyal özellikler ve gelişmiş planlama
- **Faz 3 (Ay 7-12)**: AI özellikleri ve ölçeklendirme

---

## 📊 **2. Task Matrix - Faz 1 (MVP)**

### **2.1 Sprint 1: Temel Altyapı (Hafta 1-2)**

#### **🔧 Backend Altyapı**
| Task ID | Task Name | Description | Priority | Effort | Assignee | Status | Dependencies |
|---------|-----------|-------------|----------|---------|----------|---------|--------------|
| BE-001 | Database Setup | PostgreSQL veritabanı kurulumu ve şema oluşturma | High | 3 days | Backend Dev | Pending | - |
| BE-002 | API Gateway | Kong/Nginx tabanlı API gateway kurulumu | High | 2 days | DevOps | Pending | BE-001 |
| BE-003 | Auth Service | JWT tabanlı kimlik doğrulama servisi | High | 4 days | Backend Dev | Pending | BE-002 |
| BE-004 | User Service | Kullanıcı yönetimi API'leri | High | 3 days | Backend Dev | Pending | BE-001 |
| BE-005 | Basic CI/CD | GitHub Actions ile temel CI/CD pipeline | Medium | 2 days | DevOps | Pending | - |

#### **📱 Flutter Altyapı**
| Task ID | Task Name | Description | Priority | Effort | Assignee | Status | Dependencies |
|---------|-----------|-------------|----------|---------|----------|---------|--------------|
| FL-001 | Project Structure | Clean Architecture ile proje yapısı | High | 2 days | Flutter Dev | Pending | - |
| FL-002 | Theme System | Material Design 3 tema sistemi | High | 2 days | Flutter Dev | Pending | FL-001 |
| FL-003 | Navigation Setup | GoRouter ile navigasyon yapısı | High | 3 days | Flutter Dev | Pending | FL-002 |
| FL-004 | State Management | Riverpod ile state management kurulumu | High | 3 days | Flutter Dev | Pending | FL-003 |
| FL-005 | Network Layer | Dio ile HTTP client ve interceptor'lar | High | 2 days | Flutter Dev | Pending | FL-004 |

#### **🎨 UI/UX Altyapı**
| Task ID | Task Name | Description | Priority | Effort | Assignee | Status | Dependencies |
|---------|-----------|-------------|----------|---------|----------|---------|--------------|
| UI-001 | Design System | Renk paleti, tipografi, spacing sistemi | High | 3 days | UI Designer | Pending | - |
| UI-002 | Component Library | Temel UI bileşenleri (Button, Input, Card) | High | 4 days | UI Designer | Pending | UI-001 |
| UI-003 | Icon Set | Material Icons ve custom icon set | Medium | 2 days | UI Designer | Pending | UI-002 |
| UI-004 | Responsive Layout | Farklı ekran boyutları için layout sistemi | Medium | 3 days | UI Designer | Pending | UI-003 |

### **2.2 Sprint 2: Kullanıcı Yönetimi (Hafta 3-4)**

#### **🔐 Authentication & Authorization**
| Task ID | Task Name | Description | Priority | Effort | Assignee | Status | Dependencies |
|---------|-----------|-------------|----------|---------|----------|---------|--------------|
| AUTH-001 | Login Screen | Email/şifre ile giriş ekranı | High | 3 days | Flutter Dev | Pending | FL-005, UI-004 |
| AUTH-002 | Register Screen | Kullanıcı kayıt ekranı | High | 3 days | Flutter Dev | Pending | AUTH-001 |
| AUTH-003 | Forgot Password | Şifre sıfırlama ekranı | Medium | 2 days | Flutter Dev | Pending | AUTH-002 |
| AUTH-004 | Profile Setup | İlk giriş profil kurulum ekranı | High | 3 days | Flutter Dev | Pending | AUTH-003 |
| AUTH-005 | Auth State Management | Giriş durumu yönetimi | High | 2 days | Flutter Dev | Pending | AUTH-004 |

#### **👤 User Management**
| Task ID | Task Name | Description | Priority | Effort | Assignee | Status | Dependencies |
|---------|-----------|-------------|----------|---------|----------|---------|--------------|
| USER-001 | User Profile Screen | Kullanıcı profil ekranı | High | 4 days | Flutter Dev | Pending | AUTH-005 |
| USER-002 | Edit Profile | Profil düzenleme ekranı | Medium | 3 days | Flutter Dev | Pending | USER-001 |
| USER-003 | Settings Screen | Uygulama ayarları ekranı | Medium | 3 days | Flutter Dev | Pending | USER-002 |
| USER-004 | User API Integration | Backend ile kullanıcı API entegrasyonu | High | 3 days | Flutter Dev | Pending | BE-004 |

### **2.3 Sprint 3: Seyahat Yönetimi (Hafta 5-6)**

#### **✈️ Travel Management**
| Task ID | Task Name | Description | Priority | Effort | Assignee | Status | Dependencies |
|---------|-----------|-------------|----------|---------|----------|---------|--------------|
| TRAVEL-001 | Travel Service | Seyahat CRUD API'leri | High | 4 days | Backend Dev | Pending | BE-001 |
| TRAVEL-002 | Create Travel Screen | Yeni seyahat oluşturma ekranı | High | 4 days | Flutter Dev | Pending | TRAVEL-001 |
| TRAVEL-003 | Travel List Screen | Seyahat listesi ekranı | High | 3 days | Flutter Dev | Pending | TRAVEL-002 |
| TRAVEL-004 | Travel Detail Screen | Seyahat detay ekranı | High | 4 days | Flutter Dev | Pending | TRAVEL-003 |
| TRAVEL-005 | Travel Edit Screen | Seyahat düzenleme ekranı | Medium | 3 days | Flutter Dev | Pending | TRAVEL-004 |

#### **📝 Post Management**
| Task ID | Task Name | Description | Priority | Effort | Assignee | Status | Dependencies |
|---------|-----------|-------------|----------|---------|----------|---------|--------------|
| POST-001 | Post Service | Post CRUD API'leri | High | 4 days | Backend Dev | Pending | BE-001 |
| POST-002 | Create Post Screen | Yeni post oluşturma ekranı | High | 4 days | Flutter Dev | Pending | POST-001 |
| POST-003 | Post List Screen | Post listesi ekranı | High | 3 days | Flutter Dev | Pending | POST-002 |
| POST-004 | Post Detail Screen | Post detay ekranı | High | 3 days | Flutter Dev | Pending | POST-003 |
| POST-005 | Media Upload | Fotoğraf/video yükleme sistemi | High | 3 days | Backend Dev | Pending | POST-001 |

### **2.4 Sprint 4: Ana Ekranlar (Hafta 7-8)**

#### **🏠 Home Screen**
| Task ID | Task Name | Description | Priority | Effort | Assignee | Status | Dependencies |
|---------|-----------|-------------|----------|---------|----------|---------|--------------|
| HOME-001 | Home Screen Layout | Ana sayfa layout tasarımı | High | 3 days | UI Designer | Pending | UI-004 |
| HOME-002 | Feed Implementation | Seyahat ve post feed'i | High | 4 days | Flutter Dev | Pending | HOME-001, POST-004 |
| HOME-003 | Quick Actions | Hızlı aksiyon butonları | Medium | 2 days | Flutter Dev | Pending | HOME-002 |
| HOME-004 | Personalized Content | Kullanıcıya özel içerik | Medium | 3 days | Flutter Dev | Pending | HOME-003 |

#### **🔍 Explore Screen**
| Task ID | Task Name | Description | Priority | Effort | Assignee | Status | Dependencies |
|---------|-----------|-------------|----------|---------|----------|---------|--------------|
| EXPLORE-001 | Explore Layout | Keşfet ekranı layout tasarımı | High | 3 days | UI Designer | Pending | UI-004 |
| EXPLORE-002 | Category System | Seyahat kategorileri | High | 3 days | Flutter Dev | Pending | EXPLORE-001 |
| EXPLORE-003 | Search Implementation | Arama fonksiyonalitesi | High | 4 days | Flutter Dev | Pending | EXPLORE-002 |
| EXPLORE-004 | Filter System | Filtreleme sistemi | Medium | 3 days | Flutter Dev | Pending | EXPLORE-003 |

### **2.5 Sprint 5: Sosyal Özellikler (Hafta 9-10)**

#### **👥 Social Features**
| Task ID | Task Name | Description | Priority | Effort | Assignee | Status | Dependencies |
|---------|-----------|-------------|----------|---------|----------|---------|--------------|
| SOCIAL-001 | Follow System | Takip etme/takip edilme sistemi | High | 4 days | Backend Dev | Pending | BE-001 |
| SOCIAL-002 | Like System | Beğeni sistemi | High | 3 days | Backend Dev | Pending | SOCIAL-001 |
| SOCIAL-003 | Comment System | Yorum sistemi | High | 4 days | Backend Dev | Pending | SOCIAL-002 |
| SOCIAL-004 | Social UI | Sosyal özellikler UI'ı | High | 4 days | Flutter Dev | Pending | SOCIAL-003 |

#### **🔔 Notifications**
| Task ID | Task Name | Description | Priority | Effort | Assignee | Status | Dependencies |
|---------|-----------|-------------|----------|---------|----------|---------|--------------|
| NOTIF-001 | Notification Service | Push notification servisi | Medium | 4 days | Backend Dev | Pending | SOCIAL-001 |
| NOTIF-002 | Notification UI | Bildirim ekranı | Medium | 3 days | Flutter Dev | Pending | NOTIF-001 |
| NOTIF-003 | Push Integration | Firebase push notification entegrasyonu | Medium | 3 days | Flutter Dev | Pending | NOTIF-002 |

### **2.6 Sprint 6: Test ve Optimizasyon (Hafta 11-12)**

#### **🧪 Testing**
| Task ID | Task Name | Description | Priority | Effort | Assignee | Status | Dependencies |
|---------|-----------|-------------|----------|---------|----------|---------|--------------|
| TEST-001 | Unit Tests | Backend unit testleri | High | 4 days | Backend Dev | Pending | All Backend Tasks |
| TEST-002 | Widget Tests | Flutter widget testleri | High | 4 days | Flutter Dev | Pending | All Flutter Tasks |
| TEST-003 | Integration Tests | End-to-end testler | Medium | 5 days | QA Engineer | Pending | TEST-001, TEST-002 |
| TEST-004 | Performance Tests | Performans testleri | Medium | 3 days | DevOps | Pending | TEST-003 |

#### **⚡ Optimization**
| Task ID | Task Name | Description | Priority | Effort | Assignee | Status | Dependencies |
|---------|-----------|-------------|----------|---------|----------|---------|--------------|
| OPT-001 | Performance Optimization | Flutter performans optimizasyonu | High | 3 days | Flutter Dev | Pending | TEST-004 |
| OPT-002 | Database Optimization | Veritabanı performans optimizasyonu | High | 3 days | Backend Dev | Pending | OPT-001 |
| OPT-003 | API Optimization | API response time optimizasyonu | Medium | 2 days | Backend Dev | Pending | OPT-002 |

---

## 📊 **3. Task Matrix - Faz 2 (Gelişmiş Özellikler)**

### **3.1 Sprint 7: Grup Seyahat Planlama (Hafta 13-14)**

| Task ID | Task Name | Description | Priority | Effort | Assignee | Status | Dependencies |
|---------|-----------|-------------|----------|---------|----------|---------|--------------|
| GROUP-001 | Group Service | Grup yönetimi API'leri | High | 5 days | Backend Dev | Pending | TRAVEL-001 |
| GROUP-002 | Group Creation | Grup oluşturma ekranı | High | 4 days | Flutter Dev | Pending | GROUP-001 |
| GROUP-003 | Member Management | Grup üye yönetimi | High | 4 days | Flutter Dev | Pending | GROUP-002 |
| GROUP-004 | Shared Planning | Ortak seyahat planlama | High | 5 days | Flutter Dev | Pending | GROUP-003 |

### **3.2 Sprint 8: Bütçe Yönetimi (Hafta 15-16)**

| Task ID | Task Name | Description | Priority | Effort | Assignee | Status | Dependencies |
|---------|-----------|-------------|----------|---------|----------|---------|--------------|
| BUDGET-001 | Budget Service | Bütçe yönetimi API'leri | Medium | 4 days | Backend Dev | Pending | TRAVEL-001 |
| BUDGET-002 | Budget Tracking | Bütçe takip ekranı | Medium | 4 days | Flutter Dev | Pending | BUDGET-001 |
| BUDGET-003 | Expense Management | Harcama yönetimi | Medium | 3 days | Flutter Dev | Pending | BUDGET-002 |
| BUDGET-004 | Budget Analytics | Bütçe analitikleri | Low | 3 days | Flutter Dev | Pending | BUDGET-003 |

### **3.3 Sprint 9: Web Platform (Hafta 17-18)**

| Task ID | Task Name | Description | Priority | Effort | Assignee | Status | Dependencies |
|---------|-----------|-------------|----------|---------|----------|---------|--------------|
| WEB-001 | Web Adaptation | Flutter web uyarlaması | High | 5 days | Flutter Dev | Pending | All Flutter Tasks |
| WEB-002 | Responsive Design | Web responsive tasarım | High | 4 days | UI Designer | Pending | WEB-001 |
| WEB-003 | Web Optimization | Web performans optimizasyonu | Medium | 3 days | Flutter Dev | Pending | WEB-002 |

---

## 📊 **4. Task Matrix - Faz 3 (Ölçeklendirme)**

### **4.1 Sprint 10-12: AI Özellikleri (Hafta 19-24)**

| Task ID | Task Name | Description | Priority | Effort | Assignee | Status | Dependencies |
|---------|-----------|-------------|----------|---------|----------|---------|--------------|
| AI-001 | AI Service | AI öneri servisi | Medium | 6 days | AI Engineer | Pending | All Backend Tasks |
| AI-002 | Travel Recommendations | AI destekli seyahat önerileri | Medium | 5 days | Flutter Dev | Pending | AI-001 |
| AI-003 | Content Personalization | İçerik kişiselleştirme | Low | 4 days | Flutter Dev | Pending | AI-002 |

---

## 📈 **5. Proje Metrikleri ve KPI'lar**

### **5.1 Geliştirme Metrikleri**
- **Velocity**: Sprint başına tamamlanan story point
- **Burndown**: Sprint içinde kalan iş miktarı
- **Lead Time**: Task'ın başlangıçtan tamamlanmasına kadar geçen süre
- **Cycle Time**: Task'ın aktif çalışılmaya başlanmasından tamamlanmasına kadar geçen süre

### **5.2 Kalite Metrikleri**
- **Bug Rate**: 1000 satır kod başına hata sayısı
- **Test Coverage**: Kod test kapsamı yüzdesi
- **Code Review**: Code review tamamlanma oranı
- **Technical Debt**: Teknik borç miktarı

### **5.3 Proje Metrikleri**
- **On-Time Delivery**: Zamanında teslim edilen sprint yüzdesi
- **Scope Creep**: Kapsam değişikliği miktarı
- **Team Velocity**: Takım hızı trendi
- **Resource Utilization**: Kaynak kullanım oranı

---

## 🔄 **6. Sprint Yönetimi**

### **6.1 Sprint Süreci**
1. **Sprint Planning**: Sprint hedefleri ve task breakdown
2. **Daily Standup**: Günlük ilerleme takibi
3. **Sprint Review**: Sprint sonuçlarının değerlendirilmesi
4. **Retrospective**: İyileştirme alanlarının belirlenmesi

### **6.2 Sprint Ceremonies**
- **Sprint Planning**: 2 saat (2 haftalık sprint için)
- **Daily Standup**: 15 dakika (her gün)
- **Sprint Review**: 1 saat (sprint sonunda)
- **Retrospective**: 1 saat (sprint sonunda)

---

## 📋 **7. Risk Yönetimi**

### **7.1 Teknik Riskler**
| Risk | Probability | Impact | Mitigation Strategy |
|------|-------------|---------|-------------------|
| Backend Performance | Medium | High | Load testing, caching strategy |
| Flutter Compatibility | Low | Medium | Platform testing, fallback plans |
| API Security | Medium | High | Security audits, penetration testing |
| Database Scalability | Low | High | Performance monitoring, optimization |

### **7.2 Proje Riskleri**
| Risk | Probability | Impact | Mitigation Strategy |
|------|-------------|---------|-------------------|
| Scope Creep | High | Medium | Change control process, stakeholder alignment |
| Resource Constraints | Medium | High | Resource planning, backup resources |
| Timeline Delays | Medium | High | Buffer time, parallel development |
| Quality Issues | Low | High | Code review, testing strategy |

---

## 🛠️ **8. Araçlar ve Teknolojiler**

### **8.1 Proje Yönetimi**
- **Project Management**: Jira, Asana, or GitHub Projects
- **Communication**: Slack, Microsoft Teams
- **Documentation**: Confluence, Notion, or GitHub Wiki
- **Version Control**: Git, GitHub

### **8.2 Geliştirme Araçları**
- **IDE**: VS Code, Android Studio, Xcode
- **Design**: Figma, Adobe XD
- **Testing**: Flutter Test, Postman, Jest
- **CI/CD**: GitHub Actions, Jenkins, or GitLab CI

---

## 📞 **9. İletişim ve Raporlama**

### **9.1 Raporlama Sıklığı**
- **Daily**: Standup raporları
- **Weekly**: Sprint progress raporları
- **Bi-weekly**: Sprint review ve planning
- **Monthly**: Stakeholder raporları

### **9.2 İletişim Kanalları**
- **Development Team**: Slack/Teams development channel
- **Stakeholders**: Weekly email reports
- **Product Owner**: Daily sync meetings
- **External Teams**: Bi-weekly sync meetings

---

## 🔗 **10. İlgili Dokümanlar**

- [Product Requirements Document](../product/PRD.md)
- [Technical Architecture](../technical/architecture.md)
- [API Documentation](../technical/api.md)
- [Design System](../design/design-system.md)
- [Development Setup](../development/setup.md)

---

## 📝 **11. Değişiklik Geçmişi**

| Versiyon | Tarih | Değişiklik | Yazan |
|----------|-------|------------|-------|
| 1.0.0 | 29.08.2025 | İlk versiyon | AI Assistant |

---

## 📞 **12. İletişim**

- **Project Manager**: TBD
- **Technical Lead**: AI Assistant
- **Product Owner**: Senol
- **Development Team**: TBD
- **Design Team**: TBD
