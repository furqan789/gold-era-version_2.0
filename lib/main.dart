import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'GoldpriceModel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, dynamic> currentPrice;
  List test;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: ElevatedButton(
                onPressed: () async {
                  test = await GoldpriceModel().getGoldPriceData();
                  print("Done");
                },
                child: Text('From csv'),
              ),
            ),
            Expanded(
              flex: 3,
              child: ElevatedButton(
                onPressed: () async {
                  await GoldpriceModel().getLatestPrices();
                },
                child: Text('From api'),
              ),
            ),
            Expanded(
              flex: 3,
              child: ElevatedButton(
                onPressed: () {
                  var ind = GoldpriceModel()
                      .linearRegression(test[1], test[0], DateTime(2021, 4, 2));
                  print(ind);
                },
                child: Text('linear regress'),
              ),
            ),
            Expanded(
              flex: 3,
              child: ElevatedButton(
                onPressed: () {
                  GoldpriceModel().dataSorting(test[2]);
                },
                child: Text('Test'),
              ),
            ),
            test!=null?Expanded(
              flex: 10,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.brown.withOpacity(0.4)
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(30.0),
                    child: GoldpriceModel()
                        .linearGraph(test[0], test[1], test[0].length),
                  ),
                ),
              ),
            ) : Text('Data not loaded'),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
