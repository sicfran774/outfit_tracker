import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'camera_page.dart';
import 'month_chooser.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';

StreamController<String> monthController = BehaviorSubject<String>();
StreamController<int> yearController = BehaviorSubject<int>();
StreamController<int> dayController = BehaviorSubject<int>();

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
        ),
        home: MyHomePage(monthController.stream, yearController.stream,
            dayController.stream));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage(this.monthStream, this.yearStream, this.dayStream,
      {Key? key})
      : super(key: key);
  final Stream<String> monthStream;
  final Stream<int> yearStream;
  final Stream<int> dayStream;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _month = "January";
  int _year = 2022;
  int _numDays = 31;
  double _zoom = 150;
  AssetImage _image = AssetImage("assets/images/franFace.png");

  @override
  void initState() {
    super.initState();
    widget.yearStream.listen((year) {
      _changeYear(year);
    });
    widget.monthStream.listen((month) {
      _changeMonth(month);
    });
    widget.dayStream.listen((days) {
      _changeNumDays(days);
    });
  }

  void _changeYear(int year) {
    setState(() {
      _year = year;
    });
  }

  void _changeMonth(String month) {
    setState(() {
      _month = month;
    });
  }

  void _changeNumDays(int num) {
    setState(() {
      _numDays = num;
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

  AssetImage _buildImage(int index) {
    if (index < 10) return AssetImage("assets/images/saul goodman.jpg");
    return _image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_month + ", " + _year.toString()),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: _zoom,
            childAspectRatio: (375 /
                812)), //(width / height) of each image:: this is for iphone 11 pro),
        primary:
            true, //This means that user can scroll farther than loaded in by flutter
        itemCount: _numDays,
        itemBuilder: (context, index) {
          return calendarButton(index, _numDays);
        },
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
      endDrawer: SizedBox(
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
                    //if (_zoom > 60) _zoomIn();
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const MonthPage()));
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.calendar_month_outlined),
                      Text("Change Month"),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    //if (_zoom < 150) _zoomOut();
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.info),
                      Text("About"),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    children: const [
                      Icon(Icons.handyman),
                      Text("Settings"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget calendarButton(int index, int numDays) {
    return Container(
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: _buildImage(index),
        ),
      ),
      child: OutlinedButton(
        onPressed: () {},
        child: SizedBox(
          width: 375,
          height: 812,
          child: Text(
            (index + 1).toString(),
            textScaleFactor: 1.5,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
