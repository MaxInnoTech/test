import 'package:flutter/material.dart';
import 'package:sunmi_printer_flutter/sunmi_printer_flutter.dart'; // Hypothetical plugin import

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter max test Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter test 222 Demo Home Page'),
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

  void _changeCounter(bool increment) {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      if (increment) {
        _counter++;
      } else {
        _counter--;
      }
    });
  }

  Future<void> _printCounterValue() async {
    try {
      // Initialize printer (assuming this is needed and is idempotent or handled by plugin)
      // await SunmiPrinter.initialize(); // Specifics depend on plugin API

      // Prepare text to print
      String textToPrint = 'Current Counter: $_counter';

      // Print the text - assuming a simple text printing method
      // The actual API might differ (e.g., require specific styling objects)
      await SunmiPrinter.printText(textToPrint);
      await SunmiPrinter.lineFeed(3); // Add some empty lines for spacing
      await SunmiPrinter.cutPaper(); // Cut the paper

      // Optionally, show a success message to the user (e.g., via a SnackBar)
      if (mounted) { // Check if the widget is still in the tree
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sent to printer!')),
        );
      }
    } catch (e) {
      // Handle printing errors (e.g., printer not connected, out of paper)
      print('Error printing: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Printing failed: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _changeCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Current counter value:'), // Updated text
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20), // Add space between text and buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Center the buttons horizontally
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => _changeCounter(false), // Decrement
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(width: 10), // Spacer
                ElevatedButton(
                  onPressed: _printCounterValue,
                  child: const Text('Print'),
                ),
                const SizedBox(width: 10), // Spacer
                ElevatedButton(
                  onPressed: () => _changeCounter(true), // Increment
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
      // floatingActionButton removed
    );
  }
}
