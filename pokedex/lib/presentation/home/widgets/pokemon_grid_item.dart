import 'package:pk_shared/dependencies/go_router.dart';
import 'package:flutter/material.dart';
import 'package:pk_shared/shared/config/constants.dart';
import 'package:pk_shared/shared/config/theme.dart';
import 'package:pk_shared/shared/core/widgets/image.dart';
import 'package:pk_shared/shared/model/pokemon.dart';
import 'package:pk_shared/extension/string.dart';

class PokemonGridItem extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonGridItem(this.pokemon, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/info/${pokemon.id}'),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Insets.xs),
          color: Colors.white,
        ),
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            Hero(
              tag: ValueKey(pokemon.id),
              child: HostedImage(
                pokemon.imageUrl,
                height: 120,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(Insets.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    pokemon.pokedexId,
                    style: const TextStyle(
                      color: AppColors.textBodyColor,
                    ),
                  ),
                  Text(
                    pokemon.name.capitalize(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
