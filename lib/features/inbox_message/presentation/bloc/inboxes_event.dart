part of 'inboxes_bloc.dart';

@immutable
abstract class InboxesEvent {}

class GetInboxList extends InboxesEvent {
  final String inboxOwnerPhone;

  GetInboxList(this.inboxOwnerPhone);
}
