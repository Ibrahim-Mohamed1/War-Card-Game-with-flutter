import 'package:flutter/material.dart';
import 'package:War/widgets/contact.dart';
import 'package:War/widgets/tile.dart';
import 'package:url_launcher/url_launcher.dart';

class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var now = new DateTime.now();
    var date =
        '${now.toString().substring(5, 7)}/${now.toString().substring(8, 10)}/${now.toString().substring(0, 4)}';
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Tile(
            leading: Icon(
              Icons.title,
              size: 35,
            ),
            title: Text('Game:'),
            subTitle: Text('War - Card Game'),
          ),
          Tile(
            leading: Icon(
              Icons.create,
              size: 35,
            ),
            title: Text('Creator'),
            subTitle: Text('Ibrahim Mohamed'),
          ),
          Tile(
            leading: Icon(
              Icons.phone_iphone,
              size: 35,
            ),
            title: Text('Version'),
            subTitle: Text('0.1.0'),
          ),
          Tile(
            ontap: () {
              launch('https://war-card-game.flycricket.io/privacy.html');
            },
            leading: Icon(
              Icons.verified_user,
              size: 35,
            ),
            title: Text('Privacy Policy'),
            subTitle: Text('Updated: $date'),
            trailing: Icon(
              Icons.arrow_forward_ios,
            ),
          ),
          Tile(
            ontap: () {
              launch('https://war-card-game.flycricket.io/terms.html');
            },
            leading: Icon(
              Icons.insert_drive_file,
              size: 35,
            ),
            title: Text('Terms of Use'),
            subTitle: Text('Updated: $date'),
            trailing: Icon(
              Icons.arrow_forward_ios,
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            onTap: () => Navigator.push(context,
                new MaterialPageRoute(builder: (context) => Contact())),
            title: Text('Contact Creator'),
            subtitle: Text('Updated: $date'),
            leading: Icon(
              Icons.email,
              size: 35,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
            ),
          ),
        ],
      ),
    );
  }
}
