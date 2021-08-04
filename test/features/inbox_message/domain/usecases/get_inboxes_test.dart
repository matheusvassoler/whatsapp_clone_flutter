import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:whatsapp/features/inbox_message/domain/entities/inbox.dart';
import 'package:whatsapp/features/inbox_message/domain/repositories/inbox_repository.dart';
import 'package:whatsapp/features/inbox_message/domain/usecases/get_inboxes.dart';

class MockInboxRepository extends Mock implements InboxRepository {}

void main() {
  GetInboxes usecase;
  MockInboxRepository mockInboxRepository;

  setUp(() {
    mockInboxRepository = MockInboxRepository();
    usecase = GetInboxes(mockInboxRepository);
  });

  final inboxOwnerNumber = "19111111111";
  final inboxes = [Inbox(receiptName: "Lucas", receiptProfilePicture: "picture1", lastMessage: "mensagem", messageDate: "10:40")];

  test('SHOULD get inboxes from the repository', () async {
    // GIVEN
    when(mockInboxRepository.getInboxes(any))
        .thenAnswer((_) async => Right(inboxes));
    // WHEN
    final result = await usecase(Params(inboxOwnerNumber: inboxOwnerNumber));
    // THEN
    expect(result, Right(inboxes));
    verify(mockInboxRepository.getInboxes(inboxOwnerNumber));
    verifyNoMoreInteractions(mockInboxRepository);
  });
}