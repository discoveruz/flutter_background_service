import 'package:backgroud_service/pages/second_page.dart';
import 'package:flutter/material.dart';

class OtherPage extends StatelessWidget {
  const OtherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Other Page"),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SecondPage(),
                ),
              );
            },
            child: const Text("Second Page"),
          ),
          //back button
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Back"),
          ),
        ],
      ),
    );
  }
}
