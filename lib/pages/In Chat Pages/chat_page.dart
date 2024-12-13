import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../../models/patient.dart';
import '../../widgets/custom_app_bar.dart'; // Import the CustomAppBar
import '../../widgets/custom_bottom_input.dart'; // Import the CustomBottomInput

class ChatScreen extends StatefulWidget {
  final Patient patient;

  const ChatScreen({super.key, required this.patient});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _messageController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  List<Map<String, String>> messages = [];
  bool isSending = false;

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void sendMessage() {
    if (_messageController.text.isNotEmpty) {
      String messageText = _messageController.text;
      String timestamp = _getFormattedTime();

      setState(() {
        messages.add({'message': messageText, 'timestamp': timestamp});
        _messageController.clear();
      });

      _saveMessages();
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  String _getFormattedTime() {
    final now = DateTime.now();
    final formatter = DateFormat('hh:mm a');
    return formatter.format(now);
  }

  Future<void> _loadMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final key = widget.patient.name;
    final String? savedMessages = prefs.getString(key);

    if (savedMessages != null) {
      List<Map<String, String>> loadedMessages = List<Map<String, String>>.from(
        (savedMessages.split(',') as List).map((msg) {
          final parts = msg.split(';');
          return {'message': parts[0], 'timestamp': parts[1]};
        }),
      );
      setState(() {
        messages = loadedMessages;
      });
    }
  }

  Future<void> _saveMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final key = widget.patient.name;

    final savedMessages = messages.map((msg) {
      return '${msg['message']};${msg['timestamp']}';
    }).join(',');

    await prefs.setString(key, savedMessages);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.patient.name,
        subtitle: '${widget.patient.age} years, ${widget.patient.gender}',
        imagePath: widget.patient.image,
        showCallButton: true,
        showMoreOptionsButton: true,
        onCallPress: () {
          print('Call button tapped');
        },
        onMoreOptionsPress: () {
          print('More options button tapped');
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              reverse: false,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index]['message'] ?? '';
                final timestamp = messages[index]['timestamp'] ?? '';

                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 3.0, horizontal: 15.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFDCF8C6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(message, style: TextStyle(color: Colors.black)),
                          const SizedBox(height: 5),
                          Text(
                            timestamp,
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          CustomBottomInput(
            messageController: _messageController,
            isSending: isSending,
            onSendMessage: () {
              if (!isSending) {
                setState(() {
                  isSending = true;
                });
                sendMessage();
                Future.delayed(const Duration(seconds: 1), () {
                  setState(() {
                    isSending = false;
                  });
                });
              }
            },
            onAttachFile: () {
              print('Attach file clicked');
            },
          ),
        ],
      ),
    );
  }
}
