part of 'inboxes_bloc.dart';

@immutable
abstract class InboxesState {}

class Empty extends InboxesState {}

class Loading extends InboxesState {}

class Loaded extends InboxesState {
  final List<Inbox> inboxes;

  Loaded({@required this.inboxes});
}

class Error extends InboxesState {
  final String message;

  Error({@required this.message});
}

