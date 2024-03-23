import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_geeks_mentor/domain/bookings_model.dart';
import 'package:code_geeks_mentor/infrastructure/chat_repo.dart';
import 'package:equatable/equatable.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatRepo chatRepo = ChatRepo();
  ChatBloc(this.chatRepo) : super(ChatInitial()) {
    on<ChatUsersLoadEvent>(loadChatUsersList);
    on<SpecificChatLoadEvent>(loadSpecificChat);
    // on<AllPageLoadEvent>(loadAllData);
  }

  FutureOr<void> loadChatUsersList(ChatUsersLoadEvent event, Emitter<ChatState> emit)async{
    final chatList = await chatRepo.getChatUsersList(event.guideId);
    if(chatList.length<=0){

    }
    else{
      emit(ChatUsersLoadedState(chatList: chatList));
    }
  }

  FutureOr<void> loadSpecificChat(SpecificChatLoadEvent event, Emitter<ChatState> emit)async{
    final chatList = await chatRepo.getChatUsersList(event.guide_id);
    emit(SpecificChatLoadedState(bookingId: event.booking_id,chatList: chatList));
  }

  // FutureOr<void> loadAllData(AllPageLoadEvent event, Emitter<ChatState> emit)async{
  //   final chatList = await chatRepo.getChatUsersList(event.guideId);
  //   emit(AllChatState(chatList: chatList, bookingId: event.booking_id));
  // }
}
