# Welmae - Technical Architecture Document

## 📋 **Doküman Bilgileri**

- **Versiyon**: 1.0.0
- **Oluşturulma Tarihi**: 29 Ağustos 2025
- **Son Güncelleme**: 29 Ağustos 2025
- **Hazırlayan**: AI Assistant
- **Onaylayan**: TBD
- **Durum**: Draft - Geliştirme Aşamasında

---

## 🏗️ **1. Sistem Genel Bakış**

### **1.1 Mimari Prensipler**
- **Microservices**: Modüler ve ölçeklenebilir servis yapısı
- **Event-Driven**: Asenkron veri işleme ve iletişim
- **API-First**: Tüm özellikler API üzerinden erişilebilir
- **Cloud-Native**: Bulut tabanlı dağıtım ve ölçeklendirme
- **Security by Design**: Güvenlik her katmanda entegre

### **1.2 Teknoloji Stack'i**
- **Frontend**: Flutter 3.35.2+ (iOS, Android, Web)
- **Backend**: Node.js + Express.js / Python + FastAPI
- **Database**: PostgreSQL (ana veritabanı) + Redis (cache)
- **Search Engine**: Elasticsearch
- **Message Queue**: Apache Kafka / RabbitMQ
- **File Storage**: AWS S3 / Google Cloud Storage
- **CDN**: CloudFront / Cloud CDN
- **Monitoring**: Prometheus + Grafana
- **Logging**: ELK Stack (Elasticsearch, Logstash, Kibana)

---

## 🏛️ **2. Sistem Mimarisi**

### **2.1 Katmanlı Mimari**

```
┌─────────────────────────────────────────────────────────────┐
│                    Presentation Layer                       │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        │
│  │   Flutter   │  │   Flutter   │  │   Flutter   │        │
│  │    iOS      │  │   Android   │  │     Web     │        │
│  └─────────────┘  └─────────────┘  └─────────────┘        │
└─────────────────────────────────────────────────────────────┘
                                │
┌─────────────────────────────────────────────────────────────┐
│                     API Gateway Layer                       │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        │
│  │   Auth      │  │   Rate      │  │   Load      │        │
│  │  Service    │  │  Limiting   │  │  Balancing  │        │
│  └─────────────┘  └─────────────┘  └─────────────┘        │
└─────────────────────────────────────────────────────────────┘
                                │
┌─────────────────────────────────────────────────────────────┐
│                   Business Logic Layer                      │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        │
│  │   User      │  │   Travel    │  │   Social    │        │
│  │  Service    │  │  Service    │  │  Service    │        │
│  └─────────────┘  └─────────────┘  └─────────────┘        │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        │
│  │   Content   │  │   Search    │  │   Payment   │        │
│  │  Service    │  │  Service    │  │  Service    │        │
│  └─────────────┘  └─────────────┘  └─────────────┘        │
└─────────────────────────────────────────────────────────────┘
                                │
┌─────────────────────────────────────────────────────────────┐
│                    Data Access Layer                        │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        │
│  │ PostgreSQL  │  │    Redis    │  │Elasticsearch│        │
│  │  Database   │  │    Cache    │  │   Search    │        │
│  └─────────────┘  └─────────────┘  └─────────────┘        │
└─────────────────────────────────────────────────────────────┘
```

### **2.2 Microservices Mimarisi**

```
┌─────────────────────────────────────────────────────────────┐
│                    API Gateway                             │
│                    (Kong/Nginx)                            │
└─────────────────────┬───────────────────────────────────────┘
                      │
        ┌─────────────┼─────────────┐
        │             │             │
┌───────▼──────┐ ┌────▼────┐ ┌─────▼─────┐
│   Auth       │ │  User   │ │  Travel   │
│  Service     │ │ Service │ │ Service   │
│  (Port:3001) │ │(Port:3002)│ │(Port:3003)│
└──────────────┘ └─────────┘ └───────────┘
        │             │             │
        └─────────────┼─────────────┘
                      │
        ┌─────────────┼─────────────┐
        │             │             │
┌───────▼──────┐ ┌────▼────┐ ┌─────▼─────┐
│   Content    │ │  Social │ │  Search   │
│  Service     │ │ Service │ │ Service   │
│  (Port:3004) │ │(Port:3005)│ │(Port:3006)│
└──────────────┘ └─────────┘ └───────────┘
```

---

## 🔐 **3. Güvenlik Mimarisi**

### **3.1 Kimlik Doğrulama ve Yetkilendirme**

