import 'package:flutter/material.dart';

class VerticalSpacer extends StatelessWidget {
  final double size;

  const VerticalSpacer(this.size, {Key? key}) : super(key: key);

  const VerticalSpacer.small({Key? key}) : this(8, key: key);

  const VerticalSpacer.medium({Key? key}) : this(16, key: key);

  const VerticalSpacer.large({Key? key}) : this(24, key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: size);
  }
}
