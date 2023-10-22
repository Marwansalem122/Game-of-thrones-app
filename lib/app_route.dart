import 'package:bloc_test/business_logic/cubit/character_cubit.dart';
import 'package:bloc_test/constant/string.dart';
import 'package:bloc_test/data/models/characters.dart';
import 'package:bloc_test/data/repositry/characters_repository.dart';
import 'package:bloc_test/data/web_services/character_web_services.dart';
import 'package:bloc_test/presentation/screens/character_details_screen.dart';
import 'package:bloc_test/presentation/screens/characters_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoute {
  late CharactersRepository charactersRepository;
  late CharacterCubit characterCubit;
  AppRoute() {
    charactersRepository =
        CharactersRepository(characterswebservices: CharactersWebServices());
    characterCubit = CharacterCubit(charactersRepository);
  }
  Route? generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case charactersScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => characterCubit,
                  child: CharactersScreen(),
                ));
      case charactersDetailScreen:
        final character = setting.arguments as Character;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) =>characterCubit,
                child: CaracterDtailsScreen(
                  character: character,
                )));

      default:
    }
    return null;
  }
}
