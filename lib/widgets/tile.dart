import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  final leading;
  final title;
  final subTitle;
  final trailing;
  final ontap;

  const Tile({
    this.title,
    this.ontap,
    this.trailing,
    this.subTitle,
    this.leading,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: ontap,
      contentPadding: EdgeInsets.symmetric(horizontal: 10),
      leading: leading,
      title: title,
      trailing: trailing,
      subtitle: subTitle,
    );
  }
}
