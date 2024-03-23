part of 'mentor_bloc.dart';

sealed class MentorState extends Equatable {
  const MentorState();
  
  @override
  List<Object> get props => [];
}

final class MentorInitial extends MentorState {}

class mentorLoadedState extends MentorState{
  Map<String,dynamic> mentorData;
  mentorLoadedState({
    required this.mentorData
  });
}

class mentorErrorState extends MentorState{}