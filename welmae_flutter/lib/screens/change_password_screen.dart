import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app/theme/typography.dart';
import '../app/theme/theme.dart';
import '../app/theme/dimensions.dart';
import '../app/theme/colors.dart';
import '../providers/user_provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Şifre Değiştir',
          style: AppTypography.titleLarge.copyWith(color: AppColors.onSurface),
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Security Info
              _buildSecurityInfo(),
              const SizedBox(height: 32),

              // Password Form
              _buildPasswordForm(),
              const SizedBox(height: 32),

              // Password Requirements
              _buildPasswordRequirements(),
              const SizedBox(height: 32),

              // Change Password Button
              _buildChangePasswordButton(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSecurityInfo() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.errorContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.lock, color: AppColors.error, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Şifre Güvenliği',
                      style: AppTypography.titleMedium.copyWith(
                        color: AppColors.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Şifrenizi düzenli olarak güncelleyin',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Son şifre değiştirme: 3 ay önce',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordForm() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Column(
        children: [
          // Current Password
          _buildPasswordField(
            controller: _currentPasswordController,
            labelText: 'Mevcut Şifre',
            icon: Icons.lock_outline,
            obscureText: _obscureCurrentPassword,
            onToggle: () {
              setState(() {
                _obscureCurrentPassword = !_obscureCurrentPassword;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Mevcut şifre gerekli';
              }
              if (value.length < 6) {
                return 'Şifre en az 6 karakter olmalı';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // New Password
          _buildPasswordField(
            controller: _newPasswordController,
            labelText: 'Yeni Şifre',
            icon: Icons.lock_reset_outlined,
            obscureText: _obscureNewPassword,
            onToggle: () {
              setState(() {
                _obscureNewPassword = !_obscureNewPassword;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Yeni şifre gerekli';
              }
              if (value.length < 8) {
                return 'Şifre en az 8 karakter olmalı';
              }
              if (!RegExp(r'(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(value)) {
                return 'Şifre en az bir büyük harf, bir küçük harf ve bir rakam içermeli';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Confirm Password
          _buildPasswordField(
            controller: _confirmPasswordController,
            labelText: 'Yeni Şifreyi Onayla',
            icon: Icons.lock_outline,
            obscureText: _obscureConfirmPassword,
            onToggle: () {
              setState(() {
                _obscureConfirmPassword = !_obscureConfirmPassword;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Şifre onayı gerekli';
              }
              if (value != _newPasswordController.text) {
                return 'Şifreler eşleşmiyor';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    required bool obscureText,
    required VoidCallback onToggle,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        prefixIcon: Icon(icon, color: AppColors.primary),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
            color: AppColors.onSurfaceVariant,
          ),
          onPressed: onToggle,
        ),
      ),
      validator: validator,
    );
  }

  Widget _buildPasswordRequirements() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Şifre Gereksinimleri',
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),

          // Requirements List
          _buildRequirementItem(
            text: 'En az 8 karakter uzunluğunda olmalı',
            isValid: _newPasswordController.text.length >= 8,
          ),
          const SizedBox(height: 8),
          _buildRequirementItem(
            text: 'En az bir büyük harf içermeli',
            isValid: RegExp(r'[A-Z]').hasMatch(_newPasswordController.text),
          ),
          const SizedBox(height: 8),
          _buildRequirementItem(
            text: 'En az bir küçük harf içermeli',
            isValid: RegExp(r'[a-z]').hasMatch(_newPasswordController.text),
          ),
          const SizedBox(height: 8),
          _buildRequirementItem(
            text: 'En az bir rakam içermeli',
            isValid: RegExp(r'\d').hasMatch(_newPasswordController.text),
          ),
          const SizedBox(height: 8),
          _buildRequirementItem(
            text: 'Önceki şifreden farklı olmalı',
            isValid:
                _newPasswordController.text.isNotEmpty &&
                _newPasswordController.text != _currentPasswordController.text,
          ),
        ],
      ),
    );
  }

  Widget _buildRequirementItem({required String text, required bool isValid}) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check_circle : Icons.circle_outlined,
          color: isValid ? AppColors.primary : AppColors.onSurfaceVariant,
          size: 16,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: AppTypography.bodySmall.copyWith(
              color: isValid ? AppColors.primary : AppColors.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChangePasswordButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _changePassword,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: _isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
                'Şifreyi Değiştir',
                style: AppTypography.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }

  Future<void> _changePassword() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate password change
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        // Update user password
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser({'password': _newPasswordController.text});

        // Clear form
        _currentPasswordController.clear();
        _newPasswordController.clear();
        _confirmPasswordController.clear();

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Şifre başarıyla değiştirildi!',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.onSurface,
              ),
            ),
            backgroundColor: AppColors.primary,
          ),
        );

        // Navigate back
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Bir hata oluştu: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }
}