```
┌─────────────────────────────────────────────────────────────┐
│                    Client App                              │
│                    (Flutter)                               │
└─────────────────────┬───────────────────────────────────────┘
                      │
                      │ JWT Token
                      ▼
┌─────────────────────────────────────────────────────────────┐
│                    API Gateway                             │
│                    (Auth Middleware)                       │
└─────────────────────┬───────────────────────────────────────┘
                      │
                      │ Validated Token
                      ▼
┌─────────────────────────────────────────────────────────────┐
│                    Auth Service                            │
│                    (JWT Validation)                        │
└─────────────────────┬───────────────────────────────────────┘
                      │
                      │ User Permissions
                      ▼
┌─────────────────────────────────────────────────────────────┐
│                    Business Service                        │
│                    (Role-Based Access)                     │
└─────────────────────────────────────────────────────────────┘
```

### **3.2 Güvenlik Katmanları**
- **Transport Layer Security (TLS 1.3)**: Tüm API iletişimi
- **API Key Management**: Rate limiting ve erişim kontrolü
- **Input Validation**: SQL injection, XSS koruması
- **Data Encryption**: AES-256 at rest, TLS in transit
- **Audit Logging**: Tüm işlemlerin kayıt altına alınması

---

## 📊 **4. Veri Mimarisi**

### **4.1 Veritabanı Şeması**

```
┌─────────────────────────────────────────────────────────────┐
│                    PostgreSQL Database                      │
│                                                            │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        │
│  │    Users    │  │   Travels   │  │   Posts     │        │
│  │             │  │             │  │             │        │
│  │ • id        │  │ • id        │  │ • id        │        │
│  │ • email     │  │ • user_id   │  │ • travel_id │        │
│  │ • password  │  │ • title     │  │ • content   │        │
│  │ • name      │  │ • start_date│  │ • media_urls│        │
│  │ • bio       │  │ • end_date  │  │ • created_at│        │
│  │ • avatar    │  │ • budget    │  │ • updated_at│        │
│  │ • created_at│  │ • status    │  │             │        │
│  │ • updated_at│  │ • created_at│  │             │        │
│  └─────────────┘  │ • updated_at│  │             │        │
│                   └─────────────┘  └─────────────┘        │
│                                                            │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        │
│  │  Follows    │  │   Likes     │  │  Comments   │        │
│  │             │  │             │  │             │        │
│  │ • id        │  │ • id        │  │ • id        │        │
│  │ • follower_id│ │ • user_id   │  │ • post_id   │        │
│  │ • following_id││ • post_id   │  │ • user_id   │        │
│  │ • created_at│ │ • created_at│  │ • content   │        │
│  └─────────────┘ └─────────────┘  │ • created_at│        │
│                                   └─────────────┘        │
└─────────────────────────────────────────────────────────────┘
```

