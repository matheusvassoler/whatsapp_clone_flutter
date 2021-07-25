import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:whatsapp/model/contact.dart';
import 'package:whatsapp/repository/contact_repository.dart';

part 'contact_list_state.dart';

class ContactListCubit extends Cubit<ContactListState> {
  final ContactRepository _contactRepository;

  ContactListCubit(this._contactRepository) : super(ContactListInitial());

  Future<void> getContactList() async {
    final contactList = await _contactRepository.fetchContact();
    emit(ContactListLoaded(contactList));
  }
}
