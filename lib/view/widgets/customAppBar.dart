import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset("assets/images/appbar-icon.png"),
        Text("Samayal Kurippu", style: TextStyle(fontSize: 17)),
      ],
    );
  }
}
