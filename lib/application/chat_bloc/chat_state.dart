 part of 'chat_bloc.dart';

sealed class ChatState extends Equatable {
  const ChatState();
  
  @override
  List<Object> get props => [];
}

final class ChatInitial extends ChatState {}

class ChatUsersLoadedState extends ChatState{
  final List<BookingsModel> chatList;
  ChatUsersLoadedState({
    required this.chatList
  });
  @override
  List<Object> get props => [chatList];
}

class SpecificChatLoadedState extends ChatState{
   String bookingId;
   final List<BookingsModel> chatList;
  SpecificChatLoadedState({
    required this.bookingId,
    required this.chatList
  });
  @override
  List<Object> get props => [bookingId,chatList];
}

// class AllChatState extends ChatState{
//   final List<BookingsModel> chatList;
//   String bookingId;
//   AllChatState({
//     required this.chatList,
//     required this.bookingId
//   });
// }