### **4.2 Veri Akışı**

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   Client    │───▶│   API      │───▶│  Database   │
│  Request    │    │  Gateway   │    │             │
└─────────────┘    └─────────────┘    └─────────────┘
       │                   │                   │
       │                   ▼                   │
       │            ┌─────────────┐            │
       │            │  Business   │            │
       │            │   Logic     │            │
       │            └─────────────┘            │
       │                   │                   │
       │                   ▼                   │
       │            ┌─────────────┐            │
       │            │   Cache     │            │
       │            │   (Redis)   │            │
       │            └─────────────┘            │
       │                   │                   │
       │                   ▼                   │
       │            ┌─────────────┐            │
       │            │  Search     │            │
       │            │(Elasticsearch)           │
       │            └─────────────┘            │
       │                   │                   │
       ▼                   ▼                   ▼
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   Client    │    │   Logs      │    │  Analytics  │
│  Response   │    │  (ELK)      │    │  (Metrics)  │
└─────────────┘    └─────────────┘    └─────────────┘
```

---

## 🔄 **5. State Management Mimarisi**

### **5.1 Flutter State Management**

```
┌─────────────────────────────────────────────────────────────┐
│                    Flutter App                             │
│                                                            │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        │
│  │   UI        │  │   Business  │  │   Data      │        │
│  │  Layer      │  │   Logic     │  │   Layer     │        │
│  │             │  │   Layer     │  │             │        │
│  │ • Widgets   │  │ • Providers │  │ • Repositories│      │
│  │ • Screens   │  │ • Blocs     │  │ • Services  │        │
│  │ • Components│  │ • State     │  │ • Models    │        │
│  │             │  │   Management│  │             │        │
│  └─────────────┘  └─────────────┘  └─────────────┘        │
│           │               │               │               │
│           └───────────────┼───────────────┘               │
│                           │                               │
│  ┌─────────────────────────────────────────────────────┐   │
│  │              State Management                       │   │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐ │   │
│  │  │   Local     │  │   Global    │  │   Server    │ │   │
│  │  │   State     │  │   State     │  │   State     │ │   │
│  │  │             │  │             │  │             │ │   │
│  │  │ • setState  │  │ • Provider  │  │ • API Calls│ │   │
│  │  │ • ValueNotifier│ • Riverpod  │  │ • WebSocket│ │   │
│  │  │ • InheritedWidget│ • Bloc    │  │ • Sync     │ │   │
│  │  └─────────────┘  └─────────────┘  └─────────────┘ │   │
│  └─────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
```

### **5.2 State Management Stratejisi**
- **Local State**: `setState` ve `ValueNotifier` (widget seviyesi)
- **Global State**: `Provider` ve `Riverpod` (uygulama seviyesi)
- **Complex State**: `Bloc` pattern (karmaşık iş mantığı)
- **Server State**: API calls ve real-time sync

---

## 🗺️ **6. Navigasyon ve Routing Mimarisi**

### **6.1 Flutter Navigation Structure**

```
┌─────────────────────────────────────────────────────────────┐
│                    App Entry Point                         │
│                    (main.dart)                             │
└─────────────────────┬───────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────────┐
│                    Onboarding Flow                         │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        │
│  │   Welcome   │  │   Features  │  │   Get       │        │
│  │   Screen    │  │   Screen    │  │   Started   │        │
│  └─────────────┘  └─────────────┘  └─────────────┘        │
└─────────────────────────────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────────┐
│                    Authentication Flow                      │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        │
│  │    Login    │  │   Register  │  │   Forgot    │        │
│  │   Screen    │  │   Screen    │  │   Password  │        │
│  └─────────────┘  └─────────────┘  └─────────────┘        │
└─────────────────────────────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────────┐
│                    Main App Navigation                     │
│                    (Bottom Navigation)                     │
│                                                            │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        │
│  │    Home     │  │   Explore   │  │   Trips     │        │
│  │   Tab       │  │    Tab      │  │    Tab      │        │
│  └─────────────┘  └─────────────┘  └─────────────┘        │
│                                                            │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        │
│  │   Profile   │  │   Create    │  │   Search    │        │
│  │    Tab      │  │    Post     │  │   Results   │        │
│  └─────────────┘  └─────────────┘  └─────────────┘        │
└─────────────────────────────────────────────────────────────┘
```

### **6.2 Routing Implementation**

```dart
// Route definitions
class AppRoutes {
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String main = '/main';
  static const String home = '/home';
  static const String explore = '/explore';
  static const String trips = '/trips';
  static const String profile = '/profile';
  static const String createPost = '/create-post';
  static const String travelDetail = '/travel/:id';
  static const String userProfile = '/user/:id';
  static const String search = '/search';
  static const String settings = '/settings';
}

