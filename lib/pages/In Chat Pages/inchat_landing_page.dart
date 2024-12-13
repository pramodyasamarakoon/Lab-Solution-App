import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../../models/patient.dart';
import '../../widgets/custom_app_bar.dart';

class InChatLanding extends StatefulWidget {
  final Patient patient;

  const InChatLanding({super.key, required this.patient});

  @override
  _InChatLandingState createState() => _InChatLandingState();
}

class _InChatLandingState extends State<InChatLanding> {
  TextEditingController _messageController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  List<Map<String, String>> messages = [];
  bool isSending = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
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
      body: Column(),
    );
  }
}
