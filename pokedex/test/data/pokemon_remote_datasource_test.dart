import 'dart:convert';

import 'package:pk_http_client/app/client/http_client_base.dart';
import 'package:pk_shared/shared/model/pokemon.dart';
import 'package:pokedex/data/pokemon_remote_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mock/mock_reader.dart';

class MockHttpClientBase extends Mock implements HttpClientBase {}

void main() {
  late HttpClientBase httpClient;
  late IPokedexRemoteDataSource pokedexRemoteDataSource;

  setUp(() {
    httpClient = MockHttpClientBase();
    pokedexRemoteDataSource = PokedexRemoteDataSource(httpClient);
  });
  group('.getAllPokemon', () {
    test('should return pokemon data', () async {
      final json = mockData("pokemon_response.json");
      when(() => httpClient.get(any()))
          .thenAnswer((_) => Future.value(jsonDecode(json)));
      final result = await pokedexRemoteDataSource.getAllPokemon(1);
      expect(result, isA<List<Pokemon>>());
      for (int i = 0; i < result.length; i++) {
        final pokemon = result[i];
        expect(pokemon.id, isNot(-1));
      }
    });
  });

  group('.getPokemon', () {
    test('should return pokemon data', () async {
      final json = {
        'name': 'bulbasaur',
        'url': 'https://pokeapi.co/api/v2/pokemon/1/'
      };
      when(() => httpClient.get(any()))
          .thenAnswer((_) => Future<Map<String, dynamic>>.value(json));
      final result = await pokedexRemoteDataSource.getPokemon(1);
      expect(result, isA<Pokemon>());
    });
  });
}
