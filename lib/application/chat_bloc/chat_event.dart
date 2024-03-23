part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class ChatUsersLoadEvent extends ChatEvent{
  String guideId;
  ChatUsersLoadEvent({
    required this.guideId
  });
}

class SpecificChatLoadEvent extends ChatEvent{
  String booking_id;
  String guide_id;
  SpecificChatLoadEvent({
    required this.booking_id,
    required this.guide_id
  });
}

// class AllPageLoadEvent extends ChatEvent{
//   String guideId;
//   String booking_id;
//   AllPageLoadEvent({
//     required this.guideId,
//     required this.booking_id
//   });
// }