// Route generation
MaterialPageRoute onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.travelDetail:
      final travelId = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => TravelDetailScreen(travelId: travelId),
      );
    case AppRoutes.userProfile:
      final userId = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => UserProfileScreen(userId: userId),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const NotFoundScreen(),
      );
  }
}
```

---

## 🔌 **7. API Mimarisi**

### **7.1 RESTful API Endpoints**

```
┌─────────────────────────────────────────────────────────────┐
│                    API Endpoints                           │
│                                                            │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        │
│  │   Auth      │  │    User     │  │   Travel    │        │
│  │   API       │  │    API      │  │    API      │        │
│  │             │  │             │  │             │        │
│  │ POST /auth/login    │ GET /users/:id    │ GET /travels    │        │
│  │ POST /auth/register │ PUT /users/:id    │ POST /travels   │        │
│  │ POST /auth/logout   │ DELETE /users/:id │ GET /travels/:id│        │
│  │ POST /auth/refresh  │ GET /users/:id/posts│ PUT /travels/:id│        │
│  │ POST /auth/forgot   │ GET /users/:id/followers│ DELETE /travels/:id│        │
│  └─────────────┘  └─────────────┘  └─────────────┘        │
│                                                            │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        │
│  │   Post      │  │   Social    │  │   Search    │        │
│  │    API      │  │    API      │  │    API      │        │
│  │             │  │             │  │             │        │
│  │ GET /posts      │ POST /follows    │ GET /search?q=query│        │
│  │ POST /posts     │ DELETE /follows  │ GET /search/users  │        │
│  │ GET /posts/:id  │ GET /followers   │ GET /search/travels│        │
│  │ PUT /posts/:id  │ GET /following   │ GET /search/posts  │        │
│  │ DELETE /posts/:id│ POST /likes      │ GET /search/trending│        │
│  └─────────────┘  └─────────────┘  └─────────────┘        │
└─────────────────────────────────────────────────────────────┘
```

### **7.2 API Response Format**

```json
{
  "success": true,
  "data": {
    "id": "123",
    "type": "travel",
    "attributes": {
      "title": "Paris Adventure",
      "description": "Amazing trip to Paris",
      "startDate": "2025-09-01",
      "endDate": "2025-09-07",
      "budget": 2500,
      "status": "planned"
    },
    "relationships": {
      "user": {
        "data": {
          "id": "456",
          "type": "user"
        }
      },
      "posts": {
        "data": [
          {
            "id": "789",
            "type": "post"
          }
        ]
      }
    }
  },
  "meta": {
    "timestamp": "2025-08-29T00:00:00Z",
    "version": "1.0.0"
  }
}
```

---

## 📱 **8. Flutter Uygulama Mimarisi**

### **8.1 Proje Yapısı**

```
lib/
├── main.dart                 # Uygulama giriş noktası
├── app/                      # Uygulama seviyesi
│   ├── app.dart             # Ana uygulama widget'ı
│   ├── theme/                # Tema ve stil tanımları
│   │   ├── app_theme.dart   # Ana tema
│   │   ├── colors.dart      # Renk paleti
│   │   ├── typography.dart  # Tipografi
│   │   └── dimensions.dart  # Boyut ve spacing
│   └── routes/               # Routing yapısı
│       ├── app_router.dart  # Ana router
│       └── route_names.dart # Route isimleri
├── core/                     # Temel altyapı
│   ├── constants/            # Sabitler
│   ├── utils/                # Yardımcı fonksiyonlar
│   ├── errors/               # Hata yönetimi
│   └── extensions/           # Dart extension'ları
├── data/                     # Veri katmanı
│   ├── models/               # Veri modelleri
│   ├── repositories/         # Repository pattern
│   ├── services/             # API servisleri
│   └── local/                # Yerel veri depolama
├── domain/                   # İş mantığı katmanı
│   ├── entities/             # İş varlıkları
│   ├── usecases/             # Kullanım senaryoları
│   └── repositories/         # Repository interfaces
├── presentation/             # Sunum katmanı
│   ├── screens/              # Ekranlar
│   ├── widgets/              # Yeniden kullanılabilir widget'lar
│   ├── providers/            # State management
│   └── controllers/          # Controller'lar
└── shared/                   # Paylaşılan bileşenler
    ├── components/           # Ortak bileşenler
    ├── mixins/               # Mixin'ler
    └── helpers/              # Yardımcı sınıflar
```

### **8.2 Dependency Injection**

```dart
// Service locator pattern
class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();
  factory ServiceLocator() => _instance;
  ServiceLocator._internal();

  final Map<String, dynamic> _services = {};

  void register<T extends Object>(T service) {
    _services[T.toString()] = service;
  }

  T get<T extends Object>() {
    return _services[T.toString()] as T;
  }
}

