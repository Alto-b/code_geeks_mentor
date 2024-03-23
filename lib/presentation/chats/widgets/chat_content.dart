import 'package:code_geeks_mentor/application/chat_bloc/chat_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatContentPage extends StatelessWidget {
   ChatContentPage({
    super.key
  });

TextEditingController _content = TextEditingController();

final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    final user = FirebaseAuth.instance.currentUser;
    
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        print(state.runtimeType);
        if(state is SpecificChatLoadedState){
          final DatabaseReference chatRef = FirebaseDatabase.instance.reference().child(state.bookingId);
          return Column(
            children: [
              Container(
                height: screenHeight/12,
                width: screenWidth,
                color: Colors.blue,
              ),
              Expanded(
                child: Container(
                color: Colors.amber,
                child: StreamBuilder(
                  stream: chatRef.onValue, 
                  builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                      if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
                             Map<dynamic, dynamic> map = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
                                  List<dynamic> list = map.values.toList();
                                  list.forEach((chat) {
                                    if (chat['dateTime'] is String) {
                                      // Parse the ISO 8601 string to a DateTime object
                                      chat['dateTime'] = DateTime.parse(chat['dateTime']);
                                    }
                                  });
                                  list.sort((a, b) => b['dateTime'].compareTo(a['dateTime']));
                                  list = list.reversed.toList();
                              return ListView.builder(
                                itemCount: snapshot.data!.snapshot.children.length,
                                itemBuilder: (context, index) {
                                  return (list[index]['senderId']==user!.uid)?
                                  //send bubble
                                    ChatBubble(
                                      clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
                                      alignment: Alignment.topRight,
                                      margin: EdgeInsets.only(top: 20),
                                      backGroundColor: Colors.blue,
                                      child: Container(
                                        constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context).size.width * 0.7,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            (list[index]['content_type']=="text")?
                                            Text(
                                              list[index]['content'],
                                              style: TextStyle(color: Colors.white,fontSize: 18),
                                            ):
                                            Container(
                                              height: 100,
                                              width: 150,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                image: DecorationImage(image: NetworkImage(list[index]['content']))
                                              ),
                                            )
                                            ,SizedBox(width: 10,),
                                            CircleAvatar(backgroundImage: NetworkImage(list[index]['avatar']),radius: 10,),
                                          ],
                                        ),
                                      ),
                                    ):
                                    //recieve bubble
                                    ChatBubble(
                                  clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
                                  backGroundColor: Color(0xffE7E7ED),
                                  margin: EdgeInsets.only(top: 20),
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                                    ),
                                    child:Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CircleAvatar(backgroundImage: NetworkImage(list[index]['avatar']),radius: 10,),
                                            SizedBox(width: 10,),
                                            (list[index]['content_type']=="text")?
                                            Text(
                                              list[index]['content'],
                                              style: TextStyle(color: const Color.fromARGB(255, 3, 3, 3),fontSize: 18),
                                            ):
                                            Container(
                                              height: 100,
                                              width: 150,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                image: DecorationImage(image: NetworkImage(list[index]['content']))
                                              ),
                                            )
                                            
                                          ],
                                        ),
                                  ),
                                );
                        
                                },
                                );
                            } else if (snapshot.hasError) {
                              return Icon(Icons.error);
                            } else {
                              return Center(
                                child: Text("Chat responsibly ",style: GoogleFonts.orbitron(
                                  fontSize: 15,fontWeight: FontWeight.w700,color: Colors.grey
                                ),),
                              );
                            }
                  },),
                  
                        ),
              ),
                      Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _content,
                   decoration: InputDecoration(
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(onPressed: (){
                            // _imagePickerDialog(context);
                          }, icon: Icon(Icons.photo_outlined)),
                          IconButton(onPressed: (){
                            Map<String,dynamic> data = {
                            "senderId" : user?.uid,
                            "avatar" : user?.photoURL ?? "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
                            "content_type" : "text",
                            "content" : _content.text.trim(),
                            "dateTime" : DateTime.now().toIso8601String()
                        };
                            sendMessage(context,data,state);
                          }, icon: Icon(Icons.send)),
                        ],
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    )
                   ),
                ),
              )
            ],
          );
        }
        return Container(
          color: Colors.red,
        );
      },
    );
  }

      void sendMessage(BuildContext context,Map<String,dynamic> data,SpecificChatLoadedState state) {
      databaseReference.child(state.bookingId).push().set(data).whenComplete((){
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("done")));
      _content.clear();
}) ;
  }
}