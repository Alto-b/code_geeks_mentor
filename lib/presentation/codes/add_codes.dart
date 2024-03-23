import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_geeks_mentor/application/post_bloc/post_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCodesPage extends StatelessWidget {
   AddCodesPage({super.key});

  final _key = GlobalKey<FormState>();

  TextEditingController _title = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _content = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Upload posts here !"),
              SizedBox(height: 30,),
              Container(
                width: screenWidth/2,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.grey[200],),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Form(
                    key: _key,
                    child: Column(
                    children: [
                        TextFormField(
                          controller: _title,
                          validator: validateNotEmpty,
                          decoration: InputDecoration(
                            label: Text("Title"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                            )
                          ),
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          controller: _description,
                          validator: validateNotEmpty,
                          decoration: InputDecoration(
                            label: Text("Description"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                            )
                          ),
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          controller: _content,
                          validator: validateNotEmpty,
                          maxLines: 15,
                          decoration: InputDecoration(
                            label: Text("Content"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                            )
                          ),
                        ),
                        SizedBox(height: 20,),
                        ElevatedButton(onPressed: (){
                          // if(_key.currentState!.validate()){
                            uploadPost(context);
                          // }
                        }, child: Text("Upload"))
                    ],
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  
  void uploadPost(BuildContext context) {
    if(_key.currentState!.validate()){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Uploading post"),backgroundColor: Colors.blue,duration: Duration(seconds: 2),));
   final postId = FirebaseFirestore.instance.collection("post").doc().id;
                             Map<String,String> data = {
                              "id" : postId,
                            "title" : _title.text.trim(),
                            "description" : _description.text.trim(),
                            "content" : _content.text.trim(),
                            "author" : FirebaseAuth.instance.currentUser!.displayName ?? "_",
                            "author_avatar" : FirebaseAuth.instance.currentUser!.photoURL ?? "https://media.istockphoto.com/id/1495088043/vector/user-profile-icon-avatar-or-person-icon-profile-picture-portrait-symbol-default-portrait.jpg?s=612x612&w=0&k=20&c=dhV2p1JwmloBTOaGAtaA3AW1KSnjsdMt7-U_3EZElZ0=",
                            "date" : DateTime.now().toString()
                          };
    context.read<PostBloc>().add(AddPostEvent(data: data, postId: postId));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Post Uploaded"),backgroundColor: Colors.green,duration: Duration(seconds: 1),));
    _title.clear();_content.clear();_description.clear();
    }
  }

    //to validate not empty
String? validateNotEmpty(String? value) {
  
  final trimmedValue = value?.trim();

  if (trimmedValue == null || trimmedValue.isEmpty) {
    return 'Cannot be empty';
  }
  return null; 
}
}