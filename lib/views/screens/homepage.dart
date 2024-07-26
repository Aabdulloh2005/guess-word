import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_quiz/controllers/getx_word_controller.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key}) {
    wordController.generateShuffledLetters();
  }

  final wordController = Get.put(GetxWordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Guess the word by photo"),
      ),
      body: Obx(() {
        if (wordController.words.isEmpty) {
          return const Center(
              child: Text(
            "Congratulations! You've completed the game.",
            style: TextStyle(color: Colors.blue, fontSize: 24),
          ));
        }
        if (wordController.userWord.join() == wordController.words[0].word) {
          Future.delayed(Duration.zero, () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Correct!"),
                  content: const Text("You guessed the word!"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        wordController.nextWord();
                        Navigator.of(context).pop();
                      },
                      child: const Text("Next Word"),
                    ),
                  ],
                );
              },
            );
          });
        }

        final word = wordController.words[0].word;
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: wordController.words.length,
                  itemBuilder: (context, index) {
                    final word = wordController.words[index];
                    return Image.network(
                      word.image,
                      scale: 1.1,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(child: Icon(Icons.error));
                      },
                    );
                  },
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 60,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (index < wordController.userWord.length) {
                          wordController.removeCharacter(index);
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Obx(() {
                            return Text(
                              wordController.userWord.length > index
                                  ? wordController.userWord[index].toString()
                                  : '',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            );
                          }),
                        ),
                      ),
                    );
                  },
                  childCount: word.length,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 60,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (wordController.userWord.length <
                            wordController.words[0].word.length) {
                          wordController.addCharacter(
                              wordController.shuffledLetters[index]);
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Obx(() {
                            return Text(
                              wordController.shuffledLetters[index],
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            );
                          }),
                        ),
                      ),
                    );
                  },
                  childCount: 12,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
