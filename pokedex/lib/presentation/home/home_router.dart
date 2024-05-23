import 'package:pk_shared/dependencies/go_router.dart';
import 'package:pokedex/presentation/home/app_scaffold.dart';

final homeRouter = GoRoute(
  path: '/',
  builder: (context, state) {
    return const AppScaffoldPage();
  },
);
