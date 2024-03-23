import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_geeks_mentor/domain/bookings_model.dart';
import 'package:code_geeks_mentor/infrastructure/bookings_repo.dart';
import 'package:equatable/equatable.dart';

part 'bookings_event.dart';
part 'bookings_state.dart';

class BookingsBloc extends Bloc<BookingsEvent, BookingsState> {
  BookingsRepo bookingsRepo = BookingsRepo();
  BookingsBloc(this.bookingsRepo) : super(BookingsInitial()) {
    on<BookingsLoadEvent>(loadbookings);
    on<AcceptBookingEvent>(acceptSubscriptions);
  }

  FutureOr<void> loadbookings(BookingsLoadEvent event, Emitter<BookingsState> emit)async{
    final upcomingList =await bookingsRepo.getUpcomingSubs();
    final onGoingList = await bookingsRepo.getOngoingSubs();
    emit(BookingsLoadedState(upcomingList: upcomingList,onGoingList:onGoingList ));
  }

  FutureOr<void> acceptSubscriptions(AcceptBookingEvent event, Emitter<BookingsState> emit)async{
    try{
      await FirebaseFirestore.instance.collection("bookings")
      .doc(event.bookingId)
      .update(event.data).then((value){
        print("acceptSubs success");
      });
    }
    on FirebaseException catch(e){
      print("acceptSubs ${e.message}");
    }
  }
}
