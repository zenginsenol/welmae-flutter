import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/signup_service.dart';

class BioInputScreen extends StatefulWidget {
  const BioInputScreen({super.key});

  @override
  State<BioInputScreen> createState() => _BioInputScreenState();
}

class _BioInputScreenState extends State<BioInputScreen> {
  final TextEditingController _bioController = TextEditingController();
  bool _canSkip = true; // Bio is optional
  
  // Velmae Brand Colors
  static const Color velmaeTeal = Color(0xFF03A6A6);
  static const Color velmaeLightTeal = Color(0xFFEBFEFE);
  static const Color velmaeDarkTeal = Color(0xFF013C3C);
  static const Color velmaeMint = Color(0xFFB8E6E6);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _bioController.dispose();
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
                    // Bio Icon
                    _buildBioIcon(),
                    
                    const SizedBox(height: 30),
                    
                    // Title
                    _buildTitle(),
                    
                    const SizedBox(height: 40),
                    
                    // Bio Input
                    _buildBioInput(),
                    
                    const SizedBox(height: 20),
                    
                    // Character Counter
                    _buildCharacterCounter(),
                    
                    const SizedBox(height: 40),
                    
                    // Action Buttons
                    _buildActionButtons(),
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
        value: 1.0, // %100 tamamlandı
        backgroundColor: velmaeMint,
        valueColor: AlwaysStoppedAnimation<Color>(velmaeTeal),
      ),
    );
  }

  Widget _buildBioIcon() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: velmaeMint,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Icon(
        Icons.edit,
        size: 50,
        color: velmaeDarkTeal,
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        Text(
          'Kendinizi tanıtın',
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'İsteğe bağlı: Diğer kullanıcıların\nsizi daha iyi tanıyabilmesi için',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildBioInput() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.3),
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
        controller: _bioController,
        maxLines: 5,
        maxLength: 150,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          hintText: 'Seyahat etmeyi seviyorum, yeni kültürler keşfetmek benim tutkum...',
          hintStyle: TextStyle(
            fontSize: 16,
            color: Colors.grey[400],
          ),
          border: InputBorder.none,
          counterText: '', // Hide default counter
          contentPadding: const EdgeInsets.all(20),
        ),
        textCapitalization: TextCapitalization.sentences,
        onChanged: (value) {
          setState(() {
            // Update UI if needed
          });
        },
      ),
    );
  }

  Widget _buildCharacterCounter() {
    final currentLength = _bioController.text.length;
    const maxLength = 150;
    
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        '$currentLength/$maxLength',
        style: TextStyle(
          fontSize: 12,
          color: currentLength > maxLength ? Colors.red : Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        // Continue Button
        Container(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: _handleContinue,
            style: ElevatedButton.styleFrom(
              backgroundColor: velmaeTeal,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
            ),
            child: const Text(
              'Hesabı Oluştur',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Skip Button
        if (_canSkip)
          GestureDetector(
            onTap: _handleSkip,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'Atla',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
      ],
    );
  }

  void _handleContinue() {
    HapticFeedback.mediumImpact();
    _completeSignup(bio: _bioController.text.trim());
  }

  void _handleSkip() {
    HapticFeedback.lightImpact();
    _completeSignup(bio: null);
  }

  void _completeSignup({String? bio}) async {
    // Get all previous data
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    
    if (args == null) {
      _showErrorDialog('Eksik bilgiler. Lütfen tekrar deneyin.');
      return;
    }
    
    try {
      // Show loading
      _showLoadingDialog();
      
      // Call backend API
      final response = await SignupService.completeSignup(
        name: args['name'] ?? '',
        email: args['email'] ?? '',
        phone: args['phone'] ?? '',
        password: args['password'] ?? '',
        country: args['country'] ?? '',
        city: args['city'] ?? '',
        birthdate: args['birthdate'] ?? '',
        bio: bio,
      );
      
      // Hide loading
      Navigator.of(context).pop();
      
      if (response.success) {
        // Navigate to success screen
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/signup-success',
          (route) => false,
          arguments: {
            'user': response.user?.toJson(),
            'token': response.token,
          },
        );
      } else {
        // Show error from backend
        _showErrorDialog(response.message);
      }
      
    } catch (e) {
      // Hide loading
      Navigator.of(context).pop();
      
      // Show error
      _showErrorDialog('Hesap oluşturulurken bir hata oluştu. Lütfen tekrar deneyin.');
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
                'Hesabınız oluşturuluyor...',
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
}
