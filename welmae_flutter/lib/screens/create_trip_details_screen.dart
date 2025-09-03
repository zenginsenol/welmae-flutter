import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../services/tier_restriction_service.dart';

class CreateTripDetailsScreen extends StatefulWidget {
  final String tripType;
  final String title;

  const CreateTripDetailsScreen({
    super.key,
    required this.tripType,
    required this.title,
  });

  @override
  State<CreateTripDetailsScreen> createState() =>
      _CreateTripDetailsScreenState();
}

class _CreateTripDetailsScreenState extends State<CreateTripDetailsScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;
  int _participantCount = 1;
  int _maxParticipants = 5; // Default for Bronze tier
  String _selectedCategory = 'Şehir Turu';
  late TierRestrictionService _tierService;

  // Velmae Brand Colors
  static const Color velmaePrimary = Color(0xFF2563EB);
  static const Color velmaeSecondary = Color(0xFF10B981);
  static const Color velmaeAccent = Color(0xFFEF4444);
  static const Color velmaeOrange = Color(0xFFF97316);
  static const Color surfaceWhite = Color(0xFFFFFFFF);
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color textDark = Color(0xFF0F172A);
  static const Color textMedium = Color(0xFF475569);
  static const Color textLight = Color(0xFF94A3B8);
  static const Color borderLight = Color(0xFFE2E8F0);

  final List<String> categories = [
    'Şehir Turu',
    'Doğa Gezisi',
    'Kültür Turu',
    'Macera',
    'Deniz Tatili',
    'Dağ Turu',
  ];

  @override
  void initState() {
    super.initState();
    _tierService = TierRestrictionService();
    _setupAnimations();
    _getUserTierLimits();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<double>(begin: 40.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 1.0, curve: Curves.elasticOut),
      ),
    );

    _animationController.forward();
  }

  Future<void> _getUserTierLimits() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    if (authProvider.currentUser == null) return;

    final userTier = authProvider.currentUser!.tier;
    final result = await _tierService.getTierLimits(userTier);

    if (result.success && result.data != null && mounted) {
      setState(() {
        _maxParticipants = result.data!['maxParticipantsPerTrip'] as int? ?? 5;
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _destinationController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _budgetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundLight,
      appBar: _buildAppBar(),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: Transform.translate(
              offset: Offset(0, _slideAnimation.value),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 32),
                    _buildDestinationInput(),
                    const SizedBox(height: 24),
                    _buildTitleInput(),
                    const SizedBox(height: 24),
                    _buildCategorySelector(),
                    const SizedBox(height: 24),
                    _buildDateSelector(),
                    const SizedBox(height: 24),
                    _buildParticipantSelector(),
                    const SizedBox(height: 24),
                    if (widget.tripType == 'sponsor') _buildBudgetInput(),
                    if (widget.tripType == 'sponsor')
                      const SizedBox(height: 24),
                    _buildDescriptionInput(),
                    const SizedBox(height: 32),
                    _buildCreateButton(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: surfaceWhite,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: backgroundLight,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: textDark,
            size: 18,
          ),
        ),
      ),
      title: Text(
        widget.title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: textDark,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildHeader() {
    final color = widget.tripType == 'sponsor'
        ? velmaePrimary
        : velmaeSecondary;
    final icon = widget.tripType == 'sponsor'
        ? Icons.card_travel
        : Icons.explore;

    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.3),
                offset: const Offset(0, 8),
                blurRadius: 24,
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 40),
        ),
        const SizedBox(height: 20),
        Text(
          widget.tripType == 'sponsor'
              ? 'Gezi Detayları'
              : 'Rehberlik Detayları',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: textDark,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.tripType == 'sponsor'
              ? 'Sponsorluk yapacağınız gezinin detaylarını belirleyin'
              : 'Rehberlik yapacağınız gezinin detaylarını belirleyin',
          style: const TextStyle(fontSize: 16, color: textMedium),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildDestinationInput() {
    return _buildInputField(
      label: 'Destinasyon',
      hint: 'Gitmek istediğiniz yeri yazın...',
      controller: _destinationController,
      icon: Icons.location_on,
    );
  }

  Widget _buildTitleInput() {
    return _buildInputField(
      label: 'Gezi Başlığı',
      hint: 'Geziniz için çekici bir başlık yazın...',
      controller: _titleController,
      icon: Icons.title,
    );
  }

  Widget _buildInputField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: textDark,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: surfaceWhite,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderLight),
          ),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: textLight),
              prefixIcon: Icon(icon, color: velmaePrimary),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategorySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Kategori',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: textDark,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: categories.map((category) {
            final isSelected = _selectedCategory == category;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategory = category;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? velmaePrimary : surfaceWhite,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? velmaePrimary : borderLight,
                  ),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    color: isSelected ? Colors.white : textMedium,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDateSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tarih Aralığı',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: textDark,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: _buildDateField('Başlangıç', _startDate, true)),
            const SizedBox(width: 12),
            Expanded(child: _buildDateField('Bitiş', _endDate, false)),
          ],
        ),
      ],
    );
  }

  Widget _buildDateField(String label, DateTime? date, bool isStart) {
    return GestureDetector(
      onTap: () => _selectDate(isStart),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: surfaceWhite,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderLight),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: textMedium),
            ),
            const SizedBox(height: 4),
            Text(
              date != null
                  ? '${date.day}/${date.month}/${date.year}'
                  : 'Tarih seçin',
              style: TextStyle(
                fontSize: 16,
                color: date != null ? textDark : textLight,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildParticipantSelector() {
    final isAtMax =
        _maxParticipants != -1 && _participantCount >= _maxParticipants;
    final canDecrease = _participantCount > 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Katılımcı Sayısı',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: textDark,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: surfaceWhite,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderLight),
          ),
          child: Row(
            children: [
              const Icon(Icons.people, color: velmaePrimary),
              const SizedBox(width: 12),
              Text(
                '$_participantCount kişi',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: textDark,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  IconButton(
                    onPressed: canDecrease
                        ? () => setState(() => _participantCount--)
                        : null,
                    icon: const Icon(Icons.remove_circle_outline),
                  ),
                  IconButton(
                    onPressed: !isAtMax
                        ? () => setState(() => _participantCount++)
                        : null,
                    icon: Icon(
                      isAtMax ? Icons.lock : Icons.add_circle_outline,
                      color: isAtMax ? Colors.orange : null,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (isAtMax && _maxParticipants != -1)
          Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.orange.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.info, color: Colors.orange, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Maksimum $_maxParticipants katılımcı ekleyebilirsiniz. Daha fazlası için üyeliğinizi yükseltin.',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.orange,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/subscription');
                  },
                  child: const Text(
                    'Yükselt',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.orange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildBudgetInput() {
    return _buildInputField(
      label: 'Bütçe (₺)',
      hint: 'Tahmini bütçe yazın...',
      controller: _budgetController,
      icon: Icons.attach_money,
    );
  }

  Widget _buildDescriptionInput() {
    return _buildInputField(
      label: 'Açıklama',
      hint: 'Gezi hakkında detaylı bilgi verin...',
      controller: _descriptionController,
      icon: Icons.description,
      maxLines: 4,
    );
  }

  Widget _buildCreateButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [velmaePrimary, velmaeSecondary],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: velmaePrimary.withValues(alpha: 0.3),
            offset: const Offset(0, 8),
            blurRadius: 24,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _handleCreateTrip,
          borderRadius: BorderRadius.circular(16),
          child: const Center(
            child: Text(
              'Gezi Oluştur',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _selectDate(bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  void _handleCreateTrip() {
    HapticFeedback.mediumImpact();

    // Show success message and navigate back
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          widget.tripType == 'sponsor'
              ? 'Sponsorluk talebiniz oluşturuldu!'
              : 'Rehberlik talebiniz oluşturuldu!',
        ),
        backgroundColor: velmaeSecondary,
      ),
    );

    Navigator.popUntil(context, ModalRoute.withName('/home'));
  }
}
