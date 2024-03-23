part of 'image_bloc.dart';

sealed class ImageEvent extends Equatable {
  const ImageEvent();

  @override
  List<Object> get props => [];
}

class ImageUpdateEvent extends ImageEvent{}
