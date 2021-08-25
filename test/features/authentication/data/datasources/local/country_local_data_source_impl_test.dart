import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/mockito.dart';
import 'package:whatsapp/features/authentication/data/datasources/local/country_local_data_source_impl.dart';
import 'package:whatsapp/features/authentication/data/models/country_model_local.dart';

class MockHive extends Mock implements HiveInterface {}
class MockHiveBox extends Mock implements Box {}

main() {
  MockHive mockHive;
  MockHiveBox mockHiveBox;
  CountryLocalDataSourceImpl countryLocalDataSourceImpl;

  setUp(() {
    mockHive = MockHive();
    mockHiveBox = MockHiveBox();
    countryLocalDataSourceImpl = CountryLocalDataSourceImpl(hive: mockHive);
  });

  test('SHOULD store countries locally', () async {
    // ARRANGE
    final countries = [CountryModelLocal(), CountryModelLocal()];
    when(mockHive.openBox(any)).thenAnswer((realInvocation) async => mockHiveBox);
    when(mockHiveBox.put(any, any)).thenAnswer((realInvocation) => null);
    // ACT
    await countryLocalDataSourceImpl.storeCountries(countries);
    // ASSERT
    verify(mockHive.openBox('countries'));
    verify(mockHiveBox.put('countries_list', countries));
  });
}