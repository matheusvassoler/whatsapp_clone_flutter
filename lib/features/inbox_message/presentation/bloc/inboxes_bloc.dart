import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:whatsapp/features/inbox_message/domain/entities/inbox.dart';
import 'package:whatsapp/features/inbox_message/domain/usecases/get_inboxes.dart';

part 'inboxes_event.dart';
part 'inboxes_state.dart';

const String SERVER_FAILURE_MESSAGE = "Server failure";
const String CACHE_FAILURE_MESSAGE = "Cache failure";

class InboxesBloc extends Bloc<InboxesEvent, InboxesState> {

  final GetInboxes getInboxes;

  InboxesBloc({@required this.getInboxes})
      : assert(getInboxes != null),
        super(Empty());

  @override
  Stream<InboxesState> mapEventToState(
    InboxesEvent event,
  ) async* {
    if (event is GetInboxList) {
      final inputEither = await getInboxes(Params(inboxOwnerNumber: event.inboxOwnerPhone));
      yield inputEither.fold(
              (l) {
                 return Error(message: 'Some error happened');
              }, (inboxes) {
                return Loaded(inboxes: inboxes);
              });
    }
  }
}
