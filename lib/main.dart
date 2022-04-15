import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'camera_page.dart';

late var firstCamera;

Future<void> main() async {
// Ensure that plugin services are initialized so that `availableCameras()`
// can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

// Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();
// Get a specific camera from the list of available cameras.
  firstCamera = cameras.first;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
        ),
        home: const MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String month = "January";
  int _counter = 31;
  double _zoom = 150;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _changeMonth() {
    setState(() {
      month += "lol";
    });
  }

  void _zoomIn() {
    setState(() {
      _zoom -= 30;
    });
  }

  void _zoomOut() {
    setState(() {
      _zoom += 30;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(month),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: _zoom,
            childAspectRatio: (375 /
                812)), //(width / height) of each image:: this is for iphone 11 pro),
        primary:
            true, //This means that user can scroll farther than loaded in by flutter
        itemCount: _counter,
        itemBuilder: (context, index) => calendarButton(index),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.camera_alt),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TakePictureScreen(
                      camera:
                          firstCamera), //If camera button is pressed, go to camera screen
                ));
          }),
      drawer: SizedBox(
        width: 250,
        child: Drawer(
          child: Container(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              children: [
                const Text("Outfit Tracker",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold)),
                ElevatedButton(
                    onPressed: () {
                      if (_zoom > 60) _zoomIn();
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.calendar_month_outlined),
                        Text("Change Month"),
                      ],
                    )),
                ElevatedButton(
                    onPressed: () {
                      if (_zoom < 150) _zoomOut();
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.info),
                        Text("About"),
                      ],
                    )),
                ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      children: const [
                        Icon(Icons.handyman),
                        Text("Settings"),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget calendarButton(int index) {
    return OutlinedButton(
      child: Container(
        alignment: Alignment.topLeft,
        child: Text(
          (index + 1).toString(),
          textAlign: TextAlign.left,
          textScaleFactor: 1.5,
          style: const TextStyle(color: Colors.black),
        ),
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.contain,
            image: AssetImage("assets/images/wowie.png"),
          ),
        ),
      ),
      onPressed: () {},
    );
  }
}
