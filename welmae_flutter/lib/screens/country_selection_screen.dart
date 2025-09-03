import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CountrySelectionScreen extends StatefulWidget {
  const CountrySelectionScreen({super.key});

  @override
  State<CountrySelectionScreen> createState() => _CountrySelectionScreenState();
}

class _CountrySelectionScreenState extends State<CountrySelectionScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  
  // Velmae Brand Colors
  static const Color velmaeTeal = Color(0xFF03A6A6);
  static const Color velmaeLightTeal = Color(0xFFEBFEFE);
  static const Color velmaeDarkTeal = Color(0xFF013C3C);
  static const Color velmaeMint = Color(0xFFB8E6E6);

  // Ülke listesi
  final List<Map<String, String>> countries = [
    {'name': 'Türkiye', 'flag': '🇹🇷', 'code': 'TR'},
    {'name': 'Amerika Birleşik Devletleri', 'flag': '🇺🇸', 'code': 'US'},
    {'name': 'Almanya', 'flag': '🇩🇪', 'code': 'DE'},
    {'name': 'Fransa', 'flag': '🇫🇷', 'code': 'FR'},
    {'name': 'İtalya', 'flag': '🇮🇹', 'code': 'IT'},
    {'name': 'İspanya', 'flag': '🇪🇸', 'code': 'ES'},
    {'name': 'Yunanistan', 'flag': '🇬🇷', 'code': 'GR'},
    {'name': 'Hollanda', 'flag': '🇳🇱', 'code': 'NL'},
    {'name': 'Belçika', 'flag': '🇧🇪', 'code': 'BE'},
    {'name': 'Avusturya', 'flag': '🇦🇹', 'code': 'AT'},
    {'name': 'İsviçre', 'flag': '🇨🇭', 'code': 'CH'},
    {'name': 'Polonya', 'flag': '🇵🇱', 'code': 'PL'},
    {'name': 'Çek Cumhuriyeti', 'flag': '🇨🇿', 'code': 'CZ'},
    {'name': 'Macaristan', 'flag': '🇭🇺', 'code': 'HU'},
    {'name': 'Romanya', 'flag': '🇷🇴', 'code': 'RO'},
    {'name': 'Bulgaristan', 'flag': '🇧🇬', 'code': 'BG'},
    {'name': 'Hırvatistan', 'flag': '🇭🇷', 'code': 'HR'},
    {'name': 'Slovenya', 'flag': '🇸🇮', 'code': 'SI'},
    {'name': 'Slovakya', 'flag': '🇸🇰', 'code': 'SK'},
    {'name': 'Litvanya', 'flag': '🇱🇹', 'code': 'LT'},
    {'name': 'Letonya', 'flag': '🇱🇻', 'code': 'LV'},
    {'name': 'Estonya', 'flag': '🇪🇪', 'code': 'EE'},
    {'name': 'Finlandiya', 'flag': '🇫🇮', 'code': 'FI'},
    {'name': 'İsveç', 'flag': '🇸🇪', 'code': 'SE'},
    {'name': 'Norveç', 'flag': '🇳🇴', 'code': 'NO'},
    {'name': 'Danimarka', 'flag': '🇩🇰', 'code': 'DK'},
    {'name': 'İrlanda', 'flag': '🇮🇪', 'code': 'IE'},
    {'name': 'Portekiz', 'flag': '🇵🇹', 'code': 'PT'},
    {'name': 'Birleşik Krallık', 'flag': '🇬🇧', 'code': 'GB'},
    {'name': 'Kanada', 'flag': '🇨🇦', 'code': 'CA'},
    {'name': 'Avustralya', 'flag': '🇦🇺', 'code': 'AU'},
    {'name': 'Yeni Zelanda', 'flag': '🇳🇿', 'code': 'NZ'},
    {'name': 'Japonya', 'flag': '🇯🇵', 'code': 'JP'},
    {'name': 'Güney Kore', 'flag': '🇰🇷', 'code': 'KR'},
    {'name': 'Çin', 'flag': '🇨🇳', 'code': 'CN'},
    {'name': 'Hindistan', 'flag': '🇮🇳', 'code': 'IN'},
    {'name': 'Brezilya', 'flag': '🇧🇷', 'code': 'BR'},
    {'name': 'Arjantin', 'flag': '🇦🇷', 'code': 'AR'},
    {'name': 'Meksika', 'flag': '🇲🇽', 'code': 'MX'},
    {'name': 'Şili', 'flag': '🇨🇱', 'code': 'CL'},
    {'name': 'Kolombiya', 'flag': '🇨🇴', 'code': 'CO'},
    {'name': 'Peru', 'flag': '🇵🇪', 'code': 'PE'},
    {'name': 'Venezuela', 'flag': '🇻🇪', 'code': 'VE'},
    {'name': 'Uruguay', 'flag': '🇺🇾', 'code': 'UY'},
    {'name': 'Paraguay', 'flag': '🇵🇾', 'code': 'PY'},
    {'name': 'Bolivya', 'flag': '🇧🇴', 'code': 'BO'},
    {'name': 'Ekvador', 'flag': '🇪🇨', 'code': 'EC'},
    {'name': 'Güney Afrika', 'flag': '🇿🇦', 'code': 'ZA'},
    {'name': 'Mısır', 'flag': '🇪🇬', 'code': 'EG'},
    {'name': 'Fas', 'flag': '🇲🇦', 'code': 'MA'},
    {'name': 'Tunus', 'flag': '🇹🇳', 'code': 'TN'},
    {'name': 'Cezayir', 'flag': '🇩🇿', 'code': 'DZ'},
    {'name': 'Libya', 'flag': '🇱🇾', 'code': 'LY'},
    {'name': 'Sudan', 'flag': '🇸🇩', 'code': 'SD'},
    {'name': 'Etiyopya', 'flag': '🇪🇹', 'code': 'ET'},
    {'name': 'Kenya', 'flag': '🇰🇪', 'code': 'KE'},
    {'name': 'Uganda', 'flag': '🇺🇬', 'code': 'UG'},
    {'name': 'Tanzanya', 'flag': '🇹🇿', 'code': 'TZ'},
    {'name': 'Nijerya', 'flag': '🇳🇬', 'code': 'NG'},
    {'name': 'Gana', 'flag': '🇬🇭', 'code': 'GH'},
    {'name': 'Senegal', 'flag': '🇸🇳', 'code': 'SN'},
    {'name': 'Mali', 'flag': '🇲🇱', 'code': 'ML'},
    {'name': 'Burkina Faso', 'flag': '🇧🇫', 'code': 'BF'},
    {'name': 'Nijer', 'flag': '🇳🇪', 'code': 'NE'},
    {'name': 'Çad', 'flag': '🇹🇩', 'code': 'TD'},
    {'name': 'Kamerun', 'flag': '🇨🇲', 'code': 'CM'},
    {'name': 'Gabon', 'flag': '🇬🇦', 'code': 'GA'},
    {'name': 'Kongo', 'flag': '🇨🇬', 'code': 'CG'},
    {'name': 'Demokratik Kongo Cumhuriyeti', 'flag': '🇨🇩', 'code': 'CD'},
    {'name': 'Angola', 'flag': '🇦🇴', 'code': 'AO'},
    {'name': 'Zambiya', 'flag': '🇿🇲', 'code': 'ZM'},
    {'name': 'Zimbabve', 'flag': '🇿🇼', 'code': 'ZW'},
    {'name': 'Botsvana', 'flag': '🇧🇼', 'code': 'BW'},
    {'name': 'Namibya', 'flag': '🇳🇦', 'code': 'NA'},
    {'name': 'Lesotho', 'flag': '🇱🇸', 'code': 'LS'},
    {'name': 'Esvatini', 'flag': '🇸🇿', 'code': 'SZ'},
    {'name': 'Madagaskar', 'flag': '🇲🇬', 'code': 'MG'},
    {'name': 'Mauritius', 'flag': '🇲🇺', 'code': 'MU'},
    {'name': 'Seyşeller', 'flag': '🇸🇨', 'code': 'SC'},
    {'name': 'Komorlar', 'flag': '🇰🇲', 'code': 'KM'},
    {'name': 'Cibuti', 'flag': '🇩🇯', 'code': 'DJ'},
    {'name': 'Somali', 'flag': '🇸🇴', 'code': 'SO'},
    {'name': 'Eritre', 'flag': '🇪🇷', 'code': 'ER'},
    {'name': 'Cibuti', 'flag': '🇩🇯', 'code': 'DJ'},
    {'name': 'Somali', 'flag': '🇸🇴', 'code': 'SO'},
    {'name': 'Eritre', 'flag': '🇪🇷', 'code': 'ER'},
  ];

  List<Map<String, String>> get filteredCountries {
    if (_searchQuery.isEmpty) {
      return countries;
    }
    return countries.where((country) {
      return country['name']!.toLowerCase().contains(_searchQuery.toLowerCase());
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
            
            // Country List
            Expanded(
              child: _buildCountryList(),
            ),
            
            // Map View Button
            _buildMapViewButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
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
      margin: const EdgeInsets.all(20),
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

  Widget _buildCountryList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: filteredCountries.length,
      itemBuilder: (context, index) {
        final country = filteredCountries[index];
        return _buildCountryCard(country);
      },
    );
  }

  Widget _buildCountryCard(Map<String, String> country) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: velmaeMint,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              country['flag']!,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
        title: Text(
          country['name']!,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.black,
          size: 16,
        ),
        onTap: () => _onCountrySelected(country),
      ),
    );
  }

  Widget _buildMapViewButton() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: FloatingActionButton.extended(
        onPressed: _onMapViewPressed,
        backgroundColor: velmaeTeal,
        elevation: 4,
        label: const Text(
          'Harita Görünümü',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        icon: const Icon(
          Icons.map,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  void _onCountrySelected(Map<String, String> country) {
    HapticFeedback.mediumImpact();
    
    // Seçilen ülkeyi geri gönder
    Navigator.pop(context, country);
  }

  void _onMapViewPressed() async {
    HapticFeedback.mediumImpact();
    
    final result = await Navigator.pushNamed(context, '/country-map');
    if (result != null) {
      final country = result as Map<String, String>;
      Navigator.pop(context, country);
    }
  }
}
