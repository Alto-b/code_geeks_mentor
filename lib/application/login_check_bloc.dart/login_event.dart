part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class CheckLoginEvent extends LoginEvent{
  String email;
  String password;

  CheckLoginEvent({
    required this.email,
    required this.password
  });
}
