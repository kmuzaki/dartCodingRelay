import 'dart:math';
import 'dart:io';

class ListOfWords {
  List<String> words = [
    "Banana",
    "Ear",
    "Apple",
    "Blue",
    "Destruction",
    "Security",
    "Cat"
  ];

  String letterSpace = "";
  int letterUsed = 0;
  int lives = 6;
  int LoopCheck = 0;
  String randomWord = "";
  List<String> letterGuess = [];

  void getRandomWord() {
    Random random = Random();
    int randomIndex = random.nextInt(words.length);
    randomWord = words[randomIndex].toUpperCase();
  }

  void letterAppend() {
    for (int i = 0; i < randomWord.length; i++) {
      letterGuess.add("*");
    }
  }
}

void main() {
  ListOfWords listOfWords = ListOfWords();
  listOfWords.getRandomWord();
  listOfWords.letterAppend();
  print("Letter Guess: ${listOfWords.letterGuess}");
  print("Welcome to hangman, let's start playing : ");
  List<String> guessedLetters = [];
  while (listOfWords.letterGuess != listOfWords.randomWord && listOfWords.lives > 0) {
    String? guess = stdin.readLineSync();
    if (guess?.length == 1) {
      if (guess != " ") {
        if (RegExp(r'^[a-zA-Z]$').hasMatch(guess!)) {
          String upperGuess = guess.toUpperCase();
          if (listOfWords.letterGuess.contains(upperGuess)) {
            print("You already revealed this letter.");
          } else {
            guessedLetters.add(guess);
            if (listOfWords.randomWord.contains(upperGuess)) {
              for (int i = 0; i < listOfWords.randomWord.length; i++) {
                if (listOfWords.randomWord[i] == upperGuess) {
                  listOfWords.letterGuess[i] = upperGuess;
                }
              }
              print("Correct! Letter Guess: ${listOfWords.letterGuess}");
            } else {
              listOfWords.lives--;
              print("Wrong guess! Lives left: "+listOfWords.lives.toString());
            }
            print("You have guessed: $guessedLetters");
          }
        } else {
          print("Please enter a valid alphabet letter.");
        }
      } else {
        print("You have guessed: $guessedLetters");
      }
    } else {
      print("Please enter a single letter.");
    }
  }

  if (listOfWords.lives == 0) {
    print("No more lives, you lost");
  } else {
    print("Well done the word was: ${listOfWords.randomWord}");
  }
}