import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_geeks_mentor/infrastructure/mentor_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'mentor_event.dart';
part 'mentor_state.dart';

class MentorBloc extends Bloc<MentorEvent, MentorState> {
  MentorRepo mentorRepo = MentorRepo(); 
  MentorBloc(this.mentorRepo) : super(MentorInitial()) {
    on<mentorLoadEvent>(loadMentorDetails);
    on<UpdateMentorEvent>(updateMentorDetails);
  }

  FutureOr<void> loadMentorDetails(mentorLoadEvent event, Emitter<MentorState> emit)async{
    final mentorDetails = await mentorRepo.getMentorByEmail(event.email);
    if(mentorDetails!.isEmpty){
      emit(mentorErrorState());
    }
    else{
      emit(mentorLoadedState(mentorData: mentorDetails));
    }
    
  }

  FutureOr<void> updateMentorDetails(UpdateMentorEvent event, Emitter<MentorState> emit)async{
    try{
      await FirebaseFirestore.instance.collection("mentors")
      .doc(event.mentorId)
      .update(event.data).then((value){
        print("mentor update successfull");
      });
    }
    on FirebaseException catch(e){
        print("updateMentor ${e.message}");
    }
  }
}
