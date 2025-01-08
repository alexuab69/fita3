import 'package:flutter/material.dart';
import 'dart:io';
import 'data.dart';
import 'partition.dart';
import 'main.dart'; 

class BuildingScreen extends StatefulWidget {
  const BuildingScreen({super.key});

  @override
  State<BuildingScreen> createState() => _BuildingScreenState();
}

class _BuildingScreenState extends State<BuildingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Partitions List'),
        actions: [
          IconButton(
            icon: Image(
              image: FileImage(File(Data.images['home_screen'] ?? 'images/default_image.png')),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Home Page')),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: Data.partitions.length,
        itemBuilder: (context, index) {
          return _buildRow(index);
        },
      ),
    );
  }

  Widget _buildRow(int index) {
    return ListTile(
      title: Text(Data.partitions[index]),
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute<void>(
            builder: (context) => PartitionScreen(partition: Data.partitions[index]),
          ))
          .then((var v) => setState(() {})),
    );
  }
}
