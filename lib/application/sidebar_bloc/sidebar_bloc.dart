import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sidebar_event.dart';
part 'sidebar_state.dart';

class SidebarBloc extends Bloc<SidebarEvent, SidebarState> {
  SidebarBloc() : super(SidebarInitial(index: 0)) {
    on<SidebarEvent>((event, emit) {
      if(event is IndexChangeEvent){
        emit(SidebarInitial(index: event.index));
      }
    });

  }
}
