import 'package:flutter/material.dart';

class CustomBottomInput extends StatelessWidget {
  final TextEditingController messageController;
  final bool isSending;
  final VoidCallback onSendMessage;
  final VoidCallback onAttachFile;

  const CustomBottomInput({
    super.key,
    required this.messageController,
    required this.isSending,
    required this.onSendMessage,
    required this.onAttachFile,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.attach_file),
            onPressed: onAttachFile,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: messageController,
                decoration: const InputDecoration(
                  hintText: 'Type a message...',
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(isSending ? Icons.hourglass_empty : Icons.send),
            onPressed: onSendMessage,
          ),
        ],
      ),
    );
  }
}
