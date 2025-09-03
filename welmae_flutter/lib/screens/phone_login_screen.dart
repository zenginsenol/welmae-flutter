import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneLoginScreen extends StatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  
  // Velmae Brand Colors
  static const Color velmaeTeal = Color(0xFF03A6A6);
  static const Color velmaeLightTeal = Color(0xFFEBFEFE);
  static const Color velmaeDarkTeal = Color(0xFF013C3C);
  static const Color velmaeMint = Color(0xFFB8E6E6);

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    HapticFeedback.mediumImpact();
    
    if (_phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen telefon numaranızı girin'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    
    // TODO: Backend'e telefon numarası gönder
    Navigator.pushNamed(context, '/otp-verification');
  }

  void _handleSignup() {
    HapticFeedback.mediumImpact();
    Navigator.pushNamed(context, '/location-selection');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: velmaeLightTeal,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Logo ve Progress
              _buildHeader(),
              
              const SizedBox(height: 40),
              
              // Ana İçerik
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Telefon İkonu
                    _buildPhoneIcon(),
                    
                    const SizedBox(height: 30),
                    
                    // Başlık
                    _buildTitle(),
                    
                    const SizedBox(height: 40),
                    
                    // Telefon Input
                    _buildPhoneInput(),
                    
                    const SizedBox(height: 40),
                    
                    // Giriş Yap Butonu
                    _buildLoginButton(),
                  ],
                ),
              ),
              
              // Alt Link
              _buildSignupLink(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
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
        
        const SizedBox(height: 10),
        
        // Progress Line
        Container(
          height: 2,
          width: double.infinity,
          decoration: BoxDecoration(
            color: velmaeMint,
            borderRadius: BorderRadius.circular(1),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: 0.3, // %30 progress
            child: Container(
              decoration: BoxDecoration(
                color: velmaeTeal,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneIcon() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: velmaeMint,
        borderRadius: BorderRadius.circular(60),
        border: Border.all(
          color: velmaeDarkTeal,
          width: 2,
        ),
      ),
      child: Icon(
        Icons.phone_android,
        size: 60,
        color: velmaeDarkTeal,
      ),
    );
  }

  Widget _buildTitle() {
    return const Text(
      'Telefon numarası',
      style: TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildPhoneInput() {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: velmaeTeal,
          width: 1,
        ),
      ),
      child: TextField(
        controller: _phoneController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          hintText: 'Telefon numarası [+90 XXX XXX XX XX]',
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontSize: 16,
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

  Widget _buildLoginButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: velmaeMint,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(28),
          onTap: _handleLogin,
          child: const Center(
            child: Text(
              'Giriş Yap',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignupLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Üyeliğiniz yok mu? ',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        GestureDetector(
          onTap: _handleSignup,
          child: const Text(
            'Hemen üye olun',
            style: TextStyle(
              color: velmaeTeal,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
