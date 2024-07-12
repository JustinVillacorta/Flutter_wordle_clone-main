import 'package:flutter/material.dart';
import 'game_provider.dart';
import 'game_board.dart';

// ignore: must_be_immutable
class GameKeyboard extends StatefulWidget {
  GameKeyboard(this.game, {Key? key}) : super(key: key);
  WorldeGame game;
  @override
  State<GameKeyboard> createState() => _GameKeyboardState();
}

class _GameKeyboardState extends State<GameKeyboard> {
  List row1 = "QWERTYUIOP".split("");
  List row2 = "ASDFGHJKL".split("");
  List row3 = ["DEL", "Z", "X", "C", "V", "B", "N", "M", "SUBMIT"];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          WorldeGame.game_message,
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(
          height: 20.0,
        ),
        GameBoard(widget.game),
        const SizedBox(
          height: 40.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: row1.map((e) {
            return InkWell(
              onTap: () {
                if (widget.game.letterId < 5) {
                  widget.game.insertWord(widget.game.letterId, Letter(e, 0));
                  widget.game.letterId++;
                  setState(() {});
                }
              },
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey.shade300,
                ),
                child: Text(
                  "$e",
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: row2.map((e) {
            return InkWell(
              onTap: () {
                if (widget.game.letterId < 5) {
                  widget.game.insertWord(widget.game.letterId, Letter(e, 0));
                  widget.game.letterId++;
                  setState(() {});
                }
              },
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey.shade300,
                ),
                child: Text(
                  "$e",
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: row3.map((e) {
            return InkWell(
              onTap: () {
                if (e == "DEL") {
                  if (widget.game.letterId > 0) {
                    setState(() {
                      widget.game
                          .insertWord(widget.game.letterId - 1, Letter("", 0));
                      widget.game.letterId--;
                    });
                  }
                } else if (e == "SUBMIT") {
                  // setting the game rules
                  if (widget.game.letterId >= 5) {
                    /* widget.game.wordleBoard[widget.game.rowId].replaceRange(
                      0,
                      5,
                      List.generate(5, (index) => Letter("", 3)),
                    ); */
                    String guess = widget.game.wordleBoard[widget.game.rowId]
                        .map((e) => e.letter)
                        .join();
                    if (widget.game.checkWordExist(guess.toLowerCase())) {
                      if (guess == WorldeGame.game_guess) {
                        setState(() {
                          WorldeGame.game_message = "Congratulations🎉";
                          for (var element
                              in widget.game.wordleBoard[widget.game.rowId]) {
                            element.code = 1;
                          }
                        });
                      } else {
                        int listLength = guess.length;
                        for (int i = 0; i < listLength; i++) {
                          String char = guess[i].toUpperCase();
                          if (WorldeGame.game_guess.contains(char)) {
                            if (WorldeGame.game_guess[i] == char) {
                              setState(() {
                                widget.game.wordleBoard[widget.game.rowId][i]
                                    .code = 1;
                              });
                            } else {
                              setState(() {
                                widget.game.wordleBoard[widget.game.rowId][i]
                                    .code = 2;
                              });
                            }
                          }
                        }
                        widget.game.rowId++;
                        widget.game.letterId = 0;
                      }
                    } else {
                      WorldeGame.game_message =
                          "the word does not exist try again";
                    }
                  }
                } else {
                  if (widget.game.letterId < 5) {
                    widget.game.insertWord(widget.game.letterId, Letter(e, 0));
                    widget.game.letterId++;
                    setState(() {});
                  }
                }
              },
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey.shade300,
                ),
                child: Text(
                  "$e",
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
