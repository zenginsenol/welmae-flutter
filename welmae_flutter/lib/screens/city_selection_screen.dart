import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CitySelectionScreen extends StatefulWidget {
  final String? selectedCountry;
  
  const CitySelectionScreen({super.key, this.selectedCountry});

  @override
  State<CitySelectionScreen> createState() => _CitySelectionScreenState();
}

class _CitySelectionScreenState extends State<CitySelectionScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String? selectedCity;
  
  // Velmae Brand Colors
  static const Color velmaeTeal = Color(0xFF03A6A6);
  static const Color velmaeLightTeal = Color(0xFFEBFEFE);
  static const Color velmaeDarkTeal = Color(0xFF013C3C);
  static const Color velmaeMint = Color(0xFFB8E6E6);

  // Ülkeye göre şehir listesi
  Map<String, List<String>> cityMap = {
    'Türkiye': ['İstanbul', 'Ankara', 'İzmir', 'Bursa', 'Antalya', 'Adana', 'Konya', 'Gaziantep', 'Mersin', 'Kayseri'],
    'Almanya': ['Berlin', 'Hamburg', 'Münih', 'Köln', 'Frankfurt', 'Stuttgart', 'Düsseldorf', 'Dortmund', 'Essen', 'Leipzig'],
    'Fransa': ['Paris', 'Marsilya', 'Lyon', 'Toulouse', 'Nice', 'Nantes', 'Strasbourg', 'Montpellier', 'Bordeaux', 'Lille'],
    'İtalya': ['Roma', 'Milano', 'Napoli', 'Torino', 'Palermo', 'Cenova', 'Bologna', 'Floransa', 'Bari', 'Catania'],
    'İspanya': ['Madrid', 'Barcelona', 'Valencia', 'Sevilla', 'Zaragoza', 'Málaga', 'Murcia', 'Palma', 'Las Palmas', 'Bilbao'],
  };

  List<String> get cities {
    return cityMap[widget.selectedCountry] ?? [];
  }

  List<String> get filteredCities {
    if (_searchQuery.isEmpty) {
      return cities;
    }
    return cities.where((city) {
      return city.toLowerCase().contains(_searchQuery.toLowerCase());
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
            
            // Progress Indicator
            _buildProgressIndicator(),
            
            // City Icon
            _buildCityIcon(),
            
            // Title
            _buildTitle(),
            
            // City List
            Expanded(
              child: _buildCityList(),
            ),
            
            // Continue Button
            _buildContinueButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
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
          
          // Logo
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: velmaeDarkTeal,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: Text(
                'V',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
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
          hintText: 'Şehir arama',
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

  Widget _buildProgressIndicator() {
    return Container(
      margin: const EdgeInsets.all(20),
      height: 2,
      child: LinearProgressIndicator(
        value: 0.4, // %40 tamamlandı
        backgroundColor: velmaeMint,
        valueColor: AlwaysStoppedAnimation<Color>(velmaeTeal),
      ),
    );
  }

  Widget _buildCityIcon() {
    return Container(
      margin: const EdgeInsets.all(20),
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: velmaeMint,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Icon(
        Icons.location_city,
        size: 50,
        color: velmaeDarkTeal,
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Text(
            'Yaşadığınız şehir',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            widget.selectedCountry ?? 'Ülke',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCityList() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        itemCount: filteredCities.length,
        itemBuilder: (context, index) {
          final city = filteredCities[index];
          return _buildCityCard(city);
        },
      ),
    );
  }

  Widget _buildCityCard(String city) {
    final isSelected = selectedCity == city;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isSelected ? velmaeMint : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? velmaeTeal : Colors.grey.withValues(alpha: 0.2),
          width: isSelected ? 2 : 1,
        ),
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
            color: isSelected ? velmaeTeal : velmaeMint,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            Icons.location_on,
            color: isSelected ? Colors.white : velmaeDarkTeal,
            size: 20,
          ),
        ),
        title: Text(
          city,
          style: TextStyle(
            color: isSelected ? velmaeDarkTeal : Colors.black,
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
        trailing: isSelected 
          ? Icon(
              Icons.check_circle,
              color: velmaeTeal,
              size: 24,
            )
          : Icon(
              Icons.circle_outlined,
              color: Colors.grey[400],
              size: 24,
            ),
        onTap: () => _onCitySelected(city),
      ),
    );
  }

  Widget _buildContinueButton() {
    return Container(
      margin: const EdgeInsets.all(20),
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: selectedCity != null ? _handleContinue : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: selectedCity != null ? velmaeMint : Colors.grey[300],
          foregroundColor: selectedCity != null ? Colors.white : Colors.grey[500],
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        child: const Text(
          'Devam Et',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  void _onCitySelected(String city) {
    HapticFeedback.mediumImpact();
    setState(() {
      selectedCity = city;
    });
  }

  void _handleContinue() {
    HapticFeedback.mediumImpact();
    
    if (selectedCity != null) {
      // Şehir bilgisini kaydet ve bir sonraki ekrana geç
      Navigator.pushNamed(
        context,
        '/name-input',
        arguments: {
          'country': widget.selectedCountry,
          'city': selectedCity,
        },
      );
    }
  }
}
