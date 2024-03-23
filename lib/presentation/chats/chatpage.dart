import 'package:code_geeks_mentor/application/chat_bloc/chat_bloc.dart';
import 'package:code_geeks_mentor/presentation/chats/widgets/chat_content.dart';
import 'package:code_geeks_mentor/presentation/chats/widgets/chat_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MentorChatPage extends StatelessWidget {
  const MentorChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
        centerTitle: true,
      ),
      body: Row(
        children: [
          ChatList(screenWidth: screenWidth),
          Expanded(
            child: ChatContentPage(),
          ),
        ],
      ),
    );
  }
}



