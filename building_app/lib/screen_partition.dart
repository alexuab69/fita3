import 'package:flutter/material.dart';
import 'tree.dart';
import 'screen_space.dart';
import 'main.dart';
import 'dart:io';
import 'data.dart';

class PartitionScreen extends StatefulWidget {
  final String id;
  const PartitionScreen({super.key, required this.id});

  @override
  State<PartitionScreen> createState() => _PartitionScreenState();
}

class _PartitionScreenState extends State<PartitionScreen> {
  late Tree tree;

  @override
  void initState() {
    super.initState();
    tree = getTree(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary, 
        title: Text(tree.root.id),
        actions: <Widget>[
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
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: tree.root.children.length,
        itemBuilder: (BuildContext context, int index) =>
          _buildRow(tree.root.children[index], index),
        separatorBuilder: (BuildContext context, int index) =>
        const Divider(),
      ),
    );
  }

  Widget _buildRow(Area area, int index) {
    assert (area is Partition || area is Space);
    if (area is Partition) {
      return ListTile(
        title: Text('P ${area.id}'),
        onTap: () => _navigateDownPartition(area.id),
        // TODO, navigate down to show children areas
      );
    } else {
      return ListTile(
        title: Text('S ${area.id}'),
        onTap: () => _navigateDownSpace(area.id),
        // TODO, navigate down to show children doors
      );
    }
  }

  void _navigateDownPartition(String childId) {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (context) => PartitionScreen(id: childId,))
    );
  }

  void _navigateDownSpace(String childId) {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (context) => SpaceScreen(id: childId,))
    );
  }
}

