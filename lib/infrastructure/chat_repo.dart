import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_geeks_mentor/domain/bookings_model.dart';
import 'package:flutter/material.dart';

class ChatRepo{
    
    Future<List<BookingsModel>> getChatUsersList(String guide_id)async{
      List<BookingsModel> chatList = [];
      try{
        final datas = await FirebaseFirestore.instance.collection("bookings")
        .where('guide_id',isEqualTo: guide_id)
        // .orderBy('date')
        .get();

        datas.docs.forEach((element) {
          final data = element.data();
          final user = BookingsModel(
            booking_id: data['booking_id'], 
            booking_amount: data['booking_amount'], 
            date: data['date'], 
            expiry: data['expiry'], 
            guide_id: guide_id, 
            guide_name: data['guide_name'], 
            guide_photo: data['guide_photo'], 
            status: data['status'], 
            sub_id: data['sub_id'], 
            sub_lang: data['sub_lang'], 
            sub_photo: data['sub_photo'], 
            sub_title: data['sub_title'], 
            user_id: data['user_id'],
            user_name: data['user_name'],
            user_avatar: data['user_avatar'],);

        chatList.add(user);
        });
        return chatList;
      }
      on FirebaseException catch(e){
        debugPrint("expection getting chat list. : ${e.message}");
      }
      return chatList;
    }
}