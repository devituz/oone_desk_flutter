import 'package:flutter/material.dart';

import '../../widgets/custom_appbar.dart';


class Cabinet extends StatelessWidget {
  const Cabinet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(),
    );
  }
}
