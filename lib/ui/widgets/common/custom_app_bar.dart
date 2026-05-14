import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    super.key,
    required String title,
    List<Widget>? actions,
  }) : super(
    title: Text(title),
    actions: actions,
  );
}
