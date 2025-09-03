import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CountryMapScreen extends StatefulWidget {
  const CountryMapScreen({super.key});

  @override
  State<CountryMapScreen> createState() => _CountryMapScreenState();
}

class _CountryMapScreenState extends State<CountryMapScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  
  // Velmae Brand Colors
  static const Color velmaeTeal = Color(0xFF03A6A6);
  static const Color velmaeLightTeal = Color(0xFFEBFEFE);
  static const Color velmaeDarkTeal = Color(0xFF013C3C);
  static const Color velmaeMint = Color(0xFFB8E6E6);

  // Ülke koordinatları (örnek veriler)
  final List<Map<String, dynamic>> countryPins = [
    {'name': 'Türkiye', 'flag': '🇹🇷', 'x': 0.6, 'y': 0.45},
    {'name': 'Almanya', 'flag': '🇩🇪', 'x': 0.52, 'y': 0.35},
    {'name': 'Fransa', 'flag': '🇫🇷', 'x': 0.48, 'y': 0.38},
    {'name': 'İtalya', 'flag': '🇮🇹', 'x': 0.54, 'y': 0.42},
    {'name': 'İspanya', 'flag': '🇪🇸', 'x': 0.44, 'y': 0.42},
    {'name': 'Yunanistan', 'flag': '🇬🇷', 'x': 0.58, 'y': 0.44},
    {'name': 'Hollanda', 'flag': '🇳🇱', 'x': 0.5, 'y': 0.32},
    {'name': 'Belçika', 'flag': '🇧🇪', 'x': 0.49, 'y': 0.34},
    {'name': 'Avusturya', 'flag': '🇦🇹', 'x': 0.55, 'y': 0.37},
    {'name': 'İsviçre', 'flag': '🇨🇭', 'x': 0.51, 'y': 0.38},
    {'name': 'Polonya', 'flag': '🇵🇱', 'x': 0.58, 'y': 0.33},
    {'name': 'Çek Cumhuriyeti', 'flag': '🇨🇿', 'x': 0.56, 'y': 0.35},
    {'name': 'Macaristan', 'flag': '🇭🇺', 'x': 0.58, 'y': 0.37},
    {'name': 'Romanya', 'flag': '🇷🇴', 'x': 0.62, 'y': 0.38},
    {'name': 'Bulgaristan', 'flag': '🇧🇬', 'x': 0.6, 'y': 0.4},
    {'name': 'Hırvatistan', 'flag': '🇭🇷', 'x': 0.56, 'y': 0.4},
    {'name': 'Slovenya', 'flag': '🇸🇮', 'x': 0.54, 'y': 0.39},
    {'name': 'Slovakya', 'flag': '🇸🇰', 'x': 0.57, 'y': 0.36},
    {'name': 'Litvanya', 'flag': '🇱🇹', 'x': 0.58, 'y': 0.28},
    {'name': 'Letonya', 'flag': '🇱🇻', 'x': 0.59, 'y': 0.27},
    {'name': 'Estonya', 'flag': '🇪🇪', 'x': 0.6, 'y': 0.25},
    {'name': 'Finlandiya', 'flag': '🇫🇮', 'x': 0.58, 'y': 0.2},
    {'name': 'İsveç', 'flag': '🇸🇪', 'x': 0.54, 'y': 0.22},
    {'name': 'Norveç', 'flag': '🇳🇴', 'x': 0.52, 'y': 0.18},
    {'name': 'Danimarka', 'flag': '🇩🇰', 'x': 0.52, 'y': 0.3},
    {'name': 'İrlanda', 'flag': '🇮🇪', 'x': 0.42, 'y': 0.32},
    {'name': 'Portekiz', 'flag': '🇵🇹', 'x': 0.42, 'y': 0.44},
    {'name': 'Birleşik Krallık', 'flag': '🇬🇧', 'x': 0.45, 'y': 0.32},
    {'name': 'Kanada', 'flag': '🇨🇦', 'x': 0.25, 'y': 0.3},
    {'name': 'Amerika Birleşik Devletleri', 'flag': '🇺🇸', 'x': 0.22, 'y': 0.4},
    {'name': 'Meksika', 'flag': '🇲🇽', 'x': 0.18, 'y': 0.48},
    {'name': 'Brezilya', 'flag': '🇧🇷', 'x': 0.35, 'y': 0.65},
    {'name': 'Arjantin', 'flag': '🇦🇷', 'x': 0.32, 'y': 0.75},
    {'name': 'Şili', 'flag': '🇨🇱', 'x': 0.28, 'y': 0.75},
    {'name': 'Kolombiya', 'flag': '🇨🇴', 'x': 0.28, 'y': 0.58},
    {'name': 'Peru', 'flag': '🇵🇪', 'x': 0.25, 'y': 0.65},
    {'name': 'Venezuela', 'flag': '🇻🇪', 'x': 0.3, 'y': 0.58},
    {'name': 'Uruguay', 'flag': '🇺🇾', 'x': 0.35, 'y': 0.72},
    {'name': 'Paraguay', 'flag': '🇵🇾', 'x': 0.32, 'y': 0.68},
    {'name': 'Bolivya', 'flag': '🇧🇴', 'x': 0.28, 'y': 0.68},
    {'name': 'Ekvador', 'flag': '🇪🇨', 'x': 0.25, 'y': 0.62},
    {'name': 'Avustralya', 'flag': '🇦🇺', 'x': 0.85, 'y': 0.7},
    {'name': 'Yeni Zelanda', 'flag': '🇳🇿', 'x': 0.9, 'y': 0.75},
    {'name': 'Japonya', 'flag': '🇯🇵', 'x': 0.9, 'y': 0.4},
    {'name': 'Güney Kore', 'flag': '🇰🇷', 'x': 0.88, 'y': 0.42},
    {'name': 'Çin', 'flag': '🇨🇳', 'x': 0.8, 'y': 0.45},
    {'name': 'Hindistan', 'flag': '🇮🇳', 'x': 0.75, 'y': 0.52},
    {'name': 'Güney Afrika', 'flag': '🇿🇦', 'x': 0.55, 'y': 0.75},
    {'name': 'Mısır', 'flag': '🇪🇬', 'x': 0.62, 'y': 0.5},
    {'name': 'Fas', 'flag': '🇲🇦', 'x': 0.45, 'y': 0.5},
    {'name': 'Tunus', 'flag': '🇹🇳', 'x': 0.52, 'y': 0.52},
    {'name': 'Cezayir', 'flag': '🇩🇿', 'x': 0.5, 'y': 0.52},
    {'name': 'Libya', 'flag': '🇱🇾', 'x': 0.58, 'y': 0.54},
    {'name': 'Sudan', 'flag': '🇸🇩', 'x': 0.65, 'y': 0.58},
    {'name': 'Etiyopya', 'flag': '🇪🇹', 'x': 0.68, 'y': 0.62},
    {'name': 'Kenya', 'flag': '🇰🇪', 'x': 0.68, 'y': 0.65},
    {'name': 'Uganda', 'flag': '🇺🇬', 'x': 0.67, 'y': 0.63},
    {'name': 'Tanzanya', 'flag': '🇹🇿', 'x': 0.68, 'y': 0.68},
    {'name': 'Nijerya', 'flag': '🇳🇬', 'x': 0.55, 'y': 0.62},
    {'name': 'Gana', 'flag': '🇬🇭', 'x': 0.52, 'y': 0.62},
    {'name': 'Senegal', 'flag': '🇸🇳', 'x': 0.48, 'y': 0.58},
    {'name': 'Mali', 'flag': '🇲🇱', 'x': 0.52, 'y': 0.58},
    {'name': 'Burkina Faso', 'flag': '🇧🇫', 'x': 0.54, 'y': 0.6},
    {'name': 'Nijer', 'flag': '🇳🇪', 'x': 0.56, 'y': 0.58},
    {'name': 'Çad', 'flag': '🇹🇩', 'x': 0.62, 'y': 0.58},
    {'name': 'Kamerun', 'flag': '🇨🇲', 'x': 0.58, 'y': 0.62},
    {'name': 'Gabon', 'flag': '🇬🇦', 'x': 0.58, 'y': 0.65},
    {'name': 'Kongo', 'flag': '🇨🇬', 'x': 0.6, 'y': 0.65},
    {'name': 'Demokratik Kongo Cumhuriyeti', 'flag': '🇨🇩', 'x': 0.62, 'y': 0.65},
    {'name': 'Angola', 'flag': '🇦🇴', 'x': 0.58, 'y': 0.72},
    {'name': 'Zambiya', 'flag': '🇿🇲', 'x': 0.65, 'y': 0.7},
    {'name': 'Zimbabve', 'flag': '🇿🇼', 'x': 0.65, 'y': 0.72},
    {'name': 'Botsvana', 'flag': '🇧🇼', 'x': 0.62, 'y': 0.75},
    {'name': 'Namibya', 'flag': '🇳🇦', 'x': 0.58, 'y': 0.75},
    {'name': 'Lesotho', 'flag': '🇱🇸', 'x': 0.62, 'y': 0.78},
    {'name': 'Esvatini', 'flag': '🇸🇿', 'x': 0.65, 'y': 0.75},
    {'name': 'Madagaskar', 'flag': '🇲🇬', 'x': 0.72, 'y': 0.72},
    {'name': 'Mauritius', 'flag': '🇲🇺', 'x': 0.75, 'y': 0.68},
    {'name': 'Seyşeller', 'flag': '🇸🇨', 'x': 0.75, 'y': 0.65},
    {'name': 'Komorlar', 'flag': '🇰🇲', 'x': 0.72, 'y': 0.68},
    {'name': 'Cibuti', 'flag': '🇩🇯', 'x': 0.72, 'y': 0.62},
    {'name': 'Somali', 'flag': '🇸🇴', 'x': 0.75, 'y': 0.62},
    {'name': 'Eritre', 'flag': '🇪🇷', 'x': 0.72, 'y': 0.58},
  ];

  List<Map<String, dynamic>> get filteredPins {
    if (_searchQuery.isEmpty) {
      return countryPins;
    }
    return countryPins.where((pin) {
      return pin['name']!.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: velmaeLightTeal,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(),
            
            // Search Bar
            _buildSearchBar(),
            
            // Map Content
            Expanded(
              child: _buildMapContent(),
            ),
            
            // List View Button
            _buildListViewButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: velmaeLightTeal,
      child: Row(
        children: [
          // Back Button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 24,
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Title
          const Expanded(
            child: Text(
              'Ülke seçimi',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          
          const SizedBox(width: 40), // Balance the back button
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: velmaeTeal,
          width: 1,
        ),
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Ülke arama',
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontSize: 16,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: velmaeTeal,
            size: 20,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildMapContent() {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Background Map
            _buildMapBackground(),
            
            // Country Pins
            ...filteredPins.map((pin) => _buildCountryPin(pin)),
          ],
        ),
      ),
    );
  }

  Widget _buildMapBackground() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            velmaeMint.withValues(alpha: 0.3),
            velmaeLightTeal,
            velmaeMint.withValues(alpha: 0.2),
          ],
        ),
      ),
      child: CustomPaint(
        painter: MapPainter(),
      ),
    );
  }

  Widget _buildCountryPin(Map<String, dynamic> pin) {
    return Positioned(
      left: MediaQuery.of(context).size.width * pin['x'] * 0.6,
      top: MediaQuery.of(context).size.height * pin['y'] * 0.4,
      child: GestureDetector(
        onTap: () => _onCountrySelected(pin),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: velmaeTeal,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              pin['flag']!,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListViewButton() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: FloatingActionButton.extended(
        onPressed: _onListViewPressed,
        backgroundColor: velmaeTeal,
        elevation: 4,
        label: const Text(
          'Liste Görünümü',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        icon: const Icon(
          Icons.list,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  void _onCountrySelected(Map<String, dynamic> country) {
    HapticFeedback.mediumImpact();
    
    // Seçilen ülkeyi geri gönder
    Navigator.pop(context, {
      'name': country['name'],
      'flag': country['flag'],
      'code': country['code'] ?? '',
    });
  }

  void _onListViewPressed() {
    HapticFeedback.mediumImpact();
    
    // Liste görünümüne geri dön
    Navigator.pop(context);
  }
}

// Basit harita çizimi için CustomPainter
class MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFB8E6E6)
      ..style = PaintingStyle.fill;

    // Basit kıta şekilleri çizimi
    _drawContinent(canvas, size, 0.5, 0.4, 0.3, 0.2); // Avrupa
    _drawContinent(canvas, size, 0.2, 0.4, 0.2, 0.3); // Kuzey Amerika
    _drawContinent(canvas, size, 0.3, 0.7, 0.2, 0.2); // Güney Amerika
    _drawContinent(canvas, size, 0.8, 0.5, 0.15, 0.25); // Asya
    _drawContinent(canvas, size, 0.5, 0.7, 0.2, 0.15); // Afrika
    _drawContinent(canvas, size, 0.85, 0.7, 0.1, 0.15); // Avustralya
  }

  void _drawContinent(Canvas canvas, Size size, double x, double y, double width, double height) {
    final rect = Rect.fromCenter(
      center: Offset(size.width * x, size.height * y),
      width: size.width * width,
      height: size.height * height,
    );
    
    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(rect, const Radius.circular(8)));
    
    canvas.drawPath(path, Paint()
      ..color = const Color(0xFFB8E6E6)
      ..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
