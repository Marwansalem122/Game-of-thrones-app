part of 'character_cubit.dart';

@immutable
sealed class CharacterState {}

final class CharacterInitial extends CharacterState {}
 class CharactersLoad extends CharacterState {
 final List<Character> characters;
  CharactersLoad( this.characters);
}
 class CharacterSuccess extends CharacterState {
  
 }
final class CharacterFauilure extends CharacterState {}
 class QuotesLoaded extends CharacterState {
  final String quotes;
  QuotesLoaded( this.quotes);

}
