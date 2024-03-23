part of 'post_bloc.dart';

sealed class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class AddPostEvent extends PostEvent{
  Map<String,String> data = {};
  String postId;
  AddPostEvent({
    required this.data,
    required this.postId
  });
}
