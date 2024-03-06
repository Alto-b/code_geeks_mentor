part of 'sidebar_bloc.dart';

 class SidebarState extends Equatable {
  const SidebarState();
  
  @override
  List<Object> get props => [];
}

final class SidebarInitial extends SidebarState {
  final int index;
  SidebarInitial({
    required this.index
  });

  
}
