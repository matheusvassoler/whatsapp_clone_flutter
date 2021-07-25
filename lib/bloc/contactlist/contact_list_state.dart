part of 'contact_list_cubit.dart';

@immutable
abstract class ContactListState {}

class ContactListInitial extends ContactListState {}

class ContactListLoaded extends ContactListState {
  final List<Contact> contactList;

  ContactListLoaded(this.contactList);
}
