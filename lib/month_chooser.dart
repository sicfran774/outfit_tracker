import 'package:flutter/material.dart';
import 'main.dart';

class MonthPage extends StatefulWidget {
  const MonthPage({Key? key}) : super(key: key);
  @override
  State<MonthPage> createState() => _MonthPageState();
}

class _MonthPageState extends State<MonthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Choose Month")),
        extendBody: true,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.all(10)),
              yearWidget(2022, context),
              const Padding(padding: EdgeInsets.all(18)),
              yearWidget(2023, context),
              const Padding(padding: EdgeInsets.all(18)),
              yearWidget(2024, context),
              const Padding(padding: EdgeInsets.all(18)),
              yearWidget(2025, context),
              const Padding(padding: EdgeInsets.all(18)),
            ],
          ),
        ));
  }
}

Widget yearWidget(int year, BuildContext context) {
  return Column(
    children: [
      Text(year.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
      SizedBox(
        height: 320,
        child: GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 4,
          children: [
            monthWidget(year, "January", context),
            monthWidget(year, "February", context),
            monthWidget(year, "March", context),
            monthWidget(year, "April", context),
            monthWidget(year, "May", context),
            monthWidget(year, "June", context),
            monthWidget(year, "July", context),
            monthWidget(year, "August", context),
            monthWidget(year, "September", context),
            monthWidget(year, "October", context),
            monthWidget(year, "November", context),
            monthWidget(year, "Decemeber", context),
          ],
        ),
      ),
    ],
  );
}

Widget monthWidget(int year, String month, BuildContext context) {
  void changeNumDays() {
    switch (month) {
      case "January":
      case "March":
      case "May":
      case "July":
      case "August":
      case "October":
      case "December":
        dayController.add(31);
        break;
      case "April":
      case "June":
      case "September":
      case "November":
        dayController.add(30);
        break;
      case "February":
        if ((year % 1000) % 4 == 0) {
          dayController.add(29);
        } else {
          dayController.add(28);
        }
        break;
    }
  }

  return OutlinedButton(
      onPressed: () {
        monthController.add(month);
        yearController.add(year);
        changeNumDays();
        Navigator.pop(context);
        Navigator.pop(context);
      },
      style: OutlinedButton.styleFrom(shape: const CircleBorder()),
      child: Text(month.substring(0, 3), style: const TextStyle(fontSize: 30)));
}
