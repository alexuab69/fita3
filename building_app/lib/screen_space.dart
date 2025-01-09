import 'package:building_app/main.dart';
import 'package:flutter/material.dart';
import 'data.dart' as appData;
import 'tree.dart';
import 'dart:io';

class SpaceScreen extends StatefulWidget {
  final String id;

  const SpaceScreen({super.key, required this.id});

  @override
  State<SpaceScreen> createState() => _SpaceScreenState();
}

class _SpaceScreenState extends State<SpaceScreen> {
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
        actions: [
          IconButton(
            icon: Image(
              image: FileImage(File(appData.Data.images['home_screen'] ?? 'images/default_image.png')),
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

  Widget _buildRow(Door door, int index) {
    return ListTile(
      title: Text('D ${door.id}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image(
            image: FileImage(File(appData.Data.images[door.state] ?? 'images/default_image.png')),
          ),
          SizedBox(width: 10),
            Image(
            image: FileImage(File(appData.Data.images[door.closed ? 'closed' : 'opened'] ?? 'images/default_image.png')),
            ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () => _showDoorActions(context, door),
          ),
        ],
      ),
    );  
  }

  void _showDoorActions(BuildContext context, Door door) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Actions for ${door.id}'),
          content: Text('Choose an action for this door.'),
          actions: appData.Actions.all.map((action) {
            return TextButton(
              child: Text(action.capitalize()),
              onPressed: () {
                setState(() {
                  if(action == appData.Actions.unlock || action == appData.Actions.unlockShortly || action == appData.Actions.lock) {
                    appData.Data.doorStatus[door.id] = action;
                    if (action == appData.Actions.unlockShortly) {
                      Future.delayed(Duration(seconds: 10), () {
                        setState(() {
                          appData.Data.doorStatus[door.id] = appData.Actions.lock;
                        });
                      });
                    }
                  } else {
                     // Update doorClosed status based on action
                    if (action == appData.Actions.open) {
                      setState(() {
                          appData.Data.doorClosed[door.id] = false;
                        });
                    } else if (action == appData.Actions.close) {
                      setState(() {
                          appData.Data.doorClosed[door.id] = true;
                        });
                    }
                  }
                });
                Navigator.of(context).pop();
                // Add your action for the respective door action here
              },
            );
          }).toList(),
        );
      },
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}