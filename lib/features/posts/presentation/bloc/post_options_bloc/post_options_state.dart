part of 'post_options_bloc.dart';

abstract class PostOptionsState extends Equatable {
  const PostOptionsState();

  @override
  List<Object> get props => [];
}

class PostOptionsInitial extends PostOptionsState {}

class OptionsState extends PostOptionsState {}

class LoadingPostOptionsState extends PostOptionsState {}

class ErorrPostOptionsState extends PostOptionsState {
  final String message;

  const ErorrPostOptionsState({required this.message});

  @override
  List<Object> get props => [message];
}

class MessagePostOptionsState extends PostOptionsState {
  final String message;

  const MessagePostOptionsState({required this.message});
  @override
  List<Object> get props => [message];
}
