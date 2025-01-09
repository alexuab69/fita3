import 'package:flutter/material.dart';
import 'screen_partition.dart';
import 'dart:io';
import 'data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // removes the debug banner that hides the home button
      title: 'Building App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 20),
        ),
      ),
      home: const PartitionScreen(id: "building"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            children: <Widget>[
              Container(
                color: Theme.of(context).colorScheme.primary,
                height: constraints.maxHeight * 0.6,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image(image: FileImage(File(Data.images['ground-floor'] ?? 'default_image_path')),),
                      Image(image: FileImage(File(Data.images['first-floor'] ?? 'default_image_path')),),
                      Image(image: FileImage(File(Data.images['second-floor'] ?? 'default_image_path')),),
                      Image(image: FileImage(File(Data.images['last-floor'] ?? 'default_image_path')),),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.brown,
                height: MediaQuery.of(context).size.height * 0.4,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image(image: FileImage(File(Data.images['basement'] ?? 'default_image_path')),),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

