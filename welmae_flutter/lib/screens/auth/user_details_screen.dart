import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../shared/components/buttons/primary_button.dart';
import '../../shared/components/inputs/text_input.dart';
import '../../app/theme/theme.dart';
import '../../app/theme/typography.dart';
import '../main.dart';

class UserDetailsScreen extends StatefulWidget {
  final String phoneNumber;
  final bool isNewUser;

  const UserDetailsScreen({
    super.key,
    required this.phoneNumber,
    required this.isNewUser,
  });

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _locationController = TextEditingController();

  String? _selectedGender;
  bool _isLoading = false;

  final List<Map<String, String>> _genderOptions = [
    {'value': 'male', 'label': 'Erkek'},
    {'value': 'female', 'label': 'Kadın'},
    {'value': 'other', 'label': 'Diğer'},
    {'value': 'prefer_not_to_say', 'label': 'Belirtmek istemiyorum'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),

                // Progress indicator
                LinearProgressIndicator(
                  value: 0.8, // 80% complete
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.outline.withValues(alpha: 0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.primary,
                  ),
                ),

                const SizedBox(height: 40),

                // Title
                Text(
                  widget.isNewUser
                      ? 'Profilinizi Tamamlayın'
                      : 'Bilgilerinizi Güncelleyin',
                  style: AppTypography.headlineMedium.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                // Subtitle
                Text(
                  'Size daha iyi hizmet verebilmek için birkaç bilgiye daha ihtiyacımız var.',
                  style: AppTypography.bodyLarge.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),

                const SizedBox(height: 32),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // First Name
                        TextInput(
                          controller: _firstNameController,
                          label: 'Ad *',
                          hint: 'Adınızı girin',
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Ad gereklidir';
                            }
                            if (value.trim().length < 2) {
                              return 'Ad en az 2 karakter olmalıdır';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 20),

                        // Last Name
                        TextInput(
                          controller: _lastNameController,
                          label: 'Soyad *',
                          hint: 'Soyadınızı girin',
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Soyad gereklidir';
                            }
                            if (value.trim().length < 2) {
                              return 'Soyad en az 2 karakter olmalıdır';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 20),

                        // Gender Selection
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Cinsiyet',
                              style: AppTypography.bodyMedium.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.outline.withValues(alpha: 0.3),
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                children: _genderOptions.map((option) {
                                  final isSelected =
                                      _selectedGender == option['value'];
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedGender = option['value'];
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 16,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                                  .withValues(alpha: 0.1)
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            isSelected
                                                ? Icons.radio_button_checked
                                                : Icons.radio_button_unchecked,
                                            color: isSelected
                                                ? Theme.of(
                                                    context,
                                                  ).colorScheme.primary
                                                : Theme.of(
                                                    context,
                                                  ).colorScheme.outline,
                                          ),
                                          const SizedBox(width: 12),
                                          Text(
                                            option['label']!,
                                            style: AppTypography.bodyMedium
                                                .copyWith(
                                                  color: isSelected
                                                      ? Theme.of(
                                                          context,
                                                        ).colorScheme.primary
                                                      : Theme.of(
                                                          context,
                                                        ).colorScheme.onSurface,
                                                  fontWeight: isSelected
                                                      ? FontWeight.w600
                                                      : FontWeight.normal,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Location
                        TextInput(
                          controller: _locationController,
                          label: 'Konum',
                          hint: 'Şehir, Ülke',
                          suffixIcon: const Icon(Icons.location_on_outlined),
                        ),

                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),

                // Complete button
                PrimaryButton(
                  text: 'Tamamla',
                  onPressed: _isLoading ? null : _completeOnboarding,
                  isLoading: _isLoading,
                ),

                const SizedBox(height: 16),

                // Skip button (only for optional fields)
                if (!widget.isNewUser)
                  Center(
                    child: TextButton(
                      onPressed: _skipToMain,
                      child: Text(
                        'Şimdilik Geç',
                        style: AppTypography.bodyMedium.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _completeOnboarding() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      final result = await authProvider.updateUserProfile(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        gender: _selectedGender,
        location: _locationController.text.trim().isEmpty
            ? null
            : _locationController.text.trim(),
      );

      if (result.success && mounted) {
        // Navigate to main app
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.error ?? 'Profil güncellenirken hata oluştu'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
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

  void _skipToMain() {
    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _locationController.dispose();
    super.dispose();
  }
}
