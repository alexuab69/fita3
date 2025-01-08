import 'package:flutter/material.dart';
import 'data.dart';
import 'space.dart';
import 'main.dart'; 
import 'dart:io';

class PartitionScreen extends StatefulWidget {
  final String partition;

  const PartitionScreen({super.key, required this.partition});

  @override
  State<PartitionScreen> createState() => _PartitionScreenState();
}

class _PartitionScreenState extends State<PartitionScreen> {
  late String partition;
  late List<String> spaces;

  @override
  void initState() {
    super.initState();
    partition = widget.partition;
    spaces = Data.spaces[partition] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spaces in $partition'),
        actions: [
          IconButton(
            icon: Image(
              image: FileImage(File(Data.images['home_screen'] ?? 'images/default_image.png')),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage(title: 'Home Page')),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: spaces.length,
        itemBuilder: (context, index) {
          return _buildRow(index);
        },
      ),
    );
  }

  Widget _buildRow(int index) {
    return ListTile(
      title: Text(spaces[index]),
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute<void>(
            builder: (context) => SpaceScreen(space: spaces[index]),
          ))
          .then((var v) => setState(() {})),
    );
  }
}
