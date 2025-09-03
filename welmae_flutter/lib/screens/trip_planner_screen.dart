import 'package:flutter/material.dart';
import '../app/theme/typography.dart';
import '../app/theme/dimensions.dart';

class TripPlannerScreen extends StatefulWidget {
  const TripPlannerScreen({super.key});

  @override
  State<TripPlannerScreen> createState() => _TripPlannerScreenState();
}

class _TripPlannerScreenState extends State<TripPlannerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _destinationController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _budgetController = TextEditingController();
  final _notesController = TextEditingController();

  String _selectedTripType = 'leisure';
  String _selectedAccommodation = 'hotel';
  final List<String> _selectedActivities = [];
  final List<String> _selectedTransportation = [];

  final List<TripType> _tripTypes = [
    TripType('leisure', 'Tatil', Icons.beach_access, Colors.blue),
    TripType('business', 'İş', Icons.business, Colors.green),
    TripType('adventure', 'Macera', Icons.terrain, Colors.orange),
    TripType('cultural', 'Kültür', Icons.museum, Colors.purple),
    TripType('romantic', 'Romantik', Icons.favorite, Colors.red),
    TripType('family', 'Aile', Icons.family_restroom, Colors.teal),
  ];

  final List<AccommodationType> _accommodationTypes = [
    AccommodationType('hotel', 'Otel', Icons.hotel),
    AccommodationType('hostel', 'Hostel', Icons.bed),
    AccommodationType('apartment', 'Apartman', Icons.apartment),
    AccommodationType('resort', 'Resort', Icons.beach_access),
    AccommodationType('camping', 'Kamp', Icons.cabin),
  ];

  final List<Activity> _activities = [
    Activity('sightseeing', 'Gezilecek Yerler', Icons.visibility),
    Activity('food', 'Yemek', Icons.restaurant),
    Activity('shopping', 'Alışveriş', Icons.shopping_bag),
    Activity('nightlife', 'Gece Hayatı', Icons.nightlife),
    Activity('outdoor', 'Açık Hava', Icons.hiking),
    Activity('wellness', 'Spa & Wellness', Icons.spa),
  ];

  final List<Transportation> _transportationOptions = [
    Transportation('plane', 'Uçak', Icons.flight),
    Transportation('train', 'Tren', Icons.train),
    Transportation('bus', 'Otobüs', Icons.directions_bus),
    Transportation('car', 'Araba', Icons.directions_car),
    Transportation('ship', 'Gemi', Icons.directions_boat),
  ];

  @override
  void dispose() {
    _destinationController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _budgetController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Seyahat Planlayıcı',
          style: AppTypography.titleLarge.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.save, color: theme.colorScheme.primary),
            onPressed: _saveTripPlan,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.pagePadding,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Trip Type Selection
              _buildTripTypeSelection(theme),
              const SizedBox(height: AppSpacing.xl),

              // Basic Information
              _buildBasicInformation(theme),
              const SizedBox(height: AppSpacing.xl),

              // Accommodation
              _buildAccommodationSelection(theme),
              const SizedBox(height: AppSpacing.xl),

              // Activities
              _buildActivitiesSelection(theme),
              const SizedBox(height: AppSpacing.xl),

              // Transportation
              _buildTransportationSelection(theme),
              const SizedBox(height: AppSpacing.xl),

              // Notes
              _buildNotesSection(theme),
              const SizedBox(height: AppSpacing.xl),

              // Create Plan Button
              _buildCreatePlanButton(theme),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTripTypeSelection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Seyahat Türü',
          style: AppTypography.titleMedium.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: AppSpacing.sm,
            mainAxisSpacing: AppSpacing.sm,
            childAspectRatio: 1.2,
          ),
          itemCount: _tripTypes.length,
          itemBuilder: (context, index) {
            final tripType = _tripTypes[index];
            final isSelected = _selectedTripType == tripType.id;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTripType = tripType.id;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: isSelected
                      ? tripType.color.withValues(alpha: 0.1)
                      : theme.colorScheme.surface,
                  border: Border.all(
                    color: isSelected
                        ? tripType.color
                        : theme.colorScheme.outline,
                    width: isSelected ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      tripType.icon,
                      size: 32,
                      color: isSelected
                          ? tripType.color
                          : theme.colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      tripType.name,
                      style: AppTypography.bodySmall.copyWith(
                        color: isSelected
                            ? tripType.color
                            : theme.colorScheme.onSurface,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildBasicInformation(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Temel Bilgiler',
          style: AppTypography.titleMedium.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // Destination
        TextFormField(
          controller: _destinationController,
          decoration: InputDecoration(
            labelText: 'Destinasyon',
            hintText: 'Nereye gitmek istiyorsunuz?',
            prefixIcon: Icon(
              Icons.location_on,
              color: theme.colorScheme.primary,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Destinasyon gerekli';
            }
            return null;
          },
        ),
        const SizedBox(height: AppSpacing.md),

        // Date Range
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _startDateController,
                decoration: InputDecoration(
                  labelText: 'Başlangıç Tarihi',
                  prefixIcon: Icon(
                    Icons.calendar_today,
                    color: theme.colorScheme.primary,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                  ),
                ),
                readOnly: true,
                onTap: () => _selectDate(context, _startDateController, true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Başlangıç tarihi gerekli';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: TextFormField(
                controller: _endDateController,
                decoration: InputDecoration(
                  labelText: 'Bitiş Tarihi',
                  prefixIcon: Icon(
                    Icons.calendar_today,
                    color: theme.colorScheme.primary,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                  ),
                ),
                readOnly: true,
                onTap: () => _selectDate(context, _endDateController, false),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bitiş tarihi gerekli';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),

        // Budget
        TextFormField(
          controller: _budgetController,
          decoration: InputDecoration(
            labelText: 'Bütçe',
            hintText: 'Toplam bütçeniz (opsiyonel)',
            prefixIcon: Icon(
              Icons.account_balance_wallet,
              color: theme.colorScheme.primary,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            ),
          ),
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  Widget _buildAccommodationSelection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Konaklama Türü',
          style: AppTypography.titleMedium.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: _accommodationTypes.map((accommodation) {
            final isSelected = _selectedAccommodation == accommodation.id;

            return FilterChip(
              label: Text(accommodation.name),
              avatar: Icon(
                accommodation.icon,
                size: 18,
                color: isSelected
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onSurfaceVariant,
              ),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedAccommodation = accommodation.id;
                });
              },
              selectedColor: theme.colorScheme.primary,
              checkmarkColor: theme.colorScheme.onPrimary,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildActivitiesSelection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Aktiviteler',
          style: AppTypography.titleMedium.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: _activities.map((activity) {
            final isSelected = _selectedActivities.contains(activity.id);

            return FilterChip(
              label: Text(activity.name),
              avatar: Icon(
                activity.icon,
                size: 18,
                color: isSelected
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onSurfaceVariant,
              ),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedActivities.add(activity.id);
                  } else {
                    _selectedActivities.remove(activity.id);
                  }
                });
              },
              selectedColor: theme.colorScheme.primary,
              checkmarkColor: theme.colorScheme.onPrimary,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTransportationSelection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ulaşım',
          style: AppTypography.titleMedium.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: _transportationOptions.map((transport) {
            final isSelected = _selectedTransportation.contains(transport.id);

            return FilterChip(
              label: Text(transport.name),
              avatar: Icon(
                transport.icon,
                size: 18,
                color: isSelected
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onSurfaceVariant,
              ),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedTransportation.add(transport.id);
                  } else {
                    _selectedTransportation.remove(transport.id);
                  }
                });
              },
              selectedColor: theme.colorScheme.primary,
              checkmarkColor: theme.colorScheme.onPrimary,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildNotesSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notlar',
          style: AppTypography.titleMedium.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        TextFormField(
          controller: _notesController,
          decoration: InputDecoration(
            labelText: 'Ek notlar',
            hintText: 'Özel istekler, notlar...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            ),
          ),
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildCreatePlanButton(ThemeData theme) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        onPressed: _createTripPlan,
        icon: const Icon(Icons.rocket_launch),
        label: const Text('Seyahat Planını Oluştur'),
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(
    BuildContext context,
    TextEditingController controller,
    bool isStartDate,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: isStartDate ? DateTime.now() : DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      controller.text = '${picked.day}/${picked.month}/${picked.year}';
    }
  }

  void _saveTripPlan() {
    if (_formKey.currentState!.validate()) {
      // Trip plan'ı kaydet
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Seyahat planı kaydedildi!'),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );
    }
  }

  void _createTripPlan() {
    if (_formKey.currentState!.validate()) {
      // Trip plan oluştur ve göster
      _showTripPlanSummary();
    }
  }

  void _showTripPlanSummary() {
    final theme = Theme.of(context);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: theme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSizes.radiusLg),
        ),
      ),
      builder: (context) => Container(
        padding: AppSpacing.pagePadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurfaceVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Title
            Text(
              'Seyahat Planı Özeti',
              style: AppTypography.titleLarge.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Plan details
            _buildPlanDetail(
              'Destinasyon',
              _destinationController.text,
              Icons.location_on,
            ),
            _buildPlanDetail(
              'Tarih',
              '${_startDateController.text} - ${_endDateController.text}',
              Icons.calendar_today,
            ),
            _buildPlanDetail(
              'Seyahat Türü',
              _getTripTypeName(_selectedTripType),
              Icons.category,
            ),
            _buildPlanDetail(
              'Konaklama',
              _getAccommodationName(_selectedAccommodation),
              Icons.hotel,
            ),
            _buildPlanDetail(
              'Aktiviteler',
              _selectedActivities.length.toString(),
              Icons.list,
            ),
            _buildPlanDetail(
              'Ulaşım',
              _selectedTransportation.length.toString(),
              Icons.directions_car,
            ),

            if (_budgetController.text.isNotEmpty)
              _buildPlanDetail(
                'Bütçe',
                _budgetController.text,
                Icons.account_balance_wallet,
              ),

            const SizedBox(height: AppSpacing.lg),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Düzenle'),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _saveTripPlan();
                    },
                    child: const Text('Kaydet'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanDetail(String label, String value, IconData icon) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          Icon(icon, size: 20, color: theme.colorScheme.primary),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTypography.bodySmall.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  value,
                  style: AppTypography.bodyMedium.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getTripTypeName(String id) {
    return _tripTypes.firstWhere((type) => type.id == id).name;
  }

  String _getAccommodationName(String id) {
    return _accommodationTypes.firstWhere((type) => type.id == id).name;
  }
}

class TripType {
  final String id;
  final String name;
  final IconData icon;
  final Color color;

  const TripType(this.id, this.name, this.icon, this.color);
}

class AccommodationType {
  final String id;
  final String name;
  final IconData icon;

  const AccommodationType(this.id, this.name, this.icon);
}

class Activity {
  final String id;
  final String name;
  final IconData icon;

  const Activity(this.id, this.name, this.icon);
}

class Transportation {
  final String id;
  final String name;
  final IconData icon;

  const Transportation(this.id, this.name, this.icon);
}
