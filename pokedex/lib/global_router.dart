import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pk_http_client/app/client/http_client.dart';
import 'package:pk_http_client/app/interceptors/autorization_interceptor.dart';
import 'package:pk_shared/dependencies/dependencies.dart';
import 'package:pk_shared/extension/go_router.dart';
import 'package:pokedex/data/pokemon_remote_datasource.dart';
import 'package:pokedex/presentation/bloc/pokemon_cubit.dart';
import 'package:pokedex/presentation/home/app_scaffold.dart';
import 'package:pokedex/presentation/pokemon_info/pokemon_info.dart';
import 'package:pokedex/repository/pokemon_repository.dart';

// GetIt
final getIt = GetIt.I;

// GoRouter configuration
final globalRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        onGlobalBinding(context);
        return const AppScaffoldPage();
      },
      onExit: onDispose,
    ),
    GoRoute(
      path: '/info/:id',
      builder: (context, state) {
        final int id = int.tryParse(state.params('id')) ?? 0;
        return BlocProvider(
          create: (context) => GetIt.I.get<PokemonCubit>()..getPokemons(),
          child: PokemonInfoPage(id),
        );
      },
    ),
  ],
);

void onGlobalBinding(BuildContext context) {
  final interceptors = [
    AutorizationInterceptor(),
    // LogInterceptor(),
  ];

  if (!getIt.isRegistered<Dio>()) {
    getIt.registerSingleton(Dio());
  }

  if (!getIt.isRegistered<HttpClient>()) {
    getIt.registerSingleton(
      HttpClient(getIt.get(), interceptors: interceptors),
    );
  }

  if (!getIt.isRegistered<PokedexRemoteDataSource>()) {
    getIt.registerFactory(
      () => PokedexRemoteDataSource(getIt.get<HttpClient>()),
    );
  }

  if (!getIt.isRegistered<PokemonRepository>()) {
    getIt.registerFactory(
      () => PokemonRepository(getIt.get<PokedexRemoteDataSource>()),
    );
  }

  if (!getIt.isRegistered<PokemonCubit>()) {
    getIt.registerFactory(
      () => PokemonCubit(pokemonRepository: getIt.get()),
    );
  }
}

FutureOr<bool> onDispose(BuildContext context) {
  getIt.unregister<Dio>();
  getIt.unregister<HttpClient>();
  getIt.unregister<PokedexRemoteDataSource>();
  getIt.unregister<PokemonRepository>();

  return true;
}
