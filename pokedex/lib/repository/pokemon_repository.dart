import 'package:pk_shared/shared/core/error/failure.dart';
import 'package:pk_shared/shared/core/utils/either.dart';
import 'package:pk_shared/shared/model/pokemon.dart';
import 'package:pokedex/data/pokemon_remote_datasource.dart';

class PokemonRepository {
  final IPokedexRemoteDataSource pokemonRemoteDataSource;
  PokemonRepository(this.pokemonRemoteDataSource);

  Future<Either<Failure, List<Pokemon>>> getAllPokemon(int offset) =>
      runGuard(() async {
        final pokemonList = await pokemonRemoteDataSource.getAllPokemon(offset);
        return pokemonList;
      });

  Future<Either<Failure, Pokemon>> getPokemon(int id) => runGuard(() async {
        final pokemon = await pokemonRemoteDataSource.getPokemon(id);
        return pokemon;
      });
}
