import 'package:flutter/material.dart';

class CustomBody extends StatelessWidget {
  final Widget child;
  final String backgroundImage;

  const CustomBody({
    super.key,
    required this.child,
    this.backgroundImage = "assets/images/bg.png",
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImage),
          fit: BoxFit.cover,
        ),
      ),
      child: child, // যেটা পাঠাবি সেটা 그대로 show করবে
    );
  }
}
