import 'dart:convert';

import 'package:bloc_test/data/models/characters.dart';

import 'package:bloc_test/data/web_services/character_web_services.dart';
import 'package:flutter/services.dart';

class CharactersRepository {
  CharactersWebServices characterswebservices;
  CharactersRepository({
    required this.characterswebservices,
  });

  Future<List<Character>> getAllcharacters() async {
    final characters=await characterswebservices.getAllcharacters();
 
    return characters.map((character) => Character.fromJson(character )).toList();
  }
   Future<String> getQuote(String characterName) async {
  String jsonString = await rootBundle.loadString('assets/quotes.json');
  List<dynamic> jsonData = jsonDecode(jsonString);
  // print(jsonData);
  for (var json in jsonData) {
    if (json["from"] == characterName) {
      return json["quote"];
    }
  }
  return " ";  // Return an empty string if the character name is not found
}
}
