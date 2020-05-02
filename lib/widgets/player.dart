import 'package:flutter/material.dart';

class Player extends StatelessWidget {
  const Player({Key key, this.points, this.started, this.p, this.player})
      : super(key: key);

  final int points;
  final bool started;
  final List p;
  final String player;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: '$player: ',
                      style: TextStyle(fontSize: 40, color: Colors.yellow)),
                  TextSpan(text: '$points', style: TextStyle(fontSize: 40)),
                ])),
              ),
              RichText(
                text: TextSpan(
                    text: 'Next card:', style: TextStyle(fontSize: 20)),
              ),
              SizedBox(height: height / 100),
              Image(
                height: height / 4.6,
                width: width / 4,
                image: AssetImage(
                    'assets/${!started && points == 0? p[0] : p.length > 1 ? p[1] : 'blank'}.png'),
                gaplessPlayback: true,
              ),
              SizedBox(height: height / 100),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: 'Cards left: ${p.length}',
                    style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Image(
            height: height / 2.65,
            width: width / 2.2,
            image: AssetImage(
                'assets/${!started && points == 0? "red_back" : p.length > 0 ? p[0] : 'blank'}.png'),
            gaplessPlayback: true,
          ),
        ),
      ],
    );
  }
}
