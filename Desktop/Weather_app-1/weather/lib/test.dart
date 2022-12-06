import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:flutter/material.dart';

// * Once the onboarding process is completed you will be taken to this screen
class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // * Getting the AtClientManager instance to use below
    AtClientManager atClientManager = AtClientManager.getInstance();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Page'),
      ),
      body: Center(
        child: Column(children: [
          const Text('You have made it to the test page'),

          // * Use the AtClientManager instance to get the AtClient
          // * Then use the AtClient to get the current @sign
          // Text('Current @sign: ${atClientManager.atClient.getCurrentAtSign()}')
        ]),
      ),
    );
  }
}
