import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_quiz/bloc/word_state.dart';
import '../models/word.dart';

class WordCubit extends Cubit<WordState> {
  WordCubit() : super(const WordState()) {
    loadWords();
  }

  void loadWords() {
    List<Word> words = [
      Word(
          image:
              "https://bygame.ru/uploads/ai/4-fotki-1-slovo-new/6/1.webp?v=1682812404",
          word: "музыка"),
      Word(
          image:
              "https://bygame.ru/uploads/ai/4-fotki-1-slovo-new/6/3.webp?v=1682812404",
          word: "стекло"),
      Word(
          image:
              "https://bygame.ru/uploads/ai/4-fotki-1-slovo-new/5/37.webp?v=1682812404",
          word: "песок"),
      Word(
          image:
              "https://bygame.ru/uploads/ai/4-fotki-1-slovo-new/5/53.webp?v=1682812404",
          word: "синий"),
      Word(
          image:
              "https://bygame.ru/uploads/ai/4-fotki-1-slovo-new/5/66.webp?v=1682812404",
          word: "холод"),
      Word(
          image:
              "https://bygame.ru/uploads/ai/4-fotki-1-slovo-new/6/57.webp?v=1682812404",
          word: "ловить"),
    ];

    emit(state.copyWith(words: words));
    shuffleLetters();
  }

  void addCharacter(String character) {
    List<String> updatedUserWord = List.from(state.userWord)..add(character);
    emit(state.copyWith(userWord: updatedUserWord));
  }

  void removeCharacter(int index) {
    if (state.userWord.isNotEmpty && index < state.userWord.length) {
      List<String> updatedUserWord = List.from(state.userWord)..removeAt(index);
      emit(state.copyWith(userWord: updatedUserWord));
    }
  }

  void nextWord() {
    if (state.words.isNotEmpty) {
      List<Word> updatedWords = List.from(state.words)..removeAt(0);
      emit(state.copyWith(
          words: updatedWords, userWord: [], completed: updatedWords.isEmpty));

      if (updatedWords.isNotEmpty) {
        shuffleLetters();
      }
    }
  }

  void shuffleLetters() {
    if (state.words.isNotEmpty) {
      final word = state.words[0].word;
      List<String> letters = word.characters.toList();
      if (letters.length < 12) {
        letters.addAll(List.generate(12 - letters.length,
            (_) => characters[Random().nextInt(characters.length)]));
      }
      letters.shuffle();
      emit(state.copyWith(shuffledLetters: letters));
    }
  }
}
