import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_quiz/controllers/getx_word_controller.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});

  final wordController = Get.put(GetxWordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Guess the word"),
      ),
      body: Obx(() {
        if (wordController.words.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        if (wordController.userWord.join() == wordController.words[0].word) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("dsdsdsdsdsds"),
              );
            },
          );
        }

        final word = wordController.words[0].word;
        List<String> letters = word.characters.toList();
        if (letters.length < 12) {
          letters.addAll(List.generate(
            12 - letters.length,
            (_) => characters[Random().nextInt(characters.length)],
          ));
        }
        letters.shuffle();

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
                    return Container(
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
                          );
                        }),
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
                          wordController.addCharacter(letters[index]);
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
                          child: Text(
                            letters[index],
                            style: const TextStyle(color: Colors.white),
                          ),
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
