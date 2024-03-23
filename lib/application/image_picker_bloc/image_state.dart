part of 'image_bloc.dart';

sealed class ImageState extends Equatable {
  const ImageState();
  
  @override
  List<Object> get props => [];
}

final class ImageInitial extends ImageState {}

class ImageUpdateState extends ImageState{
  final Uint8List imageFile;
  ImageUpdateState({
    required this.imageFile
  });
}