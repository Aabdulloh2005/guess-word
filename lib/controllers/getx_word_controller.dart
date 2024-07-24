import 'package:get/get.dart';

import '../models/word.dart';

class GetxWordController extends GetxController {
  RxList<String> userWord = <String>[].obs; // Initial bo'sh ro'yxat

  void addCharacter(String character) {
    userWord.add(character);
    print(userWord);
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
          "https://bygame.ru/uploads/ai/4-fotki-1-slovo-new/6/26.webp?v=1682812404",
      word: "сезоны",
    ),
    Word(
      image:
          "https://bygame.ru/uploads/ai/4-fotки-1-slово-new/6/41.webp?v=1682812404",
      word: "баланс",
    ),
    Word(
      image:
          "https://bygame.ru/uploads/ai/4-fotки-1-slово-new/6/43.webp?v=1682812404",
      word: "ломтик",
    ),
  ].obs;
}

List<String> characters = [
  'ё',
  'й',
  'ц',
  'у',
  'к',
  'е',
  'н',
  'г',
  'ш',
  'щ',
  'з',
  'х',
  'ъ',
  'ф',
  'ы',
  'в',
  'а',
  'п',
  'р',
  'о',
  'л',
  'д',
  'ж',
  'э',
  'я',
  'ч',
  'с',
  'м',
  'и',
  'т',
  'ь',
  'б',
  'ю',
];
