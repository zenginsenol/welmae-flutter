import 'package:flutter/material.dart';

class TripsScreen extends StatefulWidget {
  const TripsScreen({super.key});

  @override
  State<TripsScreen> createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen> {
  String activeTab = 'upcoming';

  final List<Map<String, dynamic>> upcomingTrips = [
    {
      'id': 1,
      'title': 'Kapadokya Turu',
      'location': 'Nevşehir, Türkiye',
      'image': 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=300&h=200&fit=crop',
      'date': '15-18 Ağustos 2024',
      'status': 'confirmed',
      'type': 'flight',
      'price': '₺2,500',
    },
    {
      'id': 2,
      'title': 'Antalya Tatili',
      'location': 'Antalya, Türkiye',
      'image': 'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=300&h=200&fit=crop',
      'date': '25-30 Eylül 2024',
      'status': 'pending',
      'type': 'hotel',
      'price': '₺1,800',
    },
  ];

  final List<Map<String, dynamic>> pastTrips = [
    {
      'id': 3,
      'title': 'İstanbul Gezisi',
      'location': 'İstanbul, Türkiye',
      'image': 'https://images.unsplash.com/photo-1524231757912-21f4fe3a7200?w=300&h=200&fit=crop',
      'date': '10-15 Haziran 2024',
      'status': 'completed',
      'type': 'flight',
      'price': '₺3,200',
    },
    {
      'id': 4,
      'title': 'Pamukkale Turu',
      'location': 'Denizli, Türkiye',
      'image': 'https://images.unsplash.com/photo-1589308078059-be1415eab4c3?w=300&h=200&fit=crop',
      'date': '5-8 Mayıs 2024',
      'status': 'completed',
      'type': 'car',
      'price': '₺1,200',
    },
  ];

  Color getStatusColor(String status) {
    switch (status) {
      case 'confirmed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'completed':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  String getStatusText(String status) {
    switch (status) {
      case 'confirmed':
        return 'Onaylandı';
      case 'pending':
        return 'Beklemede';
      case 'completed':
        return 'Tamamlandı';
      default:
        return 'Bilinmiyor';
    }
  }

  IconData getTypeIcon(String type) {
    switch (type) {
      case 'flight':
        return Icons.flight;
      case 'hotel':
        return Icons.hotel;
      case 'car':
        return Icons.directions_car;
      default:
        return Icons.place;
    }
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
                    'Seyahatlerim',
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
                      Icons.calendar_today_outlined,
                      color: Colors.grey[600],
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),

            // Stats
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF2563EB).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFF2563EB).withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildStatItem(
                        icon: Icons.flight,
                        label: 'Toplam Seyahat',
                        value: '${upcomingTrips.length + pastTrips.length}',
                        color: const Color(0xFF2563EB),
                      ),
                    ),
                    Expanded(
                      child: _buildStatItem(
                        icon: Icons.place,
                        label: 'Ziyaret Edilen',
                        value: '${pastTrips.length}',
                        color: const Color(0xFF10B981),
                      ),
                    ),
                    Expanded(
                      child: _buildStatItem(
                        icon: Icons.schedule,
                        label: 'Planlanan',
                        value: '${upcomingTrips.length}',
                        color: const Color(0xFFF59E0B),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            activeTab = 'upcoming';
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: activeTab == 'upcoming' ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: activeTab == 'upcoming'
                                ? [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ]
                                : null,
                          ),
                          child: Text(
                            'Yaklaşan',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: activeTab == 'upcoming' ? const Color(0xFF2563EB) : Colors.grey[600],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            activeTab = 'past';
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: activeTab == 'past' ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: activeTab == 'past'
                                ? [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ]
                                : null,
                          ),
                          child: Text(
                            'Geçmiş',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: activeTab == 'past' ? const Color(0xFF2563EB) : Colors.grey[600],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Trip List
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: activeTab == 'upcoming'
                    ? _buildTripList(upcomingTrips, 'upcoming')
                    : _buildTripList(pastTrips, 'past'),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to explore screen
        },
        backgroundColor: const Color(0xFF2563EB),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildTripList(List<Map<String, dynamic>> trips, String type) {
    if (trips.isEmpty) {
      return _buildEmptyState(type);
    }

    return ListView.builder(
      itemCount: trips.length,
      itemBuilder: (context, index) {
        final trip = trips[index];
        return _buildTripCard(trip);
      },
    );
  }

  Widget _buildEmptyState(String type) {
    IconData icon;
    String title;
    String subtitle;

    if (type == 'upcoming') {
      icon = Icons.flight_outlined;
      title = 'Yaklaşan seyahat yok';
      subtitle = 'Yeni bir seyahat planlamaya başla!';
    } else {
      icon = Icons.history;
      title = 'Geçmiş seyahat yok';
      subtitle = 'İlk seyahatinizi planlayın!';
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
          if (type == 'upcoming') ...[
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to explore screen
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2563EB),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Destinasyonları Keşfet'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTripCard(Map<String, dynamic> trip) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Image
            Image.network(
              trip['image'],
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),

            // Status Badge
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: getStatusColor(trip['status']),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  getStatusText(trip['status']),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            // Type Icon
            Positioned(
              top: 16,
              left: 16,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  getTypeIcon(trip['type']),
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),

            // Content Overlay
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.8),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trip['title'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      trip['location'],
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          trip['date'],
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          trip['price'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
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
