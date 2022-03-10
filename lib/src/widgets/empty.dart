
import 'package:flutter/material.dart';

class EmptyLayout extends StatelessWidget {

  final VoidCallback? onPressed;

  const EmptyLayout({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Empty data'),
          ),
          ElevatedButton(
              onPressed: onPressed,
              child: const Text('Retry')
          ),
        ],
      ),
    );
  }

}
