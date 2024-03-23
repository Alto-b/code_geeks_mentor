import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_geeks_mentor/domain/mentor_model.dart';

class MentorRepo{

  Future<Map<String,dynamic>?> getMentorByEmail(String email)async{
    List<MentorModel> mentorLoginList = [];
    try{
      final mentorSnapshot = await FirebaseFirestore.instance.collection("mentors")
                    .where('email',isEqualTo: email).limit(1).get();
      if(mentorSnapshot.docs.isNotEmpty){
        var mentorData = mentorSnapshot.docs.first.data();
        return mentorData;
      }
      else{
        return null;
      }
    }
    on FirebaseException catch(e){
      print("error fetching mentor data for login : ${e.message}");
      return null;
    }
  }

 

}