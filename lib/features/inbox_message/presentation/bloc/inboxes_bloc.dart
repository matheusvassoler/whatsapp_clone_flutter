import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:whatsapp/features/inbox_message/domain/entities/inbox.dart';

part 'inboxes_event.dart';
part 'inboxes_state.dart';

class InboxesBloc extends Bloc<InboxesEvent, InboxesState> {
  InboxesBloc() : super(Empty());

  @override
  Stream<InboxesState> mapEventToState(
    InboxesEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
