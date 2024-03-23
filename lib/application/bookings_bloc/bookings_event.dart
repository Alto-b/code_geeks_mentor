part of 'bookings_bloc.dart';

 class BookingsEvent extends Equatable {
  const BookingsEvent();

  @override
  List<Object> get props => [];
}

class BookingsLoadEvent extends BookingsEvent{}

class AcceptBookingEvent extends BookingsEvent{
  String  bookingId;
  Map<String,dynamic> data = {};
  AcceptBookingEvent({
    required this.bookingId,
    required this.data
  });
}