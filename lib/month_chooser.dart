import 'package:flutter/material.dart';

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
              yearWidget(2022),
              yearWidget(2023),
              yearWidget(2024),
              yearWidget(2025),
            ],
          ),
        ));
  }
}

Widget yearWidget(int year) {
  return Column(
    children: [
      Text(year.toString()),
      SizedBox(
        height: 300,
        child: GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 4,
          children: [
            TextButton(onPressed: () {}, child: const Text("Jan")),
            TextButton(onPressed: () {}, child: const Text("Feb")),
            TextButton(onPressed: () {}, child: const Text("Mar")),
            TextButton(onPressed: () {}, child: const Text("Apr")),
            TextButton(onPressed: () {}, child: const Text("May")),
            TextButton(onPressed: () {}, child: const Text("Jun")),
            TextButton(onPressed: () {}, child: const Text("Jul")),
            TextButton(onPressed: () {}, child: const Text("Aug")),
            TextButton(onPressed: () {}, child: const Text("Sept")),
            TextButton(onPressed: () {}, child: const Text("Oct")),
            TextButton(onPressed: () {}, child: const Text("Nov")),
            TextButton(onPressed: () {}, child: const Text("Dec")),
          ],
        ),
      ),
    ],
  );
}
