import 'package:flutter/widgets.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'No Messages yet!\nGo ahead and ask me what you want!',
        textAlign: TextAlign.center,
      ),
    );
  }
}
