import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LocationSelectionScreen extends StatefulWidget {
  const LocationSelectionScreen({super.key});

  @override
  State<LocationSelectionScreen> createState() => _LocationSelectionScreenState();
}

class _LocationSelectionScreenState extends State<LocationSelectionScreen> {
  String? selectedCountry;
  String? selectedCity;
  
  // Velmae Brand Colors
  static const Color velmaeTeal = Color(0xFF03A6A6);
  static const Color velmaeLightTeal = Color(0xFFEBFEFE);
  static const Color velmaeDarkTeal = Color(0xFF013C3C);
  static const Color velmaeMint = Color(0xFFB8E6E6);

  // Örnek ülke ve şehir listesi
  final List<String> countries = [
    'Türkiye',
    'Almanya',
    'Fransa',
    'İtalya',
    'İspanya',
    'Hollanda',
    'Belçika',
    'Avusturya',
    'İsviçre',
    'Yunanistan',
  ];

  final Map<String, List<String>> cities = {
    'Türkiye': ['İstanbul', 'Ankara', 'İzmir', 'Bursa', 'Antalya', 'Adana', 'Konya', 'Gaziantep'],
    'Almanya': ['Berlin', 'Münih', 'Hamburg', 'Köln', 'Frankfurt', 'Stuttgart', 'Düsseldorf', 'Dortmund'],
    'Fransa': ['Paris', 'Marsilya', 'Lyon', 'Toulouse', 'Nice', 'Nantes', 'Strasbourg', 'Montpellier'],
    'İtalya': ['Roma', 'Milano', 'Napoli', 'Torino', 'Palermo', 'Genova', 'Bologna', 'Firenze'],
    'İspanya': ['Madrid', 'Barselona', 'Valencia', 'Sevilla', 'Zaragoza', 'Málaga', 'Murcia', 'Bilbao'],
    'Hollanda': ['Amsterdam', 'Rotterdam', 'Lahey', 'Utrecht', 'Eindhoven', 'Groningen', 'Tilburg', 'Almere'],
    'Belçika': ['Brüksel', 'Anvers', 'Gent', 'Charleroi', 'Liège', 'Brugge', 'Namur', 'Leuven'],
    'Avusturya': ['Viyana', 'Graz', 'Linz', 'Salzburg', 'Innsbruck', 'Klagenfurt', 'Villach', 'Wels'],
    'İsviçre': ['Zürih', 'Cenevre', 'Basel', 'Bern', 'Lozan', 'Winterthur', 'St. Gallen', 'Lüksemburg'],
    'Yunanistan': ['Atina', 'Selanik', 'Patras', 'Pire', 'Larisa', 'Heraklion', 'Peristeri', 'Kallithea'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: velmaeLightTeal,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Header
              _buildHeader(),
              
              const SizedBox(height: 40),
              
              // Main Content
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Map Icon
                    _buildMapIcon(),
                    
                    const SizedBox(height: 30),
                    
                    // Title
                    _buildTitle(),
                    
                    const SizedBox(height: 40),
                    
                    // Input Fields
                    _buildInputFields(),
                    
                    const SizedBox(height: 40),
                    
                    // Continue Button
                    _buildContinueButton(),
                  ],
                ),
              ),
              
              // Bottom Text
              _buildBottomText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        // Back Button
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: velmaeTeal.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.arrow_back_ios,
              color: velmaeTeal,
              size: 20,
            ),
          ),
        ),
        
        const SizedBox(width: 16),
        
        // Logo and Line
        Expanded(
          child: Column(
            children: [
              // Logo
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: velmaeTeal,
                  borderRadius: BorderRadius.circular(8),
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
              
              const SizedBox(height: 8),
              
              // Line
              Container(
                height: 2,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [velmaeTeal, velmaeMint],
                    stops: [0.0, 1.0],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMapIcon() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: velmaeMint,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.location_on,
        color: velmaeDarkTeal,
        size: 40,
      ),
    );
  }

  Widget _buildTitle() {
    return const Text(
      'Yaşadığınız ülke ve şehir',
      style: TextStyle(
        color: velmaeDarkTeal,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildInputFields() {
    return Column(
      children: [
        // Country Selection
        _buildSelectionField(
          label: 'Ülke seçimi',
          value: selectedCountry,
          onTap: () => _showCountryPicker(),
        ),
        
        const SizedBox(height: 16),
        
        // City Selection
        _buildSelectionField(
          label: 'Şehir seçimi',
          value: selectedCity,
          onTap: selectedCountry != null ? () => _showCityPicker() : null,
          enabled: selectedCountry != null,
        ),
      ],
    );
  }

  Widget _buildSelectionField({
    required String label,
    required String? value,
    required VoidCallback? onTap,
    bool enabled = true,
  }) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: velmaeTeal,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value ?? label,
                  style: TextStyle(
                    color: value != null ? velmaeDarkTeal : Colors.grey[600],
                    fontSize: 16,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: enabled ? velmaeTeal : Colors.grey[400],
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    final isEnabled = selectedCountry != null && selectedCity != null;
    
    return GestureDetector(
      onTap: isEnabled ? _onContinue : null,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: isEnabled ? velmaeTeal : velmaeTeal.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(25),
        ),
        child: const Center(
          child: Text(
            'Devam Et',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomText() {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/phone-onboarding'),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            color: velmaeDarkTeal,
            fontSize: 16,
          ),
          children: [
            const TextSpan(text: 'Üyeliğiniz mi var? '),
            TextSpan(
              text: 'Giriş yapın',
              style: const TextStyle(
                color: velmaeTeal,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCountryPicker() async {
    final result = await Navigator.pushNamed(context, '/country-selection');
    if (result != null) {
      final country = result as Map<String, String>;
      setState(() {
        selectedCountry = country['name'];
        selectedCity = null; // Reset city when country changes
      });
    }
  }

  void _showCityPicker() {
    if (selectedCountry == null) return;
    
    final cityList = cities[selectedCountry] ?? [];
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildPickerModal(
        title: 'Şehir Seçin',
        items: cityList,
        onSelected: (city) {
          setState(() {
            selectedCity = city;
          });
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _buildPickerModal({
    required String title,
    required List<String> items,
    required Function(String) onSelected,
  }) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Title
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: velmaeDarkTeal,
              ),
            ),
          ),
          
          // Items
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  title: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 16,
                      color: velmaeDarkTeal,
                    ),
                  ),
                  onTap: () => onSelected(item),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: velmaeTeal,
                    size: 16,
                  ),
                );
              },
            ),
          ),
          
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void _onContinue() {
    if (selectedCountry != null && selectedCity != null) {
      HapticFeedback.mediumImpact();
      
      // Backend'e lokasyon bilgisini gönder
      _saveLocationData();
      
      // Sonraki sayfaya git
      Navigator.pushNamed(context, '/signup');
    }
  }

  void _saveLocationData() async {
    try {
      // TODO: Backend API çağrısı
      // await _apiService.updateLocation(
      //   country: selectedCountry!,
      //   city: selectedCity!,
      // );
      
      // Şimdilik sadece print
      print('Lokasyon kaydedildi: $selectedCountry, $selectedCity');
      
    } catch (e) {
      print('Lokasyon kaydedilirken hata: $e');
    }
  }
}
