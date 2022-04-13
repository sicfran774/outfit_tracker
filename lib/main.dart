import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'camera_page.dart';

var firstCamera;

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
      home: const MyHomePage(
        title: 'Outfit Tracker',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /*int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 150,
            childAspectRatio: (375 /
                812)), //(width / height) of each image:: this is for iphone 11 pro),
        primary:
            true, //This means that user can scroll farther than loaded in by flutter
        itemCount: 31,
        itemBuilder: (context, index) =>
            calendarButton(AssetImage("assets/images/franFace.png"), index),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.camera_alt),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TakePictureScreen(camera: firstCamera),
                ));
          }),
      drawer: const Drawer(child: Center(child: Text("your mom hehe"))),
    );
  }

  Widget calendarButton(AssetImage assetPath, int index) {
    return OutlinedButton(
      child: Container(
        alignment: Alignment.topLeft,
        child: Text(
          (index + 1).toString(),
          textAlign: TextAlign.left,
          textScaleFactor: 1.5,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: assetPath,
          ),
        ),
      ),
      onPressed: () {},
    );
  }
}
