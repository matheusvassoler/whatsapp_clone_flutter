import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:whatsapp/features/inbox_message/domain/usecases/get_inboxes.dart';
import 'package:whatsapp/features/inbox_message/presentation/bloc/inboxes_bloc.dart';
import 'package:whatsapp/model/inbox.dart';

class MockGetInboxes extends Mock implements GetInboxes {}

void main() {
  InboxesBloc bloc;
  MockGetInboxes mockGetInboxes;

  setUp(() {
    mockGetInboxes = MockGetInboxes();

    bloc = InboxesBloc(getInboxes: mockGetInboxes);
  });

  test('initialState should be Empty', () {
    expect(bloc.state, equals(Empty()));
  });
  
  group('GetInboxes', () {
    final inboxOwnerNumber = "1234";
    final inboxes = [Inbox(id: 1, lastMessage: "mensagem", hashCodeId: "45", dateOfLastMessage: "10:34", receiptName: "Matheus", picture: "picture", receiptNumber: "1111")];

    test('should emit [Error] whwn the in')
  });
}
