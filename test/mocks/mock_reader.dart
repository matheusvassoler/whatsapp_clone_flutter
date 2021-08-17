import 'dart:io';

String mock(String fileName) => File('test/mocks/$fileName').readAsStringSync();