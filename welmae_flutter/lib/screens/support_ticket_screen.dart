import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app/theme/typography.dart';
import '../app/theme/theme.dart';
import '../app/theme/dimensions.dart';
import '../providers/user_provider.dart';
import '../shared/constants/app_colors.dart';

class SupportTicketScreen extends StatefulWidget {
  const SupportTicketScreen({super.key});

  @override
  State<SupportTicketScreen> createState() => _SupportTicketScreenState();
}

class _SupportTicketScreenState extends State<SupportTicketScreen> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priorityController = TextEditingController();

  String _selectedCategory = 'Genel';
  String _selectedPriority = 'Orta';
  bool _isLoading = false;
  bool _attachScreenshot = false;
  bool _attachLogs = false;

  final List<String> _categories = [
    'Genel',
    'Hesap',
    'Ödemeler',
    'Güvenlik',
    'Teknik',
    'Faturalama',
  ];

  final List<String> _priorities = ['Düşük', 'Orta', 'Yüksek', 'Acil'];

  @override
  void dispose() {
    _subjectController.dispose();
    _descriptionController.dispose();
    _priorityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Destek Talebi',
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
              // Ticket Info
              _buildTicketInfo(),
              const SizedBox(height: 32),

              // Form Fields
              _buildFormFields(),
              const SizedBox(height: 32),

              // Attachments
              _buildAttachments(),
              const SizedBox(height: 32),

              // Submit Button
              _buildSubmitButton(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTicketInfo() {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

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
                  color: AppColors.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.support_agent,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Destek Talebi Oluştur',
                      style: AppTypography.titleMedium.copyWith(
                        color: AppColors.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Ekibimiz en kısa sürede size yardımcı olacak',
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
          Row(
            children: [
              Expanded(
                child: _buildInfoItem(
                  title: 'Kullanıcı ID',
                  value: user?.id ?? 'N/A',
                  icon: Icons.person_outline,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildInfoItem(
                  title: 'E-posta',
                  value: user?.email ?? 'N/A',
                  icon: Icons.email_outlined,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormFields() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Column(
        children: [
          // Category
          _buildFormField(
            title: 'Kategori',
            child: _buildDropdownField(
              value: _selectedCategory,
              items: _categories,
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
            ),
          ),
          const SizedBox(height: 16),

          // Subject
          _buildFormField(
            title: 'Konu',
            child: TextFormField(
              controller: _subjectController,
              decoration: InputDecoration(
                hintText: 'Destek talebinizin konusunu belirtin',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: Icon(Icons.subject, color: AppColors.primary),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Konu gerekli';
                }
                if (value.length < 5) {
                  return 'Konu en az 5 karakter olmalı';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 16),

          // Priority
          _buildFormField(title: 'Öncelik', child: _buildPrioritySelector()),
          const SizedBox(height: 16),

          // Description
          _buildFormField(
            title: 'Açıklama',
            child: TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                hintText: 'Sorun detaylı bir şekilde açıklayın',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: Icon(
                  Icons.description_outlined,
                  color: AppColors.primary,
                ),
              ),
              maxLines: 5,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Açıklama gerekli';
                }
                if (value.length < 10) {
                  return 'Açıklama en az 10 karakter olmalı';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTypography.bodyLarge.copyWith(
            color: AppColors.onSurface,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  Widget _buildDropdownField({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Row(
        children: [
          Expanded(
            child: DropdownButton<String>(
              value: value,
              underline: Container(),
              isExpanded: true,
              items: items.map((String item) {
                return DropdownMenuItem<String>(value: item, child: Text(item));
              }).toList(),
              onChanged: onChanged,
            ),
          ),
          Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.onSurfaceVariant,
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildPrioritySelector() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _priorities.length,
        itemBuilder: (context, index) {
          final priority = _priorities[index];
          final isSelected = _selectedPriority == priority;
          final color = _getPriorityColor(priority);

          return Container(
            margin: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(
                priority,
                style: AppTypography.bodySmall.copyWith(
                  color: isSelected ? AppColors.onPrimary : color,
                ),
              ),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedPriority = priority;
                });
              },
              backgroundColor: isSelected ? color : AppColors.surfaceVariant,
              selectedColor: color,
              checkmarkColor: AppColors.onPrimary,
            ),
          );
        },
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'Düşük':
        return AppColors.outlineVariant;
      case 'Orta':
        return AppColors.primary;
      case 'Yüksek':
        return Colors.orange;
      case 'Acil':
        return AppColors.error;
      default:
        return AppColors.primary;
    }
  }

  Widget _buildAttachments() {
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
            'Ekler',
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.onSurface,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),

          // Screenshot
          _buildAttachmentOption(
            title: 'Ekran Görüntüsü',
            subtitle: 'Sorunla ilgili ekran görüntüsü ekle',
            icon: Icons.screenshot_outlined,
            value: _attachScreenshot,
            onChanged: (value) {
              setState(() {
                _attachScreenshot = value;
              });
            },
          ),
          const SizedBox(height: 12),

          // Logs
          _buildAttachmentOption(
            title: 'Log Dosyaları',
            subtitle: 'Sistem log dosyalarını ekle',
            icon: Icons.file_present_outlined,
            value: _attachLogs,
            onChanged: (value) {
              setState(() {
                _attachLogs = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAttachmentOption({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
      title: Text(
        title,
        style: AppTypography.bodyLarge.copyWith(color: AppColors.onSurface),
      ),
      subtitle: Text(
        subtitle,
        style: AppTypography.bodySmall.copyWith(
          color: AppColors.onSurfaceVariant,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeThumbColor: AppColors.primary,
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _submitTicket,
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
                'Talebi Gönder',
                style: AppTypography.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }

  Future<void> _submitTicket() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate ticket submission
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        // Clear form
        _subjectController.clear();
        _descriptionController.clear();
        setState(() {
          _selectedCategory = 'Genel';
          _selectedPriority = 'Orta';
          _attachScreenshot = false;
          _attachLogs = false;
        });

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Destek talebiniz başarıyla oluşturuldu!',
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
