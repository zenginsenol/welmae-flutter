import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/signup_service.dart';

class PhoneInputScreen extends StatefulWidget {
  const PhoneInputScreen({super.key});

  @override
  State<PhoneInputScreen> createState() => _PhoneInputScreenState();
}

class _PhoneInputScreenState extends State<PhoneInputScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isValid = false;
  
  // Velmae Brand Colors
  static const Color velmaeTeal = Color(0xFF03A6A6);
  static const Color velmaeLightTeal = Color(0xFFEBFEFE);
  static const Color velmaeDarkTeal = Color(0xFF013C3C);
  static const Color velmaeMint = Color(0xFFB8E6E6);

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(() {
      setState(() {
        _isValid = _isValidPhone(_phoneController.text);
      });
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  bool _isValidPhone(String phone) {
    // Turkish phone number validation
    final cleaned = phone.replaceAll(RegExp(r'[^\d]'), '');
    return cleaned.length >= 10 && cleaned.length <= 11;
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
                    // Phone Icon
                    _buildPhoneIcon(),
                    
                    const SizedBox(height: 30),
                    
                    // Title
                    _buildTitle(),
                    
                    const SizedBox(height: 40),
                    
                    // Phone Input
                    _buildPhoneInput(),
                    
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
        value: 0.7, // %70 tamamlandı
        backgroundColor: velmaeMint,
        valueColor: AlwaysStoppedAnimation<Color>(velmaeTeal),
      ),
    );
  }

  Widget _buildPhoneIcon() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: velmaeMint,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Icon(
        Icons.phone,
        size: 50,
        color: velmaeDarkTeal,
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        Text(
          'Telefon numaranız',
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Hesabınızı doğrulamak için\ntelefon numaranıza SMS göndereceğiz',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildPhoneInput() {
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
      child: Row(
        children: [
          // Country Code
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Row(
              children: [
                Text(
                  '🇹🇷',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(width: 8),
                Text(
                  '+90',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  width: 1,
                  height: 20,
                  color: Colors.grey[300],
                ),
              ],
            ),
          ),
          
          // Phone Input
          Expanded(
            child: TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                hintText: '5XX XXX XX XX',
                hintStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[400],
                  fontWeight: FontWeight.w500,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
                _PhoneNumberFormatter(),
              ],
              onChanged: (value) {
                // Real-time validation
              },
            ),
          ),
        ],
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

  void _handleContinue() async {
    if (!_isValid) return;
    
    HapticFeedback.mediumImpact();
    
    final phone = '+90${_phoneController.text.replaceAll(RegExp(r'[^\d]'), '')}';
    
    // Show loading
    _showLoadingDialog();
    
    try {
      // Check if phone already exists
      final phoneExists = await SignupService.checkPhoneExists(phone);
      
      if (phoneExists) {
        Navigator.of(context).pop(); // Hide loading
        _showErrorDialog('Bu telefon numarası zaten kullanılıyor. Farklı bir numara deneyin.');
        return;
      }
      
      // Send OTP
      final otpResponse = await SignupService.sendOtp(phone);
      
      // Hide loading
      Navigator.of(context).pop();
      
      if (otpResponse.success) {
        // Get previous data
        final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
        
        // Create updated arguments
        final updatedArgs = {
          ...?args,
          'phone': phone,
        };
        
        // Navigate to OTP verification
        Navigator.pushNamed(
          context,
          '/otp-verification',
          arguments: {
            ...updatedArgs,
            'phone': phone,
          },
        );
      } else {
        _showErrorDialog(otpResponse.message);
      }
      
    } catch (e) {
      // Hide loading
      Navigator.of(context).pop();
      
      // Even if backend is down, go to OTP verification for demo
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      final updatedArgs = {
        ...?args,
        'phone': phone,
      };
      
      // Show demo message and continue to OTP
      _showDemoMessage();
      
      Navigator.pushNamed(
        context,
        '/otp-verification',
        arguments: {
          ...updatedArgs,
          'phone': phone,
        },
      );
    }
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(velmaeTeal),
              ),
              const SizedBox(height: 16),
              const Text(
                'SMS gönderiliyor...',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Uyarı'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Tamam',
              style: TextStyle(color: velmaeTeal),
            ),
          ),
        ],
      ),
    );
  }

  void _showDemoMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Demo modu: OTP kodu 123456'),
        backgroundColor: velmaeTeal,
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Tamam',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}

class _PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    
    if (text.isEmpty) {
      return newValue.copyWith(text: '');
    }
    
    String formatted = '';
    
    if (text.length >= 1) {
      formatted = text[0];
    }
    if (text.length >= 3) {
      formatted += text.substring(1, 3);
    } else if (text.length >= 2) {
      formatted += text.substring(1);
    }
    if (text.length >= 6) {
      formatted += ' ${text.substring(3, 6)}';
    } else if (text.length >= 4) {
      formatted += ' ${text.substring(3)}';
    }
    if (text.length >= 8) {
      formatted += ' ${text.substring(6, 8)}';
    } else if (text.length >= 7) {
      formatted += ' ${text.substring(6)}';
    }
    if (text.length >= 10) {
      formatted += ' ${text.substring(8, 10)}';
    } else if (text.length >= 9) {
      formatted += ' ${text.substring(8)}';
    }
    
    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
