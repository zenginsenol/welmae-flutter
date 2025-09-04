import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NameInputScreen extends StatefulWidget {
  const NameInputScreen({super.key});

  @override
  State<NameInputScreen> createState() => _NameInputScreenState();
}

class _NameInputScreenState extends State<NameInputScreen> {
  final TextEditingController _nameController = TextEditingController();
  bool _isValid = false;
  
  // Velmae Brand Colors
  static const Color velmaeTeal = Color(0xFF03A6A6);
  static const Color velmaeLightTeal = Color(0xFFEBFEFE);
  static const Color velmaeDarkTeal = Color(0xFF013C3C);
  static const Color velmaeMint = Color(0xFFB8E6E6);

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() {
      setState(() {
        _isValid = _nameController.text.trim().length >= 2;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
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
            
            // Progress Indicator
            _buildProgressIndicator(),
            
            // Main Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // User Icon
                    _buildUserIcon(),
                    
                    const SizedBox(height: 30),
                    
                    // Title
                    _buildTitle(),
                    
                    const SizedBox(height: 40),
                    
                    // Name Input
                    _buildNameInput(),
                    
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
        value: 0.5, // %50 tamamlandı
        backgroundColor: velmaeMint,
        valueColor: AlwaysStoppedAnimation<Color>(velmaeTeal),
      ),
    );
  }

  Widget _buildUserIcon() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: velmaeMint,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Icon(
        Icons.person,
        size: 50,
        color: velmaeDarkTeal,
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        Text(
          'Adınız nedir?',
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Arkadaşlarınızın sizi bulabilmesi için\ngerçek adınızı kullanın',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildNameInput() {
    return Container(
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
      child: TextField(
        controller: _nameController,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          hintText: 'Adınızı girin',
          hintStyle: TextStyle(
            fontSize: 20,
            color: Colors.grey[400],
            fontWeight: FontWeight.w500,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
        ),
        textCapitalization: TextCapitalization.words,
        onChanged: (value) {
          // Real-time validation
        },
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

  void _handleContinue() {
    if (!_isValid) return;
    
    HapticFeedback.mediumImpact();
    
    // Get previous data
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    
    // Create updated arguments
    final updatedArgs = {
      ...?args,
      'name': _nameController.text.trim(),
    };
    
    // Navigate to email input
    Navigator.pushNamed(
      context,
      '/email-input',
      arguments: updatedArgs,
    );
  }
}
