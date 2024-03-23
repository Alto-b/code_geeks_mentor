import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_geeks_mentor/domain/bookings_model.dart';
import 'package:flutter/material.dart';

class BookingsRepo{
  Future<List<BookingsModel>> getUpcomingSubs() async{
    List<BookingsModel> upcomingList = [];
    try{
      final datas = await FirebaseFirestore.instance.collection("bookings")
      .where('status',isEqualTo: 'pending').get();
      datas.docs.forEach((element) {
          final data = element.data();

          final upcoming = BookingsModel(
            booking_id: data['booking_id'], 
            booking_amount: data['booking_amount'], 
            date: data['date'], 
            expiry: data['expiry'], 
            guide_id: data['guide_id'], 
            status: data['status'], 
            sub_id: data['sub_id'], 
            sub_lang: data['sub_lang'], 
            sub_photo: data['sub_photo'], 
            sub_title: data['sub_title'], 
            user_id: data['user_id'],
            user_name: data['user_name'],
            user_avatar: data['user_avatar'],
            guide_name: data['guide_name'],
            guide_photo: data['guide_photo']);

            upcomingList.add(upcoming);
      });
      return upcomingList;
    }
    on FirebaseException catch(e){
        debugPrint("expection getting upcoming. : ${e.message}");
    }
    return upcomingList;
  }

  Future<List<BookingsModel>> getOngoingSubs()async{
    List<BookingsModel>  onGoingList = [];
    try{
      final datas = await FirebaseFirestore.instance.collection("bookings")
                    .where('status',isEqualTo: 'ongoing').get();
      datas.docs.forEach((element) {
        final data = element.data();
        final upcoming = BookingsModel(
          booking_id: data['booking_id'], 
            booking_amount: data['booking_amount'], 
            date: data['date'], 
            expiry: data['expiry'], 
            guide_id: data['guide_id'], 
            status: data['status'], 
            sub_id: data['sub_id'], 
            sub_lang: data['sub_lang'], 
            sub_photo: data['sub_photo'], 
            sub_title: data['sub_title'], 
            user_id: data['user_id'],
            user_name: data['user_name'],
            user_avatar: data['user_avatar'],
            guide_name: data['guide_name'],
            guide_photo: data['guide_photo']
        );
        onGoingList.add(upcoming);
      });
      return onGoingList;
    }
    on FirebaseException catch(e){
      debugPrint("expection getting ongoing : ${e.message}");
    }
    return onGoingList;
  }
}