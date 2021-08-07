part of 'inboxes_bloc.dart';

@immutable
abstract class InboxesEvent {}

class GetInboxes extends InboxesEvent {
  final String inboxOwnerPhone;

  GetInboxes(this.inboxOwnerPhone);
}
