import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:flutter/material.dart';
import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:at_app_flutter/at_app_flutter.dart' show AtEnv;
import 'package:at_utils/at_logger.dart' show AtSignLogger;
import 'package:path_provider/path_provider.dart'
    show getApplicationSupportDirectory;
import 'dart:async';
import 'package:flutter/material.dart';



// * Once the onboarding process is completed you will be taken to this screen
class HomeScreen extends StatefulWidget  {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _HomeScreenState();


  void initState(){

  }


}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{
  String temperature = "";
  String humidity = "";
  int counter = 0;
  final String atSignPico = "@distinctiveblue";
  final String key = "temperature";
  AtClientManager atClientManager = AtClientManager.getInstance();
  Timer? timer;

  late AnimationController controller;

  void getWeather() async {
    final AtClient atClient = atClientManager.atClient;
    final AtKey atKey = AtKey.public(
        key, namespace: "group5", sharedBy: atSignPico).build();

    GetRequestOptions options = GetRequestOptions();
    options.bypassCache = true;
    AtValue atValue = await atClient.get(atKey, getRequestOptions: options);
    final String value = atValue.value;

    setState(() {
      temperature = value.split(",")[0];
      humidity = value.split(",")[1];
    });

  }

  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 9),
    )..addListener(() {
      setState(() {});
    });
    controller.repeat();

    // controller.repeat(reverse: true);

    timer = Timer.periodic(Duration(seconds: 2), (Timer t) {
      getWeather();
      // setState((){
      //   counter++;
      // });

    });
    controller.repeat();




  }
  @override
  void dispose() {
    timer?.cancel();
    controller.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    // * Getting the AtClientManager instance to use below






    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // ElevatedButton(
                //   onPressed: getWeather,
                //   child: const Text("Get weather!"),
                // ),
                // Text('timer $counter'),
                Text('temperature: $temperature F'),
                Text('humidity: $humidity %'),
                LinearProgressIndicator(
                  value: controller.value,
                  semanticsLabel: 'Linear progress indicator',
                ),

              ]
          )



      ),
    );
  }
}
