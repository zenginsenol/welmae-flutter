import 'package:flutter/material.dart';
import '../app/theme/typography.dart';
import '../app/theme/dimensions.dart';
import '../services/sound_haptic_service.dart';

class GroupTravelScreen extends StatefulWidget {
  const GroupTravelScreen({super.key});

  @override
  State<GroupTravelScreen> createState() => _GroupTravelScreenState();
}

class _GroupTravelScreenState extends State<GroupTravelScreen>
    with TickerProviderStateMixin {
  final List<Map<String, dynamic>> _groupTrips = [];
  final List<Map<String, dynamic>> _pendingInvitations = [];
  final List<Map<String, dynamic>> _groupMembers = [];

  bool _isLoading = true;
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadGroupTravelData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Grup Seyahatleri',
          style: AppTypography.titleLarge.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _showCreateGroupDialog,
            icon: Icon(Icons.group_add, color: theme.colorScheme.onSurface),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: theme.colorScheme.primary,
          unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
          indicatorColor: theme.colorScheme.primary,
          tabs: [
            Tab(text: 'Grup Seyahatlerim (${_groupTrips.length})'),
            Tab(text: 'Davetler (${_pendingInvitations.length})'),
            Tab(text: 'Üyeler (${_groupMembers.length})'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          _buildSearchBar(theme),

          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildGroupTripsTab(theme),
                _buildInvitationsTab(theme),
                _buildMembersTab(theme),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showCreateGroupDialog,
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        icon: const Icon(Icons.group_add),
        label: const Text('Grup Oluştur'),
      ),
    );
  }

  Widget _buildSearchBar(ThemeData theme) {
    return Container(
      margin: const EdgeInsets.all(AppSpacing.md),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Grup seyahat ara...',
          prefixIcon: Icon(
            Icons.search,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              _searchController.clear();
              _performSearch('');
            },
            icon: Icon(Icons.clear, color: theme.colorScheme.onSurfaceVariant),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            borderSide: BorderSide(color: theme.colorScheme.outline),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            borderSide: BorderSide(color: theme.colorScheme.outline),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
          ),
          filled: true,
          fillColor: theme.colorScheme.surface,
        ),
        onChanged: _performSearch,
      ),
    );
  }

  Widget _buildGroupTripsTab(ThemeData theme) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_groupTrips.isEmpty) {
      return _buildEmptyState(
        'Grup seyahatiniz yok',
        'Henüz bir grup seyahatine katılmadınız',
        'Grup Oluştur',
        _showCreateGroupDialog,
        theme,
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: _groupTrips.length,
      itemBuilder: (context, index) {
        final trip = _groupTrips[index];
        return _buildGroupTripCard(trip, theme);
      },
    );
  }

  Widget _buildInvitationsTab(ThemeData theme) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_pendingInvitations.isEmpty) {
      return _buildEmptyState(
        'Davet yok',
        'Bekleyen davetiniz bulunmuyor',
        'Grup Ara',
        _showSearchGroupsDialog,
        theme,
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: _pendingInvitations.length,
      itemBuilder: (context, index) {
        final invitation = _pendingInvitations[index];
        return _buildInvitationCard(invitation, theme);
      },
    );
  }

  Widget _buildMembersTab(ThemeData theme) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_groupMembers.isEmpty) {
      return _buildEmptyState(
        'Üye yok',
        'Henüz grup üyeniz bulunmuyor',
        'Üye Ekle',
        _showAddMemberDialog,
        theme,
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: _groupMembers.length,
      itemBuilder: (context, index) {
        final member = _groupMembers[index];
        return _buildMemberCard(member, theme);
      },
    );
  }

  Widget _buildGroupTripCard(Map<String, dynamic> trip, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Trip Header
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppSizes.radiusLg),
                topRight: Radius.circular(AppSizes.radiusLg),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.group, color: theme.colorScheme.primary, size: 24),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        trip['name'],
                        style: AppTypography.titleMedium.copyWith(
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        '${trip['memberCount']} üye • ${trip['status']}',
                        style: AppTypography.bodySmall.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  icon: Icon(
                    Icons.more_vert,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  onSelected: (value) => _handleTripAction(value, trip),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit),
                          SizedBox(width: 8),
                          Text('Düzenle'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'share',
                      child: Row(
                        children: [
                          Icon(Icons.share),
                          SizedBox(width: 8),
                          Text('Paylaş'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'leave',
                      child: Row(
                        children: [
                          Icon(Icons.exit_to_app),
                          SizedBox(width: 8),
                          Text('Gruptan Ayrıl'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Trip Details
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Destination & Dates
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: theme.colorScheme.primary,
                      size: 20,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Expanded(
                      child: Text(
                        trip['destination'],
                        style: AppTypography.bodyMedium.copyWith(
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.calendar_today,
                      color: theme.colorScheme.primary,
                      size: 20,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      '${trip['startDate']} - ${trip['endDate']}',
                      style: AppTypography.bodySmall.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.sm),

                // Budget & Activities
                Row(
                  children: [
                    Icon(
                      Icons.account_balance_wallet,
                      color: theme.colorScheme.secondary,
                      size: 20,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      'Bütçe: ${trip['budget']}',
                      style: AppTypography.bodySmall.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Icon(
                      Icons.list,
                      color: theme.colorScheme.secondary,
                      size: 20,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      '${trip['activityCount']} aktivite',
                      style: AppTypography.bodySmall.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.md),

                // Progress Bar
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Planlama İlerlemesi',
                          style: AppTypography.bodySmall.copyWith(
                            fontWeight: FontWeight.w500,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        Text(
                          '${(trip['progress'] * 100).toInt()}%',
                          style: AppTypography.bodySmall.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    LinearProgressIndicator(
                      value: trip['progress'],
                      backgroundColor:
                          theme.colorScheme.surfaceContainerHighest,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Action Buttons
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest.withValues(
                alpha: 0.1,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(AppSizes.radiusLg),
                bottomRight: Radius.circular(AppSizes.radiusLg),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _viewTripDetails(trip),
                    icon: const Icon(Icons.visibility),
                    label: const Text('Detayları Gör'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: theme.colorScheme.primary,
                      side: BorderSide(color: theme.colorScheme.primary),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _openTripChat(trip),
                    icon: const Icon(Icons.chat),
                    label: const Text('Sohbet'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvitationCard(
    Map<String, dynamic> invitation,
    ThemeData theme,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.2),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(AppSpacing.md),
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: invitation['inviterAvatar'] != null
              ? NetworkImage(invitation['inviterAvatar'])
              : null,
          backgroundColor: theme.colorScheme.primaryContainer,
          child: invitation['inviterAvatar'] == null
              ? Text(
                  invitation['inviterName'][0].toUpperCase(),
                  style: AppTypography.bodyLarge.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w600,
                  ),
                )
              : null,
        ),
        title: Text(
          '${invitation['inviterName']} sizi davet ediyor',
          style: AppTypography.bodyLarge.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              invitation['groupName'],
              style: AppTypography.bodyMedium.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${invitation['destination']} • ${invitation['startDate']}',
              style: AppTypography.bodySmall.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => _acceptInvitation(invitation),
              icon: Icon(Icons.check, color: Colors.green, size: 24),
            ),
            IconButton(
              onPressed: () => _declineInvitation(invitation),
              icon: Icon(Icons.close, color: Colors.red, size: 24),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMemberCard(Map<String, dynamic> member, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(AppSpacing.md),
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: member['avatar'] != null
              ? NetworkImage(member['avatar'])
              : null,
          backgroundColor: theme.colorScheme.primaryContainer,
          child: member['avatar'] == null
              ? Text(
                  member['name'][0].toUpperCase(),
                  style: AppTypography.bodyLarge.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w600,
                  ),
                )
              : null,
        ),
        title: Text(
          member['name'],
          style: AppTypography.bodyLarge.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              member['role'],
              style: AppTypography.bodySmall.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${member['contributionCount']} katkı • ${member['joinDate']} katıldı',
              style: AppTypography.bodySmall.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          icon: Icon(
            Icons.more_vert,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          onSelected: (value) => _handleMemberAction(value, member),
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'profile',
              child: Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(width: 8),
                  Text('Profili Gör'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'message',
              child: Row(
                children: [
                  Icon(Icons.message),
                  SizedBox(width: 8),
                  Text('Mesaj Gönder'),
                ],
              ),
            ),
            if (member['role'] == 'Admin')
              const PopupMenuItem(
                value: 'remove',
                child: Row(
                  children: [
                    Icon(Icons.person_remove),
                    SizedBox(width: 8),
                    Text('Üyeyi Çıkar'),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(
    String title,
    String subtitle,
    String buttonText,
    VoidCallback onPressed,
    ThemeData theme,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.group_outlined,
            size: 80,
            color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            title,
            style: AppTypography.titleLarge.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            subtitle,
            style: AppTypography.bodyMedium.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          ElevatedButton.icon(
            onPressed: onPressed,
            icon: const Icon(Icons.add),
            label: Text(buttonText),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }

  // Helper Methods
  void _loadGroupTravelData() async {
    // Simüle edilmiş veri yükleme
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      setState(() {
        _groupTrips.addAll([
          {
            'id': '1',
            'name': 'Paris Macera Grubu',
            'destination': 'Paris, Fransa',
            'startDate': '15 Haz',
            'endDate': '22 Haz',
            'memberCount': 8,
            'status': 'Planlanıyor',
            'budget': '€2,500',
            'activityCount': 12,
            'progress': 0.75,
          },
          {
            'id': '2',
            'name': 'Santorini Gün Batımı',
            'destination': 'Santorini, Yunanistan',
            'startDate': '1 Tem',
            'endDate': '8 Tem',
            'memberCount': 6,
            'status': 'Onaylandı',
            'budget': '€1,800',
            'activityCount': 8,
            'progress': 0.90,
          },
        ]);

        _pendingInvitations.addAll([
          {
            'id': '1',
            'inviterName': 'Ayşe Demir',
            'inviterAvatar': null,
            'groupName': 'İstanbul Keşif',
            'destination': 'İstanbul, Türkiye',
            'startDate': '10 Ağu',
          },
          {
            'id': '2',
            'inviterName': 'Mehmet Kaya',
            'inviterAvatar': null,
            'groupName': 'Kapadokya Balon Turu',
            'destination': 'Kapadokya, Türkiye',
            'startDate': '25 Ağu',
          },
        ]);

        _groupMembers.addAll([
          {
            'id': '1',
            'name': 'Senol Yılmaz',
            'avatar': null,
            'role': 'Admin',
            'contributionCount': 15,
            'joinDate': '1 ay önce',
          },
          {
            'id': '2',
            'name': 'Ayşe Demir',
            'avatar': null,
            'role': 'Üye',
            'contributionCount': 8,
            'joinDate': '2 hafta önce',
          },
          {
            'id': '3',
            'name': 'Mehmet Kaya',
            'avatar': null,
            'role': 'Üye',
            'contributionCount': 12,
            'joinDate': '1 hafta önce',
          },
        ]);

        _isLoading = false;
      });
    }
  }

  void _performSearch(String query) {
    // Arama işlevselliği
    setState(() {
      // Filtreleme mantığı burada uygulanacak
    });
  }

  void _showCreateGroupDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Grup Seyahat Oluştur'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Yeni bir grup seyahat oluşturmak için seyahat planlama ekranına gidin.',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/trip-planner');
            },
            child: const Text('Seyahat Planla'),
          ),
        ],
      ),
    );
  }

  void _showSearchGroupsDialog() {
    // Grup arama dialog'u
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Grup arama özelliği yakında gelecek'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _showAddMemberDialog() {
    // Üye ekleme dialog'u
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Üye ekleme özelliği yakında gelecek'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _handleTripAction(String action, Map<String, dynamic> trip) {
    switch (action) {
      case 'edit':
        Navigator.pushNamed(
          context,
          '/trip-planner',
          arguments: {'tripId': trip['id']},
        );
        break;
      case 'share':
        _shareTrip(trip);
        break;
      case 'leave':
        _leaveGroup(trip);
        break;
    }
  }

  void _handleMemberAction(String action, Map<String, dynamic> member) {
    switch (action) {
      case 'profile':
        Navigator.pushNamed(
          context,
          '/profile',
          arguments: {'userId': member['id']},
        );
        break;
      case 'message':
        _sendMessage(member);
        break;
      case 'remove':
        _removeMember(member);
        break;
    }
  }

  void _viewTripDetails(Map<String, dynamic> trip) {
    Navigator.pushNamed(
      context,
      '/trip-planner',
      arguments: {'tripId': trip['id']},
    );
  }

  void _openTripChat(Map<String, dynamic> trip) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${trip['name']} sohbeti açılıyor...'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _acceptInvitation(Map<String, dynamic> invitation) {
    setState(() {
      _pendingInvitations.remove(invitation);
    });

    SoundHapticService.successFeedback();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Davet kabul edildi!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _declineInvitation(Map<String, dynamic> invitation) {
    setState(() {
      _pendingInvitations.remove(invitation);
    });

    SoundHapticService.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Davet reddedildi'),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _shareTrip(Map<String, dynamic> trip) {
    SoundHapticService.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${trip['name']} paylaşılıyor...'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _leaveGroup(Map<String, dynamic> trip) {
    setState(() {
      _groupTrips.remove(trip);
    });

    SoundHapticService.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${trip['name']} grubundan ayrıldınız'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  void _sendMessage(Map<String, dynamic> member) {
    SoundHapticService.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${member['name']} kullanıcısına mesaj gönderiliyor...'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _removeMember(Map<String, dynamic> member) {
    setState(() {
      _groupMembers.remove(member);
    });

    SoundHapticService.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${member['name']} gruptan çıkarıldı'),
        backgroundColor: Colors.red,
      ),
    );
  }
}
