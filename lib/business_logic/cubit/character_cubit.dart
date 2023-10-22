
import 'package:bloc_test/data/models/characters.dart';
import 'package:bloc_test/data/models/quotes.dart';
import 'package:bloc_test/data/repositry/characters_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final CharactersRepository charactersRepository;
   List<Character>myCharacters=[];
   List<Quotes>myQuotes=[];
  CharacterCubit(this.charactersRepository) : super(CharacterInitial());

  List<Character> getAllcharacters(){
    charactersRepository.getAllcharacters().then((characters){
        emit(CharactersLoad(characters));
        myCharacters=characters;
    });
    return myCharacters;
  }
  void getQuote(String characterName) {
    charactersRepository.getQuote(characterName).then((quote) {
     emit(QuotesLoaded(quote));
    });
  }
}
