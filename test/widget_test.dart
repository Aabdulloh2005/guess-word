import 'package:flutter_test/flutter_test.dart';
import 'package:mini_quiz/bloc/word_cubit.dart';

void main() {
  group('WordCubit', () {
    late WordCubit wordCubit;

    setUp(() {
      wordCubit = WordCubit();
    });

    tearDown(() {
      wordCubit.close();
    });

    test('harf bosildi m', () {
      wordCubit.addCharacter('м');
      expect(wordCubit.state.userWord, ['м']);
    });

    test('harf bosildi u', () {
      wordCubit.addCharacter('у');
      expect(wordCubit.state.userWord, ['у']);
    });
    test('harf bosildi z', () {
      wordCubit.addCharacter('з');
      expect(wordCubit.state.userWord, ['з']);
    });
    test('harf bosildi  i', () {
      wordCubit.addCharacter('ы');
      expect(wordCubit.state.userWord, ['ы']);
    });
    test('harf ochirildi ы', () {
      wordCubit.addCharacter('ы');
      wordCubit.removeCharacter(3);
      expect(wordCubit.state.userWord, ['ы']);
    });
    test('harf bosildi ы ', () {
      wordCubit.addCharacter('ы');
      expect(wordCubit.state.userWord, ['ы']);
    });
    test('harf bosildi k', () {
      wordCubit.addCharacter('к');
      expect(wordCubit.state.userWord, ['к']);
    });
    test('harf bosildi a', () {
      wordCubit.addCharacter('а');
      expect(wordCubit.state.userWord, ['а']);
    });

    

    test('harflarni aralashtirish', () {
      wordCubit.shuffleLetters();
      expect(wordCubit.state.shuffledLetters, hasLength(12));
    });
  });
}
