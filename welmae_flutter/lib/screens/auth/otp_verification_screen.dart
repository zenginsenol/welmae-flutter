import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../../shared/components/buttons/primary_button.dart';
import '../../providers/auth_provider.dart';
import '../../app/theme/theme.dart';
import '../../app/theme/typography.dart';
import 'user_details_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  final String otpId;
  final DateTime expiresAt;

  const OtpVerificationScreen({
    super.key,
    required this.phoneNumber,
    required this.otpId,
    required this.expiresAt,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _otpController = TextEditingController();
  String _currentText = '';
  bool _isLoading = false;
  bool _canResend = false;
  Timer? _timer;
  int _remainingSeconds = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    final now = DateTime.now();
    final difference = widget.expiresAt.difference(now);
    _remainingSeconds = difference.inSeconds > 0 ? difference.inSeconds : 0;

    if (_remainingSeconds > 0) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _remainingSeconds--;
          if (_remainingSeconds <= 0) {
            _canResend = true;
            timer.cancel();
          }
        });
      });
    } else {
      setState(() {
        _canResend = true;
      });
    }
  }

  String get _formattedTime {
    final minutes = _remainingSeconds ~/ 60;
    final seconds = _remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),

              // Back button
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Theme.of(
                        context,
                      ).colorScheme.outline.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: Theme.of(context).colorScheme.onSurface,
                    size: 20,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Title
              Text(
                'Doğrulama Kodu',
                style: AppTypography.headlineMedium.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              // Subtitle
              RichText(
                text: TextSpan(
                  style: AppTypography.bodyLarge.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                  children: [
                    const TextSpan(
                      text: 'Size gönderilen 6 haneli kodu girin:\n',
                    ),
                    TextSpan(
                      text: widget.phoneNumber,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // OTP Input
              PinCodeTextField(
                appContext: context,
                length: 6,
                controller: _otpController,
                onChanged: (value) {
                  setState(() {
                    _currentText = value;
                  });
                },
                onCompleted: (value) {
                  _verifyOtp();
                },
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(12),
                  fieldHeight: 60,
                  fieldWidth: 50,
                  activeFillColor: Theme.of(context).colorScheme.surface,
                  inactiveFillColor: Theme.of(context).colorScheme.surface,
                  selectedFillColor: Theme.of(context).colorScheme.surface,
                  activeColor: Theme.of(context).colorScheme.primary,
                  inactiveColor: Theme.of(
                    context,
                  ).colorScheme.outline.withValues(alpha: 0.3),
                  selectedColor: Theme.of(context).colorScheme.primary,
                ),
                enableActiveFill: true,
                keyboardType: TextInputType.number,
                textStyle: AppTypography.headlineSmall.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 30),

              // Timer and resend
              Center(
                child: Column(
                  children: [
                    if (!_canResend) ...[
                      Text(
                        'Kodu yeniden gönder: $_formattedTime',
                        style: AppTypography.bodyMedium.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                    ] else ...[
                      GestureDetector(
                        onTap: _resendOtp,
                        child: Text(
                          'Kodu yeniden gönder',
                          style: AppTypography.bodyMedium.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Verify button
              PrimaryButton(
                text: 'Doğrula',
                onPressed: (_isLoading || _currentText.length != 6)
                    ? null
                    : _verifyOtp,
                isLoading: _isLoading,
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _verifyOtp() async {
    if (_currentText.length != 6) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      final result = await authProvider.verifyOtpAndAuth(
        phone: widget.phoneNumber,
        code: _currentText,
      );

      if (result.success && mounted) {
        final authResult = result.data!;

        if (authResult.requiresOnboarding) {
          // Navigate to user details screen for new users
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => UserDetailsScreen(
                phoneNumber: widget.phoneNumber,
                isNewUser: authResult.isNewUser,
              ),
            ),
          );
        } else {
          // Navigate to main app for existing users
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        }
      } else if (mounted) {
        // Show error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.error ?? 'Doğrulama kodu hatalı'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );

        // Clear the input
        _otpController.clear();
        setState(() {
          _currentText = '';
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Beklenmeyen bir hata oluştu: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
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
    if (!_canResend) return;

    setState(() {
      _canResend = false;
      _isLoading = true;
    });

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      final result = await authProvider.requestOtp(widget.phoneNumber);

      if (result.success && mounted) {
        // Restart timer
        _timer?.cancel();
        _startTimer();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Doğrulama kodu yeniden gönderildi'),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );
      } else if (mounted) {
        setState(() {
          _canResend = true;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.error ?? 'Kod yeniden gönderilemedi'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _canResend = true;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Beklenmeyen bir hata oluştu: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
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
    _timer?.cancel();
    _otpController.dispose();
    super.dispose();
  }
}
