import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            const SizedBox(
              width: 180.0,
              child: Image(
                image: NetworkImage(
                    "data:image/jpeg;base64,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"),
              ),
            ),
            const Text("Flutter is cool"),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      drawer: Drawer(
        elevation: 20.0,
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("power learn project"),
              accountEmail: Text("powerlearn@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    "data:image/jpeg;base64,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"),
              ),
            ),
            ListTile(
              title: new Text("Inbox"),
              leading: new Icon(Icons.mail),
            ),
            ListTile(
              title: new Text("Social"),
              leading: new Icon(Icons.emoji_people),
            ),
            ListTile(
              title: new Text("promotion"),
              leading: new Icon(Icons.local_offer),
            ),
            ListTile(
              title: new Text("Log out"),
              leading: new Icon(Icons.logout),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
