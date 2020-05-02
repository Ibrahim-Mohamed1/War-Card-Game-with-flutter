import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';
import 'package:War/widgets/player.dart';
import 'package:War/widgets/side_bar.dart';
import 'card_array.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "War",
        home: MyApp(),
      ),
    );

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static List p1;
  static List p2;
  int p1Int;
  int p2Int;
  String won = "";
  int p1Wins = 0;
  int p2Wins = 0;
  int p1Points = 0;
  int p2Points = 0;
  bool started = false;
  List tieCards = [];

  void shuffle() {
    setState(() {
      allCards = allCards.toList()..shuffle();
      p1 = allCards.sublist(0, 26);
      p2 = allCards.sublist(26, 52);
      won = "";
      p1Points = 0;
      p2Points = 0;
    });
  }

  @override
  void initState() {
    shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    double height = MediaQuery.of(context).size.height;
    String p1Percent = p1Wins == 0 && p2Wins == 0
        ? "N/A"
        : ((p1Wins / (p1Wins + p2Wins)) * 100)
                .toString()
                .substring(0, 3)
                .replaceAll(".", "") +
            "%";
    String p2Percent = p1Wins == 0 && p2Wins == 0
        ? "N/A"
        : ((p2Wins / (p1Wins + p2Wins)) * 100)
                .toString()
                .substring(0, 3)
                .replaceAll(".", "") +
            "%";

    cardToString() {
      var p1Card = p1[0].substring(0, p1[0].length - 1);
      var p2Card = p2[0].substring(0, p2[0].length - 1);

      switch (p1Card) {
        case "A":
          p1Card = '14';
          break;
        case "J":
          p1Card = '11';
          break;
        case "Q":
          p1Card = '12';
          break;
        case "K":
          p1Card = '13';
          break;
      }

      switch (p2Card) {
        case "A":
          p2Card = '14';
          break;
        case "J":
          p2Card = '11';
          break;
        case "Q":
          p2Card = '12';
          break;
        case "K":
          p2Card = '13';
          break;
      }
      setState(() {
        p1Int = int.parse(p1Card);
        p2Int = int.parse(p2Card);
      });
    }

    removeCards() {
      if (p1.length == 4) {
        tieCards.add(p1.removeAt(0));
        tieCards.add(p1.removeAt(0));
        tieCards.add(p2.removeAt(0));
        tieCards.add(p2.removeAt(0));
        tieCards.add(p2.removeAt(0));
      } else if (p1.length == 3) {
        tieCards.add(p1.removeAt(0));
        tieCards.add(p2.removeAt(0));
        tieCards.add(p2.removeAt(0));
        tieCards.add(p2.removeAt(0));
      } else if (p1.length == 2 || p1.length == 1) {
        tieCards.add(p2.removeAt(0));
        tieCards.add(p2.removeAt(0));
        tieCards.add(p2.removeAt(0));
      } else if (p2.length == 4) {
        tieCards.add(p1.removeAt(0));
        tieCards.add(p1.removeAt(0));
        tieCards.add(p1.removeAt(0));
        tieCards.add(p2.removeAt(0));
        tieCards.add(p2.removeAt(0));
      } else if (p2.length == 3) {
        tieCards.add(p1.removeAt(0));
        tieCards.add(p1.removeAt(0));
        tieCards.add(p1.removeAt(0));
        tieCards.add(p2.removeAt(0));
        tieCards.add(p2.removeAt(0));
      } else if (p2.length == 2 || p2.length == 1) {
        tieCards.add(p1.removeAt(0));
        tieCards.add(p1.removeAt(0));
        tieCards.add(p1.removeAt(0));
      } else {
        tieCards.add(p1.removeAt(0));
        tieCards.add(p1.removeAt(0));
        tieCards.add(p1.removeAt(0));
        tieCards.add(p1.removeAt(0));
        tieCards.add(p2.removeAt(0));
        tieCards.add(p2.removeAt(0));
        tieCards.add(p2.removeAt(0));
        tieCards.add(p2.removeAt(0));
      }
    }

    winner() {
      if (p1Int > p2Int) {
        setState(() {
          p1.add(p2.removeAt(0));
          p1.add(p1.removeAt(0));
          if (tieCards.length != 0) {
            p1Points += 3;
            for (var i = 0; i < tieCards.length; i++) {
              p1.add(tieCards[i]);
            }
            setState(() {
              tieCards = [];
            });
          }

          p1Points += 1;
        });
      } else if (p1Int < p2Int) {
        setState(() {
          p2.add(p1.removeAt(0));
          p2.add(p2.removeAt(0));
          if (tieCards.length != 0) {
            p2Points += 3;
            for (int i = 0; i < tieCards.length; i++) {
              p2.add(tieCards[i]);
            }
            setState(() {
              tieCards = [];
            });
          }

          p2Points += 1;
        });
      } else {
        removeCards();

        cardToString();

        winner();
      }
    }

    play() {
      if (!started) {
        setState(() {
          started = true;
          if (p1.length == 0 || p2.length == 0) {
            shuffle();
          }
        });
      } else {
        cardToString();
        winner();

        if (p1.length == 0) {
          setState(() {
            won = "Player 2";
            p2Wins++;
          });
        }
        if (p2.length == 0) {
          setState(() {
            won = "Player 1";
            p1Wins++;
          });
        }

        if (won != "") {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => Platform.isIOS
                ? CupertinoAlertDialog(
                    title: Text("$won Wins!"),
                    content: Text("Would you like to play again?"),
                    actions: [
                      CupertinoDialogAction(
                        child: Text("Yes"),
                        onPressed: () {
                          shuffle();
                          Navigator.pop(context);
                        },
                      ),
                      CupertinoDialogAction(
                        child: Text("No"),
                        onPressed: () {
                          setState(() {
                            started = false;
                          });
                          Navigator.pop(context);
                        },
                      )
                    ],
                  )
                : AlertDialog(
                    title: Text("$won Wins!"),
                    content: Text("Would you like to play again?"),
                    actions: [
                      FlatButton(
                        child: Text("Yes"),
                        onPressed: () {
                          shuffle();
                          Navigator.pop(context);
                        },
                      ),
                      FlatButton(
                        child: Text("No"),
                        onPressed: () {
                          setState(() {
                            started = false;
                          });
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
          );
        }
      }
    }

    return Scaffold(
      backgroundColor: Colors.red[900],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red[900],
        title: Container(
          width: 160,
          child: FadeInImage(
              placeholder: AssetImage('assets/placeholder.png'),
              image: AssetImage('assets/logo.png')),
        ),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            splashColor: Colors.transparent,
            icon: Icon(Icons.assessment),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (_) => Platform.isIOS
                    ? CupertinoAlertDialog(
                        title: Text("Stats"),
                        content: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("P1", style: TextStyle(fontSize: 20)),
                                    Text(
                                        "\nWins: ${p1Percent == "00%" ? p1Percent.substring(1, 3) : p1Percent}"),
                                    Text(
                                        "\nLoses: ${p2Percent == "00%" ? p2Percent.substring(1, 3) : p2Percent}"),
                                    Text("\nWon: $p1Wins"),
                                    Text("\nLost: $p2Wins")
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text("P2", style: TextStyle(fontSize: 20)),
                                    Text(
                                        "\nWins: ${p2Percent == "00%" ? p2Percent.substring(1, 3) : p2Percent}"),
                                    Text(
                                        "\nLoses: ${p1Percent == "00%" ? p1Percent.substring(1, 3) : p1Percent}"),
                                    Text("\nWon: $p2Wins"),
                                    Text("\nLost: $p1Wins")
                                  ],
                                ),
                              ],
                            ),
                            Text("\nTotal Games: ${p1Wins + p2Wins}")
                          ],
                        ),
                        actions: <Widget>[
                          CupertinoDialogAction(
                              child: Text("Reset"),
                              onPressed: () {
                                setState(() {
                                  p1Wins = 0;
                                  p2Wins = 0;
                                });
                                Navigator.pop(context);
                              }),
                          CupertinoDialogAction(
                              child: Text("OK"),
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                        ],
                      )
                    : AlertDialog(
                        title: Center(child: Text("Stats")),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text("P1", style: TextStyle(fontSize: 20)),
                                    Text(
                                        "\nWins: ${p1Percent == "00%" ? p1Percent.substring(1, 3) : p1Percent}"),
                                    Text(
                                        "\nLoses: ${p2Percent == "00%" ? p2Percent.substring(1, 3) : p2Percent}"),
                                    Text("\nWins: $p1Wins"),
                                    Text("\nLost: $p2Wins")
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text("P2", style: TextStyle(fontSize: 20)),
                                    Text(
                                        "\nWins: ${p2Percent == "00%" ? p2Percent.substring(1, 3) : p2Percent}"),
                                    Text(
                                        "\nLoses: ${p1Percent == "00%" ? p1Percent.substring(1, 3) : p1Percent}"),
                                    Text("\nWon: $p2Wins"),
                                    Text("\nLost: $p1Wins")
                                  ],
                                ),
                              ],
                            ),
                            Text("\nTotal Games: ${p1Wins + p2Wins}")
                          ],
                        ),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
                              setState(() {
                                p1Wins = 0;
                                p2Wins = 0;
                              });
                              Navigator.pop(context);
                            },
                            child: Text("Reset"),
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("OK"),
                          ),
                        ],
                      ),
              );
            },
            iconSize: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: IconButton(
              splashColor: Colors.transparent,
              onPressed: () {
                Share.share(
                    'Check out the creator of this games website http://ibrahimmohamed.dev',
                    subject: 'Look at this awesome game!');
              },
              icon: Icon(Icons.share),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: SideBar(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: height / 100,
            ),
            Player(
              points: p1Points,
              started: started,
              p: p1,
              player: 'P1',
            ),
            SizedBox(height: height / 100),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                    splashColor: Colors.transparent,
                    onPressed: () {
                      shuffle();
                    },
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.shuffle,
                          size: 30,
                          color: Colors.white,
                        ),
                        Text("Shuffle",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ))
                      ],
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.pink,
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {
                      play();
                    },
                    child: Container(
                      height: 50,
                      width: 118,
                      child: Image(
                        gaplessPlayback: true,
                        image: AssetImage(
                            'assets/${won != "" ? 'ready' : started ? 'deal' : 'ready'}.png'),
                      ),
                    ),
                  ),
                  FlatButton(
                    splashColor: Colors.transparent,
                    onPressed: () {
                      if (won != "") {
                        shuffle();
                      } else {
                        do {
                          play();
                        } while (started);
                      }
                    },
                    child: Column(
                      children: <Widget>[
                        Icon(
                          won == "" ? Icons.fast_forward : Icons.play_arrow,
                          size: 40,
                          color: Colors.white,
                        ),
                        Text(
                          won == "" ? "Faster" : "Play",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: height / 100),
            Player(
              points: p2Points,
              started: started,
              p: p2,
              player: 'P2',
            ),
          ],
        ),
      ),
    );
  }
}
