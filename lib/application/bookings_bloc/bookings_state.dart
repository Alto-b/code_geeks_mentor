part of 'bookings_bloc.dart';

sealed class BookingsState extends Equatable {
  const BookingsState();
  
  @override
  List<Object> get props => [];
}

final class BookingsInitial extends BookingsState {}

class BookingsLoadedState extends BookingsState{
  final List<BookingsModel> upcomingList;
  final List<BookingsModel> onGoingList;
  BookingsLoadedState({
    required this.upcomingList,
    required this.onGoingList
  });
}
