import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../services/tier_restriction_service.dart';

class TierRestrictionWidget extends StatefulWidget {
  final Widget child;
  final String feature;
  final String? customMessage;
  final Widget? restrictedWidget;
  final Future<bool> Function()? customCheck;

  const TierRestrictionWidget({
    super.key,
    required this.child,
    required this.feature,
    this.customMessage,
    this.restrictedWidget,
    this.customCheck,
  });

  @override
  State<TierRestrictionWidget> createState() => _TierRestrictionWidgetState();
}

class _TierRestrictionWidgetState extends State<TierRestrictionWidget> {
  late TierRestrictionService _tierService;
  bool _hasPermission = true;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tierService = TierRestrictionService();
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    if (authProvider.currentUser == null) {
      setState(() {
        _hasPermission = false;
        _isLoading = false;
      });
      return;
    }

    final userTier = authProvider.currentUser!.tier;

    bool hasPermission = false;

    // If custom check is provided, use it
    if (widget.customCheck != null) {
      hasPermission = await widget.customCheck!();
    } else {
      // Check based on feature name
      switch (widget.feature) {
        case 'createTrip':
          // Mock current trip count for now
          final result = await _tierService.canCreateTrip(userTier, 1);
          hasPermission = result.success && result.data == true;
          break;
        case 'createSponsoredTrip':
          final result = await _tierService.canCreateSponsoredTrip(userTier);
          hasPermission = result.success && result.data == true;
          break;
        case 'beGuide':
          final result = await _tierService.canBeGuide(userTier);
          hasPermission = result.success && result.data == true;
          break;
        case 'advancedFilters':
          final result = await _tierService.canUseAdvancedFilters(userTier);
          hasPermission = result.success && result.data == true;
          break;
        case 'privateTrips':
          final result = await _tierService.canCreatePrivateTrips(userTier);
          hasPermission = result.success && result.data == true;
          break;
        case 'hostEvents':
          final result = await _tierService.canHostEvents(userTier);
          hasPermission = result.success && result.data == true;
          break;
        default:
          hasPermission = true;
      }
    }

    if (mounted) {
      setState(() {
        _hasPermission = hasPermission;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_hasPermission) {
      return widget.child;
    }

    if (widget.restrictedWidget != null) {
      return widget.restrictedWidget!;
    }

    return _buildRestrictedWidget();
  }

  Widget _buildRestrictedWidget() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userTier = authProvider.currentUser?.tier ?? 'bronze';
    final nextTier = _getNextTier(userTier);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Opacity(
          opacity: 0.5,
          child: AbsorbPointer(absorbing: true, child: widget.child),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.orange.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              const Icon(Icons.lock, color: Colors.orange, size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  widget.customMessage ??
                      'Bu özellik ${nextTier.toUpperCase()} üyelik gerektirir',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.orange,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/subscription');
                },
                child: const Text(
                  'Yükselt',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.orange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getNextTier(String currentTier) {
    switch (currentTier.toLowerCase()) {
      case 'bronze':
        return 'silver';
      case 'silver':
        return 'gold';
      default:
        return 'gold';
    }
  }
}
