import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BirthdateInputScreen extends StatefulWidget {
  const BirthdateInputScreen({super.key});

  @override
  State<BirthdateInputScreen> createState() => _BirthdateInputScreenState();
}

class _BirthdateInputScreenState extends State<BirthdateInputScreen> {
  DateTime? selectedDate;
  bool _isValid = false;
  
  // Velmae Brand Colors
  static const Color velmaeTeal = Color(0xFF03A6A6);
  static const Color velmaeLightTeal = Color(0xFFEBFEFE);
  static const Color velmaeDarkTeal = Color(0xFF013C3C);
  static const Color velmaeMint = Color(0xFFB8E6E6);

  @override
  void initState() {
    super.initState();
  }

  bool _isValidAge(DateTime? date) {
    if (date == null) return false;
    
    final now = DateTime.now();
    final age = now.year - date.year;
    
    // Check if birthday has occurred this year
    final hasHadBirthdayThisYear = now.month > date.month || 
        (now.month == date.month && now.day >= date.day);
    
    final actualAge = hasHadBirthdayThisYear ? age : age - 1;
    
    return actualAge >= 13 && actualAge <= 100; // Age limits
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
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
            
            // Progress Indicator
            _buildProgressIndicator(),
            
            // Main Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Calendar Icon
                    _buildCalendarIcon(),
                    
                    const SizedBox(height: 30),
                    
                    // Title
                    _buildTitle(),
                    
                    const SizedBox(height: 40),
                    
                    // Date Picker Button
                    _buildDatePickerButton(),
                    
                    const SizedBox(height: 40),
                    
                    // Continue Button
                    _buildContinueButton(),
                  ],
                ),
              ),
            ),
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

  Widget _buildProgressIndicator() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 2,
      child: LinearProgressIndicator(
        value: 0.9, // %90 tamamlandı
        backgroundColor: velmaeMint,
        valueColor: AlwaysStoppedAnimation<Color>(velmaeTeal),
      ),
    );
  }

  Widget _buildCalendarIcon() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: velmaeMint,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Icon(
        Icons.calendar_today,
        size: 50,
        color: velmaeDarkTeal,
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        Text(
          'Doğum tarihiniz',
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Yaşınızı doğrulamak ve size uygun\niçerikleri gösterebilmek için',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildDatePickerButton() {
    return GestureDetector(
      onTap: _showDatePicker,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isValid ? velmaeTeal : Colors.grey.withValues(alpha: 0.3),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              Icons.calendar_month,
              color: _isValid ? velmaeTeal : Colors.grey[400],
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                selectedDate != null
                    ? _formatDate(selectedDate!)
                    : 'Doğum tarihinizi seçin',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: selectedDate != null ? Colors.black : Colors.grey[400],
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey[400],
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return Container(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _isValid ? _handleContinue : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: _isValid ? velmaeTeal : Colors.grey[300],
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        child: Text(
          'Devam Et',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: _isValid ? Colors.white : Colors.grey[500],
          ),
        ),
      ),
    );
  }

  void _showDatePicker() async {
    final DateTime now = DateTime.now();
    final DateTime initialDate = selectedDate ?? DateTime(now.year - 25); // Default to 25 years old
    
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(now.year - 100), // 100 years ago
      lastDate: DateTime(now.year - 13),   // 13 years ago (minimum age)
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: velmaeTeal,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: velmaeTeal,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _isValid = _isValidAge(picked);
      });
      
      HapticFeedback.mediumImpact();
    }
  }

  void _handleContinue() {
    if (!_isValid || selectedDate == null) return;
    
    HapticFeedback.mediumImpact();
    
    // Get previous data
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    
    // Create updated arguments
    final updatedArgs = {
      ...?args,
      'birthdate': selectedDate!.toIso8601String(),
    };
    
    // Navigate to bio input
    Navigator.pushNamed(
      context,
      '/bio-input',
      arguments: updatedArgs,
    );
  }
}
