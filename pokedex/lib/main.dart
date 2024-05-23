import 'package:pk_shared/shared/config/constants.dart';
import 'package:pk_shared/shared/config/theme.dart';
import 'package:pokedex/global_router.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: kAppName,
      theme: lightThemeData,
      routerConfig: globalRouter,
    ),
  );
}
