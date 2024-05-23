import 'package:pk_shared/pk_shared.dart';
import 'package:pokedex/presentation/bloc/pokemon_cubit.dart';
import 'package:pokedex/presentation/home/widgets/all_pokemon_tab.dart';
import 'package:flutter/material.dart';

class AppScaffoldPage extends StatefulWidget {
  const AppScaffoldPage({Key? key}) : super(key: key);

  @override
  State<AppScaffoldPage> createState() => _AppScaffoldPageState();
}

class _AppScaffoldPageState extends State<AppScaffoldPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I.get<PokemonCubit>()..getPokemons(),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            centerTitle: true,
            title: LocalImage(Assets.images.appLogo.path, height: 32),
          ),
          body: const Column(
            children: [
              _TabBarHeader(),
              Expanded(
                child: AllPokemonTab(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabBarHeader extends StatelessWidget {
  const _TabBarHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      width: double.infinity,
      child: const ColoredBox(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Pokemons',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