// Service registration
void setupServiceLocator() {
  final sl = ServiceLocator();
  
  // Core services
  sl.register<NetworkService>(NetworkService());
  sl.register<StorageService>(StorageService());
  
  // API services
  sl.register<AuthService>(AuthService());
  sl.register<UserService>(UserService());
  sl.register<TravelService>(TravelService());
  
  // Repositories
  sl.register<UserRepository>(UserRepositoryImpl());
  sl.register<TravelRepository>(TravelRepositoryImpl());
  
  // Use cases
  sl.register<LoginUseCase>(LoginUseCase());
  sl.register<GetUserProfileUseCase>(GetUserProfileUseCase());
}
```

---

## 🚀 **9. Performance ve Optimizasyon**

### **9.1 Flutter Performance**

- **Widget Rebuild Optimization**: `const` constructor kullanımı
- **Image Optimization**: Lazy loading, caching, compression
- **List Performance**: `ListView.builder`, `SliverList`
- **Memory Management**: Dispose pattern, weak references
- **Background Processing**: Isolate kullanımı

### **9.2 Backend Performance**

- **Database Optimization**: Indexing, query optimization
- **Caching Strategy**: Redis cache layers
- **Load Balancing**: Horizontal scaling
- **CDN Integration**: Static asset delivery
- **API Rate Limiting**: Request throttling

---

## 🔍 **10. Monitoring ve Logging**

### **10.1 Application Monitoring**

```
┌─────────────────────────────────────────────────────────────┐
│                    Monitoring Stack                         │
│                                                            │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        │
│  │   Flutter   │  │   Backend   │  │   Database  │        │
│  │   Analytics │  │   Metrics   │  │   Monitoring│        │
│  │             │  │             │  │             │        │
│  │ • Firebase  │  │ • Prometheus│  │ • pgAdmin   │        │
│  │ • Crashlytics│ │ • Grafana   │  │ • Redis     │        │
│  │ • Performance│ │ • Health    │  │   Monitor   │        │
│  │   Monitoring│ │   Checks    │  │             │        │
│  └─────────────┘  └─────────────┘  └─────────────┘        │
└─────────────────────────────────────────────────────────────┘
```

### **10.2 Logging Strategy**

- **Structured Logging**: JSON formatında loglar
- **Log Levels**: DEBUG, INFO, WARN, ERROR, FATAL
- **Centralized Logging**: ELK Stack ile merkezi log yönetimi
- **Performance Logging**: Response time, throughput metrics
- **Security Logging**: Authentication, authorization events

---

## 🔄 **11. Deployment ve DevOps**

### **11.1 CI/CD Pipeline**

```
┌─────────────────────────────────────────────────────────────┐
│                    CI/CD Pipeline                          │
│                                                            │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        │
│  │    Code     │  │    Build    │  │     Test    │        │
│  │   Commit    │  │   Process   │  │   Process   │        │
│  └─────────────┘  └─────────────┘  └─────────────┘        │
│           │               │               │               │
│           ▼               ▼               ▼               │
│  ┌─────────────────────────────────────────────────────┐   │
│  │              Quality Gates                          │   │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐ │   │
│  │  │   Code      │  │   Security  │  │   Performance│ │   │
│  │  │   Quality   │  │     Scan    │  │     Tests   │ │   │
│  │  │             │  │             │  │             │ │   │
│  │  │ • Linting   │  │ • SAST      │  │ • Load      │ │   │
│  │  │ • Coverage  │  │ • Dependency│  │   Testing   │ │   │
│  │  │ • Complexity│  │   Check     │  │ • Stress    │ │   │
│  │  └─────────────┘  └─────────────┘  └─────────────┘ │   │
│  └─────────────────────────────────────────────────────┘   │
│                           │                               │
│                           ▼                               │
│  ┌─────────────────────────────────────────────────────┐   │
│  │              Deployment                              │   │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐ │   │
│  │  │   Staging   │  │   Production│  │   Rollback  │ │   │
│  │  │ Environment │  │ Environment │  │   Process   │ │   │
│  │  └─────────────┘  └─────────────┘  └─────────────┘ │   │
│  └─────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
```

### **11.2 Environment Management**

- **Development**: Local development environment
- **Staging**: Pre-production testing environment
- **Production**: Live production environment
- **Feature Flags**: A/B testing ve gradual rollout

---

## 📋 **12. Teknik Gereksinimler**

### **12.1 Sistem Gereksinimleri**

- **CPU**: Minimum 2 vCPU, Recommended 4+ vCPU
- **RAM**: Minimum 4GB, Recommended 8GB+
- **Storage**: Minimum 100GB SSD, Recommended 500GB+
- **Network**: Minimum 100Mbps, Recommended 1Gbps+

### **12.2 Yazılım Gereksinimleri**

- **Operating System**: Ubuntu 20.04 LTS / CentOS 8
- **Runtime**: Node.js 18+ / Python 3.9+
- **Database**: PostgreSQL 14+, Redis 6+
- **Container**: Docker 20+, Kubernetes 1.24+

---

## 🔗 **13. İlgili Dokümanlar**

- [API Documentation](./api.md)
- [Database Schema](./database.md)
- [State Management](./state-management.md)
- [Navigation & Routing](./navigation.md)
- [Design System](../design/design-system.md)
- [Task Matrix](../project/task-matrix.md)

---

## 📝 **14. Değişiklik Geçmişi**

| Versiyon | Tarih | Değişiklik | Yazan |
|----------|-------|------------|-------|
| 1.0.0 | 29.08.2025 | İlk versiyon | AI Assistant |

---

## 📞 **15. İletişim**

- **Technical Lead**: AI Assistant
- **Architecture Team**: TBD
- **DevOps Team**: TBD
- **Security Team**: TBD
