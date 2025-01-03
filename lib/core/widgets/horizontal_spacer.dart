import 'package:flutter/material.dart';

class HorizontalSpacer extends StatelessWidget {
  final double size;

  const HorizontalSpacer(this.size, {Key? key}) : super(key: key);

  const HorizontalSpacer.small({Key? key}) : this(8, key: key);

  const HorizontalSpacer.medium({Key? key}) : this(16, key: key);

  const HorizontalSpacer.large({Key? key}) : this(24, key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: size);
  }
}
