import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../../providers/auth_provider.dart';

class NewOtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  final String otpId;
  final DateTime expiresAt;

  const NewOtpVerificationScreen({
    super.key,
    required this.phoneNumber,
    required this.otpId,
    required this.expiresAt,
  });

  @override
  State<NewOtpVerificationScreen> createState() =>
      _NewOtpVerificationScreenState();
}

class _NewOtpVerificationScreenState extends State<NewOtpVerificationScreen>
    with TickerProviderStateMixin {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  late AnimationController _animationController;
  late AnimationController _shakeController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _shakeAnimation;

  bool _isLoading = false;
  bool _canResend = false;
  Timer? _timer;
  int _remainingSeconds = 300; // 5 minutes

  // Velmae Brand Colors
  static const Color velmaeTeal = Color(0xFF03A6A6);
  static const Color velmaeDarkTeal = Color(0xFF027d7d);
  static const Color velmaeLightTeal = Color(0xFF05D1D1);
  static const Color velmaeMint = Color(0xFF10B981);
  static const Color surfaceWhite = Color(0xFFFFFFFF);
  static const Color backgroundColor = Color(0xFFF9FAFB);
  static const Color textDark = Color(0xFF111827);
  static const Color textMedium = Color(0xFF6B7280);
  static const Color textLight = Color(0xFF9CA3AF);
  static const Color borderLight = Color(0xFFE5E7EB);
  static const Color errorRed = Color(0xFFDC2626);
  static const Color successGreen = Color(0xFF059669);

  String get _otpCode => _controllers.map((c) => c.text).join();

  String get _formattedTime {
    final minutes = _remainingSeconds ~/ 60;
    final seconds = _remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startTimer();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 1.0, curve: Curves.elasticOut),
      ),
    );

    _shakeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticOut),
    );

    _animationController.forward();
  }

  void _startTimer() {
    final now = DateTime.now();
    final difference = widget.expiresAt.difference(now);
    _remainingSeconds = difference.inSeconds > 0 ? difference.inSeconds : 300;

    if (_remainingSeconds > 0) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (mounted) {
          setState(() {
            if (_remainingSeconds > 0) {
              _remainingSeconds--;
            } else {
              _canResend = true;
              timer.cancel();
            }
          });
        }
      });
    } else {
      setState(() {
        _canResend = true;
      });
    }
  }

  void _onDigitChanged(String value, int index) {
    if (value.length == 1) {
      if (index < 5) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
      }
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }

    // Auto-verify when all digits are entered
    if (_otpCode.length == 6) {
      _verifyOtp();
    }
  }

  Future<void> _verifyOtp() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        // Navigate to home screen after successful verification
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home',
          (route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        _shakeController.forward().then((_) {
          _shakeController.reverse();
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Hata: $e'),
            backgroundColor: errorRed,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _resendOtp() async {
    if (!_canResend || _isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      if (mounted) {
        setState(() {
          _canResend = false;
          _remainingSeconds = 300;
        });

        _startTimer();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Doğrulama kodu yeniden gönderildi'),
            backgroundColor: successGreen,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Hata: $e'),
            backgroundColor: errorRed,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _shakeController.dispose();
    _timer?.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(32.0),
                child: Transform.translate(
                  offset: Offset(0, _slideAnimation.value),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),

                      // Header Section
                      _buildHeaderSection(),

                      const SizedBox(height: 60),

                      // OTP Input Section
                      _buildOtpInputSection(),

                      const SizedBox(height: 40),

                      // Timer Section
                      _buildTimerSection(),

                      const SizedBox(height: 40),

                      // Continue Button
                      _buildContinueButton(),

                      const SizedBox(height: 40),

                      // Change Phone Link
                      _buildChangePhoneLink(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Back button
        Container(
          decoration: BoxDecoration(
            color: surfaceWhite,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                offset: const Offset(0, 2),
                blurRadius: 8,
              ),
            ],
          ),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new, size: 20),
            color: textDark,
          ),
        ),

        const SizedBox(height: 32),

        // Title
        const Text(
          'Doğrulama Kodu',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: textDark,
            height: 1.2,
          ),
        ),

        const SizedBox(height: 16),

        // Subtitle
        Text(
          '${widget.phoneNumber} numarasına gönderilen 6 haneli kodu girin',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: textMedium,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildOtpInputSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Doğrulama Kodu',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: textDark,
          ),
        ),
        const SizedBox(height: 16),
        AnimatedBuilder(
          animation: _shakeAnimation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(_shakeAnimation.value * 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, (index) {
                  return Container(
                    width: 50,
                    height: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: surfaceWhite,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _focusNodes[index].hasFocus
                            ? velmaeTeal
                            : _controllers[index].text.isNotEmpty
                            ? successGreen
                            : borderLight,
                        width: _focusNodes[index].hasFocus ||
                                _controllers[index].text.isNotEmpty
                            ? 2
                            : 1,
                      ),
                      boxShadow: [
                        if (_focusNodes[index].hasFocus)
                          BoxShadow(
                            color: velmaeTeal.withValues(alpha: 0.12),
                            offset: const Offset(0, 4),
                            blurRadius: 16,
                          ),
                      ],
                    ),
                    child: TextFormField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (value) => _onDigitChanged(value, index),
                      onTap: () {
                        _controllers[index].selection = TextSelection.fromPosition(
                          TextPosition(offset: _controllers[index].text.length),
                        );
                      },
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: textDark,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        counterText: '',
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  );
                }),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTimerSection() {
    return Column(
      children: [
        if (!_canResend) ...[
          Text(
            'Kodu yeniden gönderebilirsiniz: $_formattedTime',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: textMedium,
            ),
            textAlign: TextAlign.center,
          ),
        ] else ...[
          GestureDetector(
            onTap: _resendOtp,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: velmaeTeal.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: velmaeTeal.withValues(alpha: 0.3)),
              ),
              child: const Text(
                'Kodu yeniden gönder',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: velmaeTeal,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildContinueButton() {
    final isOtpComplete = _otpCode.length == 6;

    return Container(
      height: 56,
      decoration: BoxDecoration(
        gradient: isOtpComplete
            ? const LinearGradient(
                colors: [velmaeTeal, velmaeMint],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )
            : null,
        color: isOtpComplete ? null : borderLight,
        borderRadius: BorderRadius.circular(16),
        boxShadow: isOtpComplete
            ? [
                BoxShadow(
                  color: velmaeTeal.withValues(alpha: 0.3),
                  offset: const Offset(0, 8),
                  blurRadius: 24,
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isOtpComplete && !_isLoading ? _verifyOtp : null,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            alignment: Alignment.center,
            child: _isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  )
                : Text(
                    'Doğrula',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: isOtpComplete ? Colors.white : textLight,
                      letterSpacing: 0.5,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildChangePhoneLink() {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        Navigator.pop(context);
      },
      child: const Text(
        'Telefon numarasını değiştir',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: velmaeTeal,
          decoration: TextDecoration.underline,
          decorationColor: velmaeTeal,
        ),
      ),
    );
  }
}
