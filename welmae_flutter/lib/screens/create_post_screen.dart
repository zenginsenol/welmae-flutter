import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../app/theme/typography.dart';
import '../app/theme/dimensions.dart';

import '../services/sound_haptic_service.dart';

class CreatePostScreen extends StatefulWidget {
  final String? travelId;
  final String? initialContent;

  const CreatePostScreen({super.key, this.travelId, this.initialContent});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _formKey = GlobalKey<FormState>();
  final _contentController = TextEditingController();
  final _locationController = TextEditingController();
  final _tagController = TextEditingController();

  final List<File> _selectedImages = [];
  final List<File> _selectedVideos = [];
  final List<String> _tags = [];
  final List<String> _selectedActivities = [];
  String _selectedMood = 'Happy';
  bool _isPublic = true;
  bool _isLoading = false;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    if (widget.initialContent != null) {
      _contentController.text = widget.initialContent!;
    }
  }

  @override
  void dispose() {
    _contentController.dispose();
    _locationController.dispose();
    _tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Yeni Post',
          style: AppTypography.titleLarge.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: theme.colorScheme.onSurface),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _handleCreatePost,
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(
                    'Paylaş',
                    style: AppTypography.bodyLarge.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.pagePadding,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Content Input
                _buildContentInput(theme),
                const SizedBox(height: AppSpacing.lg),

                // Media Selection
                _buildMediaSelection(theme),
                const SizedBox(height: AppSpacing.lg),

                // Location Input
                _buildLocationInput(theme),
                const SizedBox(height: AppSpacing.lg),

                // Tags Input
                _buildTagsInput(theme),
                const SizedBox(height: AppSpacing.lg),

                // Activities Selection
                _buildActivitiesSelection(theme),
                const SizedBox(height: AppSpacing.lg),

                // Mood Selection
                _buildMoodSelection(theme),
                const SizedBox(height: AppSpacing.lg),

                // Privacy Settings
                _buildPrivacySettings(theme),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContentInput(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Seyahat Deneyiminizi Paylaşın',
          style: AppTypography.titleMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        TextFormField(
          controller: _contentController,
          maxLines: 6,
          maxLength: 1000,
          decoration: InputDecoration(
            hintText:
                'Seyahatinizde neler yaşadınız? Hangi yerleri gördünüz? Deneyimlerinizi paylaşın...',
            hintStyle: AppTypography.bodyMedium.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
              borderSide: BorderSide(
                color: theme.colorScheme.outline.withValues(alpha: 0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
              borderSide: BorderSide(
                color: theme.colorScheme.primary,
                width: 2,
              ),
            ),
            filled: true,
            fillColor: theme.colorScheme.surface,
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'İçerik gerekli';
            }
            if (value.trim().length < 10) {
              return 'En az 10 karakter yazın';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildMediaSelection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Medya Ekle',
          style: AppTypography.titleMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),

        // Selected Media Display
        if (_selectedImages.isNotEmpty || _selectedVideos.isNotEmpty)
          SizedBox(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ..._selectedImages.map((image) => _buildMediaItem(image, true)),
                ..._selectedVideos.map(
                  (video) => _buildMediaItem(video, false),
                ),
              ],
            ),
          ),

        const SizedBox(height: AppSpacing.sm),

        // Media Selection Buttons
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _pickImages,
                icon: const Icon(Icons.photo_library),
                label: const Text('Fotoğraflar'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: theme.colorScheme.primary,
                  side: BorderSide(color: theme.colorScheme.primary),
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _pickVideos,
                icon: const Icon(Icons.videocam),
                label: const Text('Videolar'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: theme.colorScheme.primary,
                  side: BorderSide(color: theme.colorScheme.primary),
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMediaItem(File file, bool isImage) {
    return Container(
      width: 100,
      height: 100,
      margin: const EdgeInsets.only(right: AppSpacing.sm),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            child: isImage
                ? Image.file(file, fit: BoxFit.cover, width: 100, height: 100)
                : Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey[200],
                    child: const Icon(
                      Icons.videocam,
                      size: 40,
                      color: Colors.grey,
                    ),
                  ),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: GestureDetector(
              onTap: () => _removeMedia(file, isImage),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, size: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationInput(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Konum',
          style: AppTypography.titleMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        TextFormField(
          controller: _locationController,
          decoration: InputDecoration(
            hintText: 'Nerede çekildi bu fotoğraf?',
            hintStyle: AppTypography.bodyMedium.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            prefixIcon: Icon(
              Icons.location_on_outlined,
              color: theme.colorScheme.primary,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
              borderSide: BorderSide(
                color: theme.colorScheme.outline.withValues(alpha: 0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
              borderSide: BorderSide(
                color: theme.colorScheme.primary,
                width: 2,
              ),
            ),
            filled: true,
            fillColor: theme.colorScheme.surface,
          ),
        ),
      ],
    );
  }

  Widget _buildTagsInput(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Etiketler',
          style: AppTypography.titleMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),

        // Selected Tags
        if (_tags.isNotEmpty)
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: _tags
                .map(
                  (tag) => Chip(
                    label: Text(tag),
                    deleteIcon: const Icon(Icons.close, size: 16),
                    onDeleted: () => _removeTag(tag),
                    backgroundColor: theme.colorScheme.primaryContainer,
                    labelStyle: TextStyle(
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                )
                .toList(),
          ),

        const SizedBox(height: AppSpacing.sm),

        // Add Tag Input
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _tagController,
                decoration: InputDecoration(
                  hintText: 'Etiket ekleyin (örn: #paris, #seyahat)',
                  hintStyle: AppTypography.bodyMedium.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                    borderSide: BorderSide(
                      color: theme.colorScheme.outline.withValues(alpha: 0.3),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                    borderSide: BorderSide(
                      color: theme.colorScheme.primary,
                      width: 2,
                    ),
                  ),
                  filled: true,
                  fillColor: theme.colorScheme.surface,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            ElevatedButton(
              onPressed: _addTag,
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                ),
              ),
              child: const Text('Ekle'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActivitiesSelection(ThemeData theme) {
    final activities = [
      'Yemek',
      'Kültür',
      'Doğa',
      'Spor',
      'Alışveriş',
      'Müze',
      'Tarih',
      'Sanat',
      'Müzik',
      'Festival',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Aktiviteler',
          style: AppTypography.titleMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xs,
          children: activities
              .map(
                (activity) => FilterChip(
                  label: Text(activity),
                  selected: _selectedActivities.contains(activity),
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedActivities.add(activity);
                      } else {
                        _selectedActivities.remove(activity);
                      }
                    });
                    SoundHapticService.lightImpact();
                  },
                  selectedColor: theme.colorScheme.primaryContainer,
                  checkmarkColor: theme.colorScheme.primary,
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _buildMoodSelection(ThemeData theme) {
    final moods = [
      {'name': 'Happy', 'emoji': '😊', 'color': Colors.yellow},
      {'name': 'Excited', 'emoji': '🤩', 'color': Colors.orange},
      {'name': 'Relaxed', 'emoji': '😌', 'color': Colors.blue},
      {'name': 'Adventurous', 'emoji': '🏔️', 'color': Colors.green},
      {'name': 'Cultural', 'emoji': '🏛️', 'color': Colors.purple},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ruh Hali',
          style: AppTypography.titleMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xs,
          children: moods
              .map(
                (mood) => FilterChip(
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(mood['emoji'] as String),
                      const SizedBox(width: 4),
                      Text(mood['name'] as String),
                    ],
                  ),
                  selected: _selectedMood == mood['name'],
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _selectedMood = mood['name'] as String;
                      });
                      SoundHapticService.lightImpact();
                    }
                  },
                  selectedColor: (mood['color'] as Color).withValues(
                    alpha: 0.2,
                  ),
                  checkmarkColor: mood['color'] as Color,
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _buildPrivacySettings(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gizlilik',
          style: AppTypography.titleMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        SwitchListTile(
          title: Text(
            'Herkese Açık',
            style: AppTypography.bodyLarge.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
          subtitle: Text(
            'Postunuz herkes tarafından görülebilir',
            style: AppTypography.bodySmall.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          value: _isPublic,
          onChanged: (value) {
            setState(() {
              _isPublic = value;
            });
            SoundHapticService.lightImpact();
          },
          activeThumbColor: theme.colorScheme.primary,
        ),
      ],
    );
  }

  // Helper Methods
  Future<void> _pickImages() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage();
      if (images.isNotEmpty) {
        setState(() {
          _selectedImages.addAll(images.map((image) => File(image.path)));
        });
        SoundHapticService.lightImpact();
      }
    } catch (e) {
      debugPrint('Fotoğraf seçilirken hata: $e');
    }
  }

  Future<void> _pickVideos() async {
    try {
      final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
      if (video != null) {
        setState(() {
          _selectedVideos.add(File(video.path));
        });
        SoundHapticService.lightImpact();
      }
    } catch (e) {
      debugPrint('Video seçilirken hata: $e');
    }
  }

  void _removeMedia(File file, bool isImage) {
    setState(() {
      if (isImage) {
        _selectedImages.remove(file);
      } else {
        _selectedVideos.remove(file);
      }
    });
    SoundHapticService.lightImpact();
  }

  void _addTag() {
    final tag = _tagController.text.trim();
    if (tag.isNotEmpty && !_tags.contains(tag)) {
      setState(() {
        _tags.add(tag);
        _tagController.clear();
      });
      SoundHapticService.lightImpact();
    }
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });
    SoundHapticService.lightImpact();
  }

  Future<void> _handleCreatePost() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Simüle edilmiş post oluşturma
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        SoundHapticService.successFeedback();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Post başarıyla oluşturuldu!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Post oluşturulurken hata: $e'),
            backgroundColor: Colors.red,
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
}
