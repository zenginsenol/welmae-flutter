import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import '../services/signup_service.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  
  String _otp = '';
  bool _isValid = false;
  bool _isResending = false;
  int _countdown = 60;
  Timer? _timer;
  String? _phone;
  
  // Velmae Brand Colors
  static const Color velmaeTeal = Color(0xFF03A6A6);
  static const Color velmaeLightTeal = Color(0xFFEBFEFE);
  static const Color velmaeDarkTeal = Color(0xFF013C3C);
  static const Color velmaeMint = Color(0xFFB8E6E6);

  @override
  void initState() {
    super.initState();
    _startCountdown();
    
    // Get phone from arguments
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null) {
        setState(() {
          _phone = args['phone'];
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _startCountdown() {
    _countdown = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        setState(() {
          _countdown--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void _onDigitChanged(String value, int index) {
    setState(() {
      _controllers[index].text = value;
      
      // Build OTP string
      _otp = _controllers.map((c) => c.text).join();
      _isValid = _otp.length == 6;
    });

    // Auto-focus next field
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }

    // Auto-verify when all digits entered
    if (_isValid) {
      _handleVerify();
    }
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
                    // SMS Icon
                    _buildSmsIcon(),
                    
                    const SizedBox(height: 30),
                    
                    // Title
                    _buildTitle(),
                    
                    const SizedBox(height: 40),
                    
                    // OTP Input
                    _buildOtpInput(),
                    
                    const SizedBox(height: 30),
                    
                    // Resend Button
                    _buildResendButton(),
                    
                    const SizedBox(height: 40),
                    
                    // Verify Button
                    _buildVerifyButton(),
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
        value: 0.75, // %75 tamamlandı
        backgroundColor: velmaeMint,
        valueColor: AlwaysStoppedAnimation<Color>(velmaeTeal),
      ),
    );
  }

  Widget _buildSmsIcon() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: velmaeMint,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Icon(
        Icons.sms,
        size: 50,
        color: velmaeDarkTeal,
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        Text(
          'SMS Kodunu Girin',
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          _phone != null 
            ? '${_phone} numarasına\ngönderilen 6 haneli kodu girin'
            : 'Telefon numaranıza gönderilen\n6 haneli kodu girin',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildOtpInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(6, (index) {
        return Container(
          width: 45,
          height: 55,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _controllers[index].text.isNotEmpty 
                ? velmaeTeal 
                : Colors.grey.withValues(alpha: 0.3),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              counterText: '',
              contentPadding: EdgeInsets.zero,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChanged: (value) => _onDigitChanged(value, index),
          ),
        );
      }),
    );
  }

  Widget _buildResendButton() {
    return GestureDetector(
      onTap: _countdown == 0 && !_isResending ? _handleResendOtp : null,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Text(
          _countdown > 0 
            ? 'Tekrar gönder ($_countdown s)'
            : _isResending 
              ? 'Gönderiliyor...'
              : 'Tekrar gönder',
          style: TextStyle(
            fontSize: 16,
            color: _countdown == 0 && !_isResending 
              ? velmaeTeal 
              : Colors.grey[500],
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildVerifyButton() {
    return Container(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _isValid ? _handleVerify : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: _isValid ? velmaeTeal : Colors.grey[300],
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        child: Text(
          'Doğrula',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: _isValid ? Colors.white : Colors.grey[500],
          ),
        ),
      ),
    );
  }

  void _handleVerify() async {
    if (!_isValid || _phone == null) return;
    
    HapticFeedback.mediumImpact();
    
    // Show loading
    _showLoadingDialog();
    
    try {
      // Verify OTP
      final response = await SignupService.verifyOtp(_phone!, _otp);
      
      // Hide loading
      Navigator.of(context).pop();
      
      if (response.success) {
        // Get previous data
        final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
        
        // Navigate to password input
        Navigator.pushNamed(
          context,
          '/password-input',
          arguments: args,
        );
      } else {
        _showErrorDialog(response.message);
        _clearOtp();
      }
      
    } catch (e) {
      // Hide loading
      Navigator.of(context).pop();
      
      // Demo mode: accept 123456 as valid OTP
      if (_otp == '123456') {
        // Get previous data
        final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
        
        // Navigate to password input
        Navigator.pushNamed(
          context,
          '/password-input',
          arguments: args,
        );
      } else {
        _showErrorDialog('Demo modu: OTP kodu 123456 olmalı');
        _clearOtp();
      }
    }
  }

  void _handleResendOtp() async {
    if (_phone == null) return;
    
    setState(() {
      _isResending = true;
    });
    
    try {
      final response = await SignupService.sendOtp(_phone!);
      
      if (response.success) {
        _startCountdown();
        _clearOtp();
        _showSuccessMessage('SMS tekrar gönderildi');
      } else {
        _showErrorDialog(response.message);
      }
      
    } catch (e) {
      _showErrorDialog('SMS gönderilemedi. Lütfen tekrar deneyin.');
    } finally {
      setState(() {
        _isResending = false;
      });
    }
  }

  void _clearOtp() {
    setState(() {
      for (var controller in _controllers) {
        controller.clear();
      }
      _otp = '';
      _isValid = false;
    });
    _focusNodes[0].requestFocus();
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
                'Kod doğrulanıyor...',
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
        title: const Text('Hata'),
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

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: velmaeTeal,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
