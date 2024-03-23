import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker_web/image_picker_web.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(ImageInitial()) {
    on<ImageUpdateEvent>(updateImage);
  }

  FutureOr<void> updateImage(ImageUpdateEvent event, Emitter<ImageState> emit)async{
    try{
      Uint8List? file =await ImagePickerWeb.getImageAsBytes();
      emit(ImageUpdateState(imageFile: file!));
    }
    catch(e){
      print("Exception occured while picking mentor profile image $e");
    }
  }
}
