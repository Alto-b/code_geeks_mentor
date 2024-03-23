import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<AddPostEvent>(addPostToFirebase);
  }

  FutureOr<void> addPostToFirebase(AddPostEvent event, Emitter<PostState> emit)async{
    try{
      await FirebaseFirestore.instance.collection("post")
      .doc(event.postId)
      .set(event.data).whenComplete((){
        debugPrint("post successful");
      });
    }
    on FirebaseException catch(e){
      debugPrint("post failed ${e.message}");
    }
  }
}
