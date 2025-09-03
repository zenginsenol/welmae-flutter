import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  String _selectedTab = 'Tümü';

  // Velmae Brand Colors
  static const Color velmaePrimary = Color(0xFF2563EB);
  static const Color velmaeSecondary = Color(0xFF10B981);
  static const Color velmaeAccent = Color(0xFFEF4444);
  static const Color velmaeOrange = Color(0xFFF97316);
  static const Color surfaceWhite = Color(0xFFFFFFFF);
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color textDark = Color(0xFF0F172A);
  static const Color textMedium = Color(0xFF475569);
  static const Color textLight = Color(0xFF94A3B8);
  static const Color borderLight = Color(0xFFE2E8F0);

  final List<String> tabs = ['Tümü', 'Aktif', 'Arşiv'];

  // Mock message data - will be replaced with backend data
  final List<Map<String, dynamic>> conversations = [
    {
      'id': '1',
      'participantName': 'Mehmet Kaya',
      'participantAvatar': null,
      'tripTitle': 'Kapadokya Balon Turu',
      'lastMessage': 'Buluşma noktası için Göreme merkez uygun mu?',
      'timestamp': '10:30',
      'isUnread': true,
      'unreadCount': 3,
      'status': 'Aktif',
      'tripType': 'Sponsor',
      'messageType': 'trip',
    },
    {
      'id': '2',
      'participantName': 'Ayşe Demir',
      'participantAvatar': null,
      'tripTitle': 'İstanbul Tarih Turu',
      'lastMessage': 'Müze biletlerini ben alayım, siz endişelenmeyin',
      'timestamp': 'Dün',
      'isUnread': false,
      'unreadCount': 0,
      'status': 'Aktif',
      'tripType': 'Guide',
      'messageType': 'trip',
    },
    {
      'id': '3',
      'participantName': 'Zeynep Çelik',
      'participantAvatar': null,
      'tripTitle': 'Antalya Sahil Tatili',
      'lastMessage': 'Fotoğrafları paylaştığınız için teşekkürler!',
      'timestamp': '2 gün önce',
      'isUnread': false,
      'unreadCount': 0,
      'status': 'Arşiv',
      'tripType': 'Sponsor',
      'messageType': 'trip',
    },
    {
      'id': '4',
      'participantName': 'Ali Yılmaz',
      'participantAvatar': null,
      'tripTitle': 'Trabzon Doğa Turu',
      'lastMessage':
          'Havanın durumu iyi görünüyor, gezi planlandığı gibi devam edecek',
      'timestamp': '3 gün önce',
      'isUnread': true,
      'unreadCount': 1,
      'status': 'Aktif',
      'tripType': 'Guide',
      'messageType': 'trip',
    },
    {
      'id': '5',
      'participantName': 'Velmae Destek',
      'participantAvatar': null,
      'tripTitle': 'Destek Talebi',
      'lastMessage':
          'Yardım talebiniz başarıyla çözüldü. Başka bir sorunuz var mı?',
      'timestamp': '1 hafta önce',
      'isUnread': false,
      'unreadCount': 0,
      'status': 'Arşiv',
      'tripType': 'Support',
      'messageType': 'support',
    },
  ];

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<double>(begin: 40.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 1.0, curve: Curves.elasticOut),
      ),
    );

    _animationController.forward();
  }

  List<Map<String, dynamic>> get filteredConversations {
    if (_selectedTab == 'Tümü') {
      return conversations;
    }
    return conversations
        .where((conv) => conv['status'] == _selectedTab)
        .toList();
  }

  int get unreadCount {
    return conversations.where((conv) => conv['isUnread']).length;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundLight,
      appBar: _buildAppBar(),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: Transform.translate(
              offset: Offset(0, _slideAnimation.value),
              child: Column(
                children: [
                  _buildHeader(),
                  _buildTabBar(),
                  Expanded(child: _buildConversationsList()),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: _buildNewMessageFAB(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: surfaceWhite,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: backgroundLight,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: textDark,
            size: 18,
          ),
        ),
      ),
      title: const Text(
        'Mesajlar',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: textDark,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () => _showSearchDialog(),
          icon: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: backgroundLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.search, color: textDark, size: 20),
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: surfaceWhite,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: borderLight),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    offset: const Offset(0, 2),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: velmaePrimary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.chat,
                      color: velmaePrimary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Aktif Sohbetler',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: textDark,
                          ),
                        ),
                        Text(
                          '${conversations.length} konuşma',
                          style: const TextStyle(
                            fontSize: 14,
                            color: textMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (unreadCount > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: velmaeAccent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        unreadCount.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: tabs.map((tab) {
          final isSelected = _selectedTab == tab;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTab = tab;
                });
                HapticFeedback.selectionClick();
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? velmaePrimary : surfaceWhite,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: isSelected ? velmaePrimary : borderLight,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: velmaePrimary.withValues(alpha: 0.3),
                            offset: const Offset(0, 4),
                            blurRadius: 12,
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  tab,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : textMedium,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildConversationsList() {
    final filtered = filteredConversations;

    if (filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.chat_bubble_outline, size: 64, color: textLight),
            const SizedBox(height: 16),
            const Text(
              'Henüz mesajınız yok',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: textDark,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Yeni bir gezi planladığınızda\nmesajlarınız burada görünecek',
              style: const TextStyle(fontSize: 14, color: textMedium),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final conversation = filtered[index];
        return _buildConversationCard(conversation, index);
      },
    );
  }

  Widget _buildConversationCard(Map<String, dynamic> conversation, int index) {
    final isUnread = conversation['isUnread'];
    final messageType = conversation['messageType'];

    return GestureDetector(
      onTap: () => _openConversation(conversation),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: surfaceWhite,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isUnread
                ? velmaePrimary.withValues(alpha: 0.3)
                : borderLight,
            width: isUnread ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              offset: const Offset(0, 2),
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
          children: [
            // Avatar
            Stack(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _getTripTypeColor(conversation['tripType']),
                      width: 2,
                    ),
                  ),
                  child: ClipOval(
                    child: Container(
                      color: backgroundLight,
                      child: Icon(
                        messageType == 'support' ? Icons.support : Icons.person,
                        color: textLight,
                        size: 28,
                      ),
                    ),
                  ),
                ),
                if (isUnread)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: const BoxDecoration(
                        color: velmaeAccent,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          conversation['unreadCount'].toString(),
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(width: 16),

            // Conversation Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          conversation['participantName'],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: isUnread
                                ? FontWeight.w700
                                : FontWeight.w600,
                            color: textDark,
                          ),
                        ),
                      ),
                      Text(
                        conversation['timestamp'],
                        style: TextStyle(
                          fontSize: 12,
                          color: isUnread ? velmaePrimary : textLight,
                          fontWeight: isUnread
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Trip Title with Type Badge
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: _getTripTypeColor(
                            conversation['tripType'],
                          ).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          conversation['tripType'] == 'Support'
                              ? 'Destek'
                              : conversation['tripType'],
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: _getTripTypeColor(conversation['tripType']),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          conversation['tripTitle'],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: textMedium,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  // Last Message
                  Text(
                    conversation['lastMessage'],
                    style: TextStyle(
                      fontSize: 14,
                      color: isUnread ? textDark : textMedium,
                      fontWeight: isUnread ? FontWeight.w500 : FontWeight.w400,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Arrow
            Icon(Icons.arrow_forward_ios, color: textLight, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildNewMessageFAB() {
    return FloatingActionButton(
      onPressed: () => _startNewConversation(),
      backgroundColor: velmaePrimary,
      elevation: 8,
      child: const Icon(Icons.chat, color: Colors.white),
    );
  }

  Color _getTripTypeColor(String tripType) {
    switch (tripType) {
      case 'Sponsor':
        return velmaePrimary;
      case 'Guide':
        return velmaeSecondary;
      case 'Support':
        return velmaeOrange;
      default:
        return textMedium;
    }
  }

  void _openConversation(Map<String, dynamic> conversation) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(conversation: conversation),
      ),
    );
  }

  void _startNewConversation() {
    HapticFeedback.mediumImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Yeni konuşma özelliği yakında!'),
        backgroundColor: velmaePrimary,
      ),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Mesaj Ara'),
        content: TextField(
          decoration: InputDecoration(
            hintText: 'Kişi veya mesaj ara...',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: borderLight),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: velmaePrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Ara', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

// Simple ChatScreen for individual conversations
class ChatScreen extends StatefulWidget {
  final Map<String, dynamic> conversation;

  const ChatScreen({super.key, required this.conversation});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  // Mock chat messages
  final List<Map<String, dynamic>> messages = [
    {
      'id': '1',
      'text': 'Merhaba! Kapadokya turu için detayları konuşabilir miyiz?',
      'isMe': false,
      'timestamp': '10:15',
      'type': 'text',
    },
    {
      'id': '2',
      'text': 'Tabii ki! Size uygun olan tarih nedir?',
      'isMe': true,
      'timestamp': '10:17',
      'type': 'text',
    },
    {
      'id': '3',
      'text': '15-17 Ağustos tarihleri uygun. Grup kaç kişi olacak?',
      'isMe': false,
      'timestamp': '10:20',
      'type': 'text',
    },
    {
      'id': '4',
      'text': 'Toplamda 4 kişi olacağız. Balon turu dahil mi?',
      'isMe': true,
      'timestamp': '10:22',
      'type': 'text',
    },
    {
      'id': '5',
      'text':
          'Evet, balon turu pakete dahil. Buluşma noktası için Göreme merkez uygun mu?',
      'isMe': false,
      'timestamp': '10:30',
      'type': 'text',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF0F172A)),
        ),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF2563EB), width: 2),
              ),
              child: const ClipOval(
                child: Icon(Icons.person, color: Color(0xFF94A3B8)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.conversation['participantName'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  Text(
                    widget.conversation['tripTitle'],
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF475569),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.phone, color: Color(0xFF2563EB)),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: Color(0xFF0F172A)),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return _buildMessageBubble(message);
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> message) {
    final isMe = message['isMe'];

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xFF2563EB) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              offset: const Offset(0, 2),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message['text'],
              style: TextStyle(
                fontSize: 14,
                color: isMe ? Colors.white : const Color(0xFF0F172A),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              message['timestamp'],
              style: TextStyle(
                fontSize: 10,
                color: isMe
                    ? Colors.white.withValues(alpha: 0.7)
                    : const Color(0xFF94A3B8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Mesajınızı yazın...',
                hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: Color(0xFF2563EB),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: _sendMessage,
              icon: const Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      HapticFeedback.lightImpact();
      // Add message logic here
      _messageController.clear();
    }
  }
}
