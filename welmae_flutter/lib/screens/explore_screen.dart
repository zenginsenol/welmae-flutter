import 'package:flutter/material.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String selectedCategory = 'Tümü';

  final List<Map<String, dynamic>> categories = [
    {'id': 1, 'name': 'Tümü', 'icon': Icons.grid_3x3},
    {'id': 2, 'name': 'Doğa', 'icon': Icons.landscape},
    {'id': 3, 'name': 'Şehir', 'icon': Icons.location_city},
    {'id': 4, 'name': 'Plaj', 'icon': Icons.beach_access},
    {'id': 5, 'name': 'Dağ', 'icon': Icons.terrain},
    {'id': 6, 'name': 'Tarih', 'icon': Icons.history_edu},
  ];

  final List<Map<String, dynamic>> destinations = [
    {
      'id': '1',
      'name': 'Kapadokya',
      'location': 'Nevşehir, Türkiye',
      'image': 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=300&h=200&fit=crop',
      'rating': 4.8,
      'price': '₺2,500',
      'category': 'Doğa',
      'isFavorite': false,
    },
    {
      'id': '2',
      'name': 'Antalya',
      'location': 'Antalya, Türkiye',
      'image': 'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=300&h=200&fit=crop',
      'rating': 4.6,
      'price': '₺1,800',
      'category': 'Plaj',
      'isFavorite': true,
    },
    {
      'id': '3',
      'name': 'İstanbul',
      'location': 'İstanbul, Türkiye',
      'image': 'https://images.unsplash.com/photo-1524231757912-21f4fe3a7200?w=300&h=200&fit=crop',
      'rating': 4.7,
      'price': '₺3,200',
      'category': 'Şehir',
      'isFavorite': false,
    },
    {
      'id': '4',
      'name': 'Pamukkale',
      'location': 'Denizli, Türkiye',
      'image': 'https://images.unsplash.com/photo-1589308078059-be1415eab4c3?w=300&h=200&fit=crop',
      'rating': 4.5,
      'price': '₺1,500',
      'category': 'Doğa',
      'isFavorite': false,
    },
    {
      'id': '5',
      'name': 'Uludağ',
      'location': 'Bursa, Türkiye',
      'image': 'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=300&h=200&fit=crop',
      'rating': 4.4,
      'price': '₺2,800',
      'category': 'Dağ',
      'isFavorite': true,
    },
    {
      'id': '6',
      'name': 'Efes',
      'location': 'İzmir, Türkiye',
      'image': 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=300&h=200&fit=crop',
      'rating': 4.6,
      'price': '₺1,200',
      'category': 'Tarih',
      'isFavorite': false,
    },
  ];

  List<Map<String, dynamic>> get filteredDestinations {
    if (selectedCategory == 'Tümü') {
      return destinations;
    }
    return destinations.where((dest) => dest['category'] == selectedCategory).toList();
  }

  void _toggleFavorite(String destinationId) {
    setState(() {
      final destination = destinations.firstWhere((d) => d['id'] == destinationId);
      destination['isFavorite'] = !destination['isFavorite'];
    });
  }

  void _navigateToDestination(String destinationId) {
    Navigator.of(context).pushNamed('/destination', arguments: destinationId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Keşfet',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.filter_list,
                      color: Colors.grey[600],
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey[600], size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Destinasyon ara...',
                          hintStyle: TextStyle(color: Colors.grey[600]),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Icon(Icons.tune, color: Colors.grey[600], size: 20),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Categories
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = selectedCategory == category['name'];
                  
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = category['name'];
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF2563EB) : Colors.grey[100],
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: isSelected ? const Color(0xFF2563EB) : Colors.grey[300]!,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            category['icon'],
                            color: isSelected ? Colors.white : Colors.grey[600],
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            category['name'],
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.grey[600],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // Results Count
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${filteredDestinations.length} sonuç bulundu',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.sort, color: Colors.grey[600], size: 20),
                      const SizedBox(width: 4),
                      Text(
                        'Sırala',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Destinations Grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: filteredDestinations.length,
                  itemBuilder: (context, index) {
                    final destination = filteredDestinations[index];
                    return _buildDestinationCard(destination);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDestinationCard(Map<String, dynamic> destination) {
    return GestureDetector(
      onTap: () => _navigateToDestination(destination['id']),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Image.network(
                      destination['image'],
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          child: Icon(
                            Icons.image,
                            size: 40,
                            color: Colors.grey[400],
                          ),
                        );
                      },
                    ),
                  ),
                  
                  // Favorite Button
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () => _toggleFavorite(destination['id']),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          destination['isFavorite'] 
                              ? Icons.favorite 
                              : Icons.favorite_border,
                          color: destination['isFavorite'] 
                              ? Colors.red 
                              : Colors.grey[600],
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                  
                  // Price Tag
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2563EB),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        destination['price'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Content
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      destination['name'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    const SizedBox(height: 4),
                    
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.grey[600],
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            destination['location'],
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    
                    const Spacer(),
                    
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          destination['rating'].toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            destination['category'],
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
