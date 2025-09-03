import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'api_service.dart';

class MessageService {
  final ApiService _apiService = ApiService();
  io.Socket? _socket;
  bool _isConnected = false;
  String? _currentUserId;

  // Callbacks for real-time updates
  Function(Message)? onNewMessage;
  Function(String)? onMessageRead;
  Function(String)? onMessageDeleted;
  Function()? onConnectionStatusChanged;

  // Get messages for a specific trip
  Future<ApiResponse<List<Message>>> getTripMessages(String tripId) async {
    try {
      return await _apiService.getMessages(tripId);
    } catch (e) {
      debugPrint('Error fetching trip messages: $e');
      return ApiResponse.error('Failed to fetch messages');
    }
  }

  // Send a new message
  Future<ApiResponse<Message>> sendMessage({
    required String tripId,
    required String content,
    String? senderId,
  }) async {
    try {
      final messageData = {
        'tripId': tripId,
        'content': content,
        if (senderId != null) 'senderId': senderId,
      };

      final result = await _apiService.sendMessage(messageData);

      // Emit event through WebSocket if connected
      if (_isConnected && _socket != null) {
        _socket?.emit('send_message', messageData);
      }

      return result;
    } catch (e) {
      debugPrint('Error sending message: $e');
      return ApiResponse.error('Failed to send message');
    }
  }

  // Mark a message as read
  Future<ApiResponse<void>> markMessageAsRead(String messageId) async {
    try {
      // This would require a specific endpoint in the API
      // For now, we'll simulate the action
      debugPrint('Marking message $messageId as read');

      // Emit event through WebSocket if connected
      if (_isConnected && _socket != null) {
        _socket?.emit('message_read', {'messageId': messageId});
      }

      return ApiResponse.success(null);
    } catch (e) {
      debugPrint('Error marking message as read: $e');
      return ApiResponse.error('Failed to mark message as read');
    }
  }

  // Delete a message
  Future<ApiResponse<void>> deleteMessage(String messageId) async {
    try {
      // This would require a specific endpoint in the API
      // For now, we'll simulate the action
      debugPrint('Deleting message $messageId');

      // Emit event through WebSocket if connected
      if (_isConnected && _socket != null) {
        _socket?.emit('delete_message', {'messageId': messageId});
      }

      return ApiResponse.success(null);
    } catch (e) {
      debugPrint('Error deleting message: $e');
      return ApiResponse.error('Failed to delete message');
    }
  }

  // Connect to WebSocket for real-time messaging
  void connectToWebSocket(String userId) {
    try {
      _currentUserId = userId;

      // Initialize socket connection
      _socket = io.io(
        'http://localhost:3000', // WebSocket server URL
        io.OptionBuilder().setTransports(['websocket']).setQuery({
          'userId': userId,
        }).build(),
      );

      // Listen for connection events
      _socket?.onConnect((_) {
        debugPrint('WebSocket connected');
        _isConnected = true;
        onConnectionStatusChanged?.call();
      });

      _socket?.onDisconnect((_) {
        debugPrint('WebSocket disconnected');
        _isConnected = false;
        onConnectionStatusChanged?.call();
      });

      _socket?.onConnectError((err) {
        debugPrint('WebSocket connection error: $err');
        _isConnected = false;
        onConnectionStatusChanged?.call();
      });

      // Listen for real-time events
      _socket?.on('new_message', (data) {
        try {
          final message = Message.fromJson(data);
          onNewMessage?.call(message);
        } catch (e) {
          debugPrint('Error parsing new message: $e');
        }
      });

      _socket?.on('message_read', (data) {
        try {
          final messageId = data['messageId'] as String;
          onMessageRead?.call(messageId);
        } catch (e) {
          debugPrint('Error parsing message read event: $e');
        }
      });

      _socket?.on('message_deleted', (data) {
        try {
          final messageId = data['messageId'] as String;
          onMessageDeleted?.call(messageId);
        } catch (e) {
          debugPrint('Error parsing message deleted event: $e');
        }
      });
    } catch (e) {
      debugPrint('Error connecting to WebSocket: $e');
    }
  }

  // Disconnect from WebSocket
  void disconnectFromWebSocket() {
    try {
      _socket?.disconnect();
      _socket?.dispose();
      _socket = null;
      _isConnected = false;
      _currentUserId = null;
      onConnectionStatusChanged?.call();
    } catch (e) {
      debugPrint('Error disconnecting from WebSocket: $e');
    }
  }

  // Check if WebSocket is connected
  bool get isConnected => _isConnected;

  // Get current user ID
  String? get currentUserId => _currentUserId;
}
