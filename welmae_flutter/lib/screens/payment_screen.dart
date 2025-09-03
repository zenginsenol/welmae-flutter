import 'package:flutter/material.dart';
import '../app/theme/typography.dart';
import '../app/theme/dimensions.dart';

class PaymentScreen extends StatefulWidget {
  final String destinationName;
  final double amount;
  final String currency;

  const PaymentScreen({
    super.key,
    required this.destinationName,
    required this.amount,
    this.currency = 'TRY',
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _nameController = TextEditingController();

  String _selectedPaymentMethod = 'credit_card';
  bool _isProcessing = false;

  final List<PaymentMethod> _paymentMethods = [
    PaymentMethod(
      id: 'credit_card',
      name: 'Kredi Kartı',
      icon: Icons.credit_card,
      description: 'Visa, Mastercard, American Express',
    ),
    PaymentMethod(
      id: 'bank_transfer',
      name: 'Banka Transferi',
      icon: Icons.account_balance,
      description: 'EFT/Havale ile ödeme',
    ),
    PaymentMethod(
      id: 'digital_wallet',
      name: 'Dijital Cüzdan',
      icon: Icons.account_balance_wallet,
      description: 'PayPal, Apple Pay, Google Pay',
    ),
  ];

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ödeme',
          style: AppTypography.titleLarge.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.pagePadding,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ödeme Özeti
              _buildPaymentSummary(theme),
              const SizedBox(height: AppSpacing.xl),

              // Ödeme Yöntemi Seçimi
              _buildPaymentMethodSelection(theme),
              const SizedBox(height: AppSpacing.xl),

              // Ödeme Formu
              if (_selectedPaymentMethod == 'credit_card') ...[
                _buildCreditCardForm(theme),
                const SizedBox(height: AppSpacing.xl),
              ],

              // Ödeme Butonu
              _buildPaymentButton(theme),
              const SizedBox(height: AppSpacing.lg),

              // Güvenlik Bilgisi
              _buildSecurityInfo(theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentSummary(ThemeData theme) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ödeme Özeti',
              style: AppTypography.titleMedium.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Destinasyon:',
                  style: AppTypography.bodyMedium.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  widget.destinationName,
                  style: AppTypography.bodyMedium.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tutar:',
                  style: AppTypography.bodyMedium.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  '${widget.amount.toStringAsFixed(2)} ${widget.currency}',
                  style: AppTypography.titleMedium.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Komisyon:',
                  style: AppTypography.bodyMedium.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  '${(widget.amount * 0.03).toStringAsFixed(2)} ${widget.currency}',
                  style: AppTypography.bodyMedium.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const Divider(height: AppSpacing.lg),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Toplam:',
                  style: AppTypography.titleMedium.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${(widget.amount * 1.03).toStringAsFixed(2)} ${widget.currency}',
                  style: AppTypography.titleLarge.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodSelection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ödeme Yöntemi',
          style: AppTypography.titleMedium.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        ..._paymentMethods.map(
          (method) => _buildPaymentMethodTile(method, theme),
        ),
      ],
    );
  }

  Widget _buildPaymentMethodTile(PaymentMethod method, ThemeData theme) {
    final isSelected = _selectedPaymentMethod == method.id;

    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      elevation: isSelected ? 3 : 1,
      color: isSelected
          ? theme.colorScheme.primaryContainer
          : theme.colorScheme.surface,
      child: RadioListTile<String>(
        value: method.id,
        groupValue: _selectedPaymentMethod,
        onChanged: (value) {
          setState(() {
            _selectedPaymentMethod = value!;
          });
        },
        title: Row(
          children: [
            Icon(
              method.icon,
              color: isSelected
                  ? theme.colorScheme.onPrimaryContainer
                  : theme.colorScheme.primary,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    method.name,
                    style: AppTypography.bodyLarge.copyWith(
                      color: isSelected
                          ? theme.colorScheme.onPrimaryContainer
                          : theme.colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    method.description,
                    style: AppTypography.bodySmall.copyWith(
                      color: isSelected
                          ? theme.colorScheme.onPrimaryContainer.withValues(
                              alpha: 0.8,
                            )
                          : theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        activeColor: theme.colorScheme.primary,
      ),
    );
  }

  Widget _buildCreditCardForm(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kart Bilgileri',
          style: AppTypography.titleMedium.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // Kart Numarası
        TextFormField(
          controller: _cardNumberController,
          decoration: InputDecoration(
            labelText: 'Kart Numarası',
            hintText: '1234 5678 9012 3456',
            prefixIcon: Icon(
              Icons.credit_card,
              color: theme.colorScheme.primary,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            ),
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Kart numarası gerekli';
            }
            if (value.replaceAll(' ', '').length != 16) {
              return 'Geçerli kart numarası girin';
            }
            return null;
          },
        ),
        const SizedBox(height: AppSpacing.md),

        // Kart Sahibi Adı
        TextFormField(
          controller: _nameController,
          decoration: InputDecoration(
            labelText: 'Kart Sahibi Adı',
            hintText: 'Ad Soyad',
            prefixIcon: Icon(Icons.person, color: theme.colorScheme.primary),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Kart sahibi adı gerekli';
            }
            return null;
          },
        ),
        const SizedBox(height: AppSpacing.md),

        // Son Kullanma Tarihi ve CVV
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _expiryController,
                decoration: InputDecoration(
                  labelText: 'Son Kullanma',
                  hintText: 'MM/YY',
                  prefixIcon: Icon(
                    Icons.calendar_today,
                    color: theme.colorScheme.primary,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Son kullanma tarihi gerekli';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: TextFormField(
                controller: _cvvController,
                decoration: InputDecoration(
                  labelText: 'CVV',
                  hintText: '123',
                  prefixIcon: Icon(
                    Icons.security,
                    color: theme.colorScheme.primary,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'CVV gerekli';
                  }
                  if (value.length != 3) {
                    return 'Geçerli CVV girin';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentButton(ThemeData theme) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _isProcessing ? null : _processPayment,
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          ),
        ),
        child: _isProcessing
            ? const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              )
            : Text(
                '${(widget.amount * 1.03).toStringAsFixed(2)} ${widget.currency} Öde',
                style: AppTypography.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }

  Widget _buildSecurityInfo(ThemeData theme) {
    return Card(
      elevation: 1,
      color: theme.colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            Icon(Icons.security, color: theme.colorScheme.primary, size: 20),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                'Ödeme bilgileriniz SSL ile şifrelenir ve güvenle saklanır.',
                style: AppTypography.bodySmall.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _processPayment() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    // Simüle edilmiş ödeme işlemi
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isProcessing = false;
    });

    if (mounted) {
      _showPaymentSuccessDialog();
    }
  }

  void _showPaymentSuccessDialog() {
    final theme = Theme.of(context);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check,
                color: theme.colorScheme.onPrimary,
                size: 32,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Ödeme Başarılı!',
              style: AppTypography.titleLarge.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Seyahatiniz başarıyla rezerve edildi. Onay e-postası gönderildi.',
              style: AppTypography.bodyMedium.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Ödeme ekranından çık
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
              ),
              child: const Text('Tamam'),
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentMethod {
  final String id;
  final String name;
  final IconData icon;
  final String description;

  const PaymentMethod({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
  });
}
