
// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_geeks_mentor/domain/mentor_model.dart';
import 'package:code_geeks_mentor/main.dart';
import 'package:code_geeks_mentor/sidebar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
   LoginPage({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        
        body: Center(
          child: Container(
            width: screenWidth/2+50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20)
            ),
            //parent box
            child: Card(
              elevation: 5,
              shadowColor: const Color.fromARGB(255, 0, 0, 0),
              borderOnForeground: true,
              color: const Color.fromARGB(209, 255, 255, 255),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //left box
                    SizedBox(
                      height: screenHeight/1.5,
                      width: screenWidth/4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  SizedBox(height: screenHeight/6,),
                                  Text("Welcome back",style:GoogleFonts.orbit(fontSize: 20,fontWeight: FontWeight.w800,color: Colors.black54,),),
                                  const SizedBox(height: 10,),
                                  TextFormField(
                                    controller: _emailController,
                                    decoration: const InputDecoration(
                                      hintText: "Enter your email id",
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10
                                      ),
                                      prefixIcon: Icon(Icons.person_2_outlined,color: Colors.grey,size: 15,)
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                  TextFormField(
                                    controller: _passwordController,
                                    decoration: const InputDecoration(
                                      hintText: "Enter your password",
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10
                                      ),
                                      prefixIcon: Icon(Icons.lock,color: Colors.grey,size: 15,)
                                    ),
                                  ),
                                  const SizedBox(height: 30,),

                                  ActionChip.elevated(
                                    backgroundColor: Colors.blue[400],
                                    elevation: 5,
                                    label:  Text("Login",style: GoogleFonts.orbit(color: Colors.white,fontSize: 10),),
                                    onPressed: () {
                                    // loginIn(context);
                                    signInWithMentorCredentials(context,_emailController.text.trim(), _passwordController.text.trim());
                                  },),

                                ],
                              )),
                          )
                        ],
                      ),
                    ),
                    //right box
                    Container(
                      height: screenHeight/1.5,
                      width: screenWidth/4,
                    
                      decoration:  BoxDecoration(
                        border: Border.all(color: Colors.white,width: 0),
                        color: const Color.fromARGB(194, 31, 32, 36),
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Image.asset('lib/assets/logo.png'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }

//   Future<Map<String,dynamic>?> getMentorByEmail(String email)async{
//     List<MentorModel> mentorLoginList = [];
//     try{
//       final mentorSnapshot = await FirebaseFirestore.instance.collection("mentors")
//                     .where('email',isEqualTo: email).limit(1).get();
//       if(mentorSnapshot.docs.isNotEmpty){
//         var mentorData = mentorSnapshot.docs.first.data();
//         return mentorData;
//       }
//       else{
//         return null;
//       }
//     }
//     on FirebaseException catch(e){
//       print("error fetching mentor data for login : ${e.message}");
//       return null;
//     }
//   }

//    Future<bool> validatePassword(String password, Map<String, dynamic> mentorData) async {
//   String storedPassword = mentorData['password'];
//   return password == storedPassword;
// }

//   signInButtonPressed(BuildContext context, String email, String password) async {
//   Map<String, dynamic>? mentorData = await getMentorByEmail(email);
//   if (mentorData != null) {
//     bool isPasswordValid = await validatePassword(password, mentorData);
//     if (isPasswordValid) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Welcome back !'),backgroundColor: Colors.green,));
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       await prefs.setString('mentorEmail', mentorData['email']); 
//       await prefs.setString('mentorId', mentorData['mentorId']); 
//       print(prefs.getString('mentorId'));
//       Future.delayed(const Duration(seconds: 2));
//       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SideBarPage(),), (route) => false);
//       await prefs.setBool(SAVE_KEY_NAME, true);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Credentials incorrect'),backgroundColor: Colors.red,));
//     }
//   } else {
//     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Mentor Profile not found.'),backgroundColor: Colors.red,));
//   }
// }


Future<void> signInWithMentorCredentials(BuildContext context,String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Check if the mentor with the entered email exists
  QuerySnapshot mentorSnapshot = await _firestore
      .collection('mentors')
      .where('email', isEqualTo: email)
      .limit(1)
      .get();

  if (mentorSnapshot.docs.isNotEmpty) {
    // Mentor with the entered email found, check if password matches
    String mentorId = mentorSnapshot.docs.first.id;
    DocumentSnapshot mentorData =
        await _firestore.collection('mentors').doc(mentorId).get();

    if (true) {
      // Password matches, proceed with signInWithEmailAndPassword
      try {
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        // Successful sign-in
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Welcome back !'),backgroundColor: Colors.green,));
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SideBarPage(),), (route) => false);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool(SAVE_KEY_NAME, true);
      }
      on FirebaseException catch (e) {
        // Handle sign-in errors
        print('Error signing in: $e');
        ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(e.message!),backgroundColor: Colors.red,));
      }
    } 
    // else {
    //   // Password does not match
    //   print('Incorrect password');
    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Incorrect password'),backgroundColor: Colors.red,));
    // }
  } else {
    // Mentor with the entered email not found
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Check Email id and password'),backgroundColor: Colors.red,));
    print('Mentor with this email does not exist');
  }
}


}