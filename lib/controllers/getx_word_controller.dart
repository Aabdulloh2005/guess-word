import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/word.dart';

class GetxWordController extends GetxController {
  RxList<String> userWord = <String>[].obs; // Initial empty list
  RxList<String> shuffledLetters = <String>[].obs; // Store shuffled letters

  void addCharacter(String character) {
    userWord.add(character);
  }

  void removeCharacter(int index) {
    if (userWord.isNotEmpty && index < userWord.length) {
      userWord.removeAt(index);
    }
  }

  RxList<Word> words = <Word>[
    Word(
      image:
          "https://bygame.ru/uploads/ai/4-fotki-1-slovo-new/6/1.webp?v=1682812404",
      word: "музыка",
    ),
    Word(
      image:
          "https://bygame.ru/uploads/ai/4-fotki-1-slovo-new/6/3.webp?v=1682812404",
      word: "стекло",
    ),
    Word(
      image:
          "https://bygame.ru/uploads/ai/4-fotki-1-slovo-new/5/37.webp?v=1682812404",
      word: "песок",
    ),
    Word(
      image:
          "https://bygame.ru/uploads/ai/4-fotki-1-slovo-new/5/53.webp?v=1682812404",
      word: "синий",
    ),
    Word(
      image:
          "https://bygame.ru/uploads/ai/4-fotki-1-slovo-new/5/66.webp?v=1682812404",
      word: "холод",
    ),
    Word(
      image:
          "https://bygame.ru/uploads/ai/4-fotki-1-slovo-new/6/57.webp?v=1682812404",
      word: "ловить",
    ),
  ].obs;

  void resetUserWord() {
    userWord.clear();
  }

  void nextWord() {
    if (words.isNotEmpty) {
      words.removeAt(0);
      resetUserWord();
      generateShuffledLetters();
    }
  }

  void generateShuffledLetters() {
    if (words.isNotEmpty) {
      final word = words[0].word;
      List<String> letters = word.characters.toList();
      if (letters.length < 12) {
        letters.addAll(List.generate(
          12 - letters.length,
          (_) => characters[Random().nextInt(characters.length)],
        ));
      }
      letters.shuffle();
      shuffledLetters.assignAll(letters);
    }
  }
}
