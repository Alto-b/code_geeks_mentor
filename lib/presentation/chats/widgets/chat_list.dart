import 'package:code_geeks_mentor/application/chat_bloc/chat_bloc.dart';
import 'package:code_geeks_mentor/presentation/chats/widgets/chat_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatList extends StatelessWidget {
  const ChatList({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    context.read<ChatBloc>().add(ChatUsersLoadEvent(guideId: FirebaseAuth.instance.currentUser!.uid));
    return Container(
      width: screenWidth/4,
      child: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          print(state.runtimeType);
          if(state is ChatUsersLoadedState){
            return ListView.builder(
              itemCount: state.chatList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () {
                      context.read<ChatBloc>().add(SpecificChatLoadEvent(booking_id: state.chatList[index].booking_id,guide_id: FirebaseAuth.instance.currentUser!.uid));
                      
                    },
                    tileColor: Colors.green,
                    leading: CircleAvatar(
                      backgroundImage: (state.chatList[index].user_avatar.length <=0)?
                      NetworkImage(state.chatList[index].user_avatar)
                      : NetworkImage("https://st4.depositphotos.com/4329009/19956/v/450/depositphotos_199564354-stock-illustration-creative-vector-illustration-default-avatar.jpg")
                    ),
                    subtitle: Text(state.chatList[index].sub_title),
                    title: Text(state.chatList[index].user_name),
                  ),
                );
            },);
          }
          else if (state is SpecificChatLoadedState){
            
            return ListView.builder(
              itemCount: state.chatList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () {
                      context.read<ChatBloc>().add(SpecificChatLoadEvent(booking_id: state.chatList[index].booking_id,guide_id: FirebaseAuth.instance.currentUser!.uid));
                      
                    },
                    tileColor: Colors.green,
                    leading: CircleAvatar(
                      backgroundImage: (state.chatList[index].user_avatar.length <=0)?
                      NetworkImage(state.chatList[index].user_avatar)
                      : NetworkImage("https://st4.depositphotos.com/4329009/19956/v/450/depositphotos_199564354-stock-illustration-creative-vector-illustration-default-avatar.jpg")
                    ),
                    subtitle: Text(state.chatList[index].sub_title),
                    title: Text(state.chatList[index].user_name),
                  ),
                );
            },);
          
          }
          return Text("no chats");
        },
      ),
    );
  }
}