import 'package:pk_http_client/app/client/http_client_base.dart';
import 'package:pk_shared/extension/string.dart';
import 'package:pk_shared/shared/model/pokemon.dart';

abstract class IPokedexRemoteDataSource {
  Future<List<Pokemon>> getAllPokemon(int offset);
  Future<Pokemon> getPokemon(int id);
}

const String baseUrl = 'https://pokeapi.co/api/v2/pokemon';
const int pageLimit = 24;

class PokedexRemoteDataSource implements IPokedexRemoteDataSource {
  final HttpClientBase http;
  PokedexRemoteDataSource(this.http);

  @override
  Future<List<Pokemon>> getAllPokemon(int offset) async {
    final endpoint = '$baseUrl?offset=$offset&limit=$pageLimit';
    final data = await http.get(endpoint);
    final pokemonList = (data['results'] as List).map(
      (pokemon) {
        // the pokemon id is not returned from this api so we have to extract it from
        // the url param
        List<String> urlPaths = (pokemon['url'] as String).split("/");
        final pokemonId = urlPaths[urlPaths.length - 2];
        return Pokemon.fromMap(pokemon).copyWith(
          id: pokemonId.toInt(),
        );
      },
    ).toList();
    return pokemonList;
  }

  @override
  Future<Pokemon> getPokemon(int id) async {
    final data = await http.get('$baseUrl/$id');
    return Pokemon.fromMap(data);
  }
}
