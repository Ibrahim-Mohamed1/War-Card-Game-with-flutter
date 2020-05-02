import 'package:flutter/material.dart';
import 'package:War/widgets/tile.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        centerTitle: true,
        title: Text('Contact'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
                onPressed: () {
                  Share.share(
                      'Check out the creator of this games website http://ibrahimmohamed.dev',
                      subject: 'Look at this awesome game!');
                },
                icon: Icon(Icons.share)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Tile(
              ontap: () {
                launch('mailto:ibrahim.mohamed.dev@gmail.com');
              },
              title: Text('Email Creator'),
              subTitle: Text('ibrahim.mohamed.dev@gmail.com'),
              leading: Icon(
                Icons.alternate_email,
                size: 35,
              ),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Tile(
              ontap: () {
                launch('https://github.com/ibrahim-mohamed1');
              },
              title: Text('Creator\'s GitHub'),
              subTitle: Text('github.com/ibrahim-mohamed1'),
              leading: Icon(
                Icons.code,
                size: 35,
              ),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Tile(
              ontap: () {
                launch('https://linkedin.com/in/ibrahim-mohamed-m');
              },
              title: Text('Creator\'s LinkedIn'),
              subTitle: Text('linkedin.com/in/ibrahim-mohamed-m'),
              leading: Icon(
                Icons.portrait,
                size: 35,
              ),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Tile(
              ontap: () {
                launch('https://ibrahimmohamed.dev');
              },
              title: Text('Creator\'s Website'),
              subTitle: Text('ibrahimmohamed.dev'),
              leading: Icon(
                Icons.web,
                size: 35,
              ),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      ),
    );
  }
}
