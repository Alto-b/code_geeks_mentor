import 'dart:typed_data';

import 'package:code_geeks_mentor/application/image_picker_bloc/image_bloc.dart';
import 'package:code_geeks_mentor/application/mentor_bloc/mentor_bloc.dart';
import 'package:code_geeks_mentor/presentation/profile/widget/profile_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebasestorage ;

class MentorProfilePage extends StatelessWidget {
   MentorProfilePage({super.key});

  final _key = GlobalKey<FormState>(); 

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  TextEditingController _bioController = TextEditingController();
  String? photo;

  Uint8List? newImage;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final user = FirebaseAuth.instance.currentUser;
    context.read<MentorBloc>().add(mentorLoadEvent(email: user!.email!));
    return Scaffold(
      appBar: AppBar(
        title: Text("profile",style: GoogleFonts.orbitron(
          fontSize: 20,fontWeight: FontWeight.w600,color: Colors.grey,letterSpacing: 5
        ),),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<MentorBloc, MentorState>(
                builder: (context, state) {
                  print(state.runtimeType);
                  if(state is mentorLoadedState){
                    _nameController.text = state.mentorData['name'];
                    _emailController.text = state.mentorData['email'];
                    _contactController.text = state.mentorData['contact'];
                    _bioController.text = state.mentorData['qualification'];
                    photo = state.mentorData['photo'];
                    return Card(
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(30)
                        ),
                              child: Container(
                                height: screenHeight,
                                width: screenWidth/3,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Form(
                                    key: _key,
                                    child: Column(
                                    children: [
                                      BlocBuilder<ImageBloc, ImageState>(
                                        builder: (context, state) {
                                          print(state.runtimeType);
                                          if(state is ImageInitial){
                                              return GestureDetector(
                                                onTap: () {
                                                  context.read<ImageBloc>().add(ImageUpdateEvent());
                                                },
                                                child: CircleAvatar(
                                                radius: 45,
                                                backgroundImage: NetworkImage(photo!),
                                                // child: Image.network(photo!),
                                         ),
                                              );
                                          }
                                          else if (state is ImageUpdateState){
                                            newImage = state.imageFile;
                                            return GestureDetector(
                                              onTap: () {
                                                context.read<ImageBloc>().add(ImageUpdateEvent());
                                              },
                                              child: CircleAvatar(
                                                radius: 45,
                                                backgroundImage:MemoryImage(state.imageFile) ,
                                              ),
                                            );
                                          }
                                          return CircleAvatar(
                                              radius: 45,
                                              child: IconButton(onPressed: (){}, icon: Icon(Icons.add_a_photo_outlined)),
                                            );
                                        },
                                      ),
                                      SizedBox(height: 10,),
                                      CustomTextField(label: "Name", controller: _nameController,validator: validateFullName,readonly: false),  
                                      CustomTextField(label: "Email", controller: _emailController,validator: validateEmail,readonly: true,),
                                      CustomTextField(label: "Contact", controller: _contactController,validator: validateNumber,readonly: false,),
                                      CustomTextField(label: "Bio", controller: _bioController,maxlines: 4,validator:  (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Please enter some text';
                                              }
                                              return null;
                                            },readonly: false,),
                                      SizedBox(height: 30,),
                                      ElevatedButton(onPressed: (){
                                        if(_nameController.text == state.mentorData['name'] && _emailController.text == state.mentorData['email'] && _contactController.text == state.mentorData['contact'] && photo == state.mentorData['photo']){
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No changes made for updation")));
                                        }
                                        else{
                                          //proceed to update
                                          updateMentor(context);
                                        }
                                      }, child: Text("Update")),
                                      SizedBox(height: 30,),
                                      TextButton(onPressed: ()async{
                                        await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text);
                                        _resetPassDialog(context);
                                      }, child: Text("Reset Password"))                                    ],
                                  )),
                                ),
                              ),
                            );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  //reset link sent alert
  Future<void> _resetPassDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        // title: const Text('AlertDialog Title'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Reset Password'),
              Text('Link is being send to the respective email'),
            ],
          ),
        ),
      );
    },
  );
}

  //proceed to update
    void updateMentor(BuildContext context)async{
      if(_key.currentState!.validate()){
        print(1);
        firebasestorage.Reference ref = firebasestorage.FirebaseStorage.instance.ref("mentor_${_nameController.text.trim()}");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Uploading data !"),backgroundColor: Colors.blue,));
        firebasestorage.UploadTask uploadTask = ref.putData(newImage!);
        await uploadTask;
        var downloadURL = await ref.getDownloadURL();
        String mentorId = FirebaseAuth.instance.currentUser!.uid;
        Map<String,String> data = {
          'name' : _nameController.text.trim(),
          'contact' : _contactController.text.trim(),
          'qualification' : _bioController.text.trim(),
          'photo' : downloadURL
        };
        context.read<MentorBloc>().add(UpdateMentorEvent(data: data, mentorId: mentorId));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Profile updated !"),backgroundColor: Colors.green,));
        context.read<MentorBloc>().add(mentorLoadEvent(email: FirebaseAuth.instance.currentUser!.email!));
      }
    }

  //to validate number
   String? validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile number is required';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Please enter only digits';
    }
    if (value.length != 10) {
      return 'Mobile number must be 10 digits long';
    }
    return null;
  }

  //to validate full name
String? validateFullName(String? value) {
  
  final trimmedValue = value?.trim();

  if (trimmedValue == null || trimmedValue.isEmpty) {
    return 'Full Name is required';
  }

  final RegExp nameRegExp = RegExp(r'^[a-zA-Z ]+$');

  if (!nameRegExp.hasMatch(trimmedValue)) {
    return 'Full Name can only contain letters and spaces';
  }

  return null; 
}

//to validate email
String? validateEmail(String? value) {
  
  final trimmedValue = value?.trim();

  if (trimmedValue == null || trimmedValue.isEmpty) {
    return 'Email is required';
  }

  final RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
  );

  if (!emailRegExp.hasMatch(trimmedValue)) {
    return 'Invalid email address';
  }

  return null; 
}


}
