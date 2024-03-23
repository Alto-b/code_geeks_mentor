part of 'mentor_bloc.dart';

sealed class MentorEvent extends Equatable {
  const MentorEvent();

  @override
  List<Object> get props => [];
}

class mentorLoadEvent extends MentorEvent{
  String email;
  mentorLoadEvent({
    required this.email
  });
}

class UpdateMentorEvent extends MentorEvent{
  Map<String,String> data = {};
  String mentorId;
  UpdateMentorEvent({
    required this.data,
    required this.mentorId
  });
}