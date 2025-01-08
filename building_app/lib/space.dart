import 'package:flutter/material.dart';
import 'data.dart' as appData;
import 'main.dart';
import 'dart:io';

class SpaceScreen extends StatefulWidget {
  final String space;

  const SpaceScreen({super.key, required this.space});

  @override
  State<SpaceScreen> createState() => _SpaceScreenState();
}

class _SpaceScreenState extends State<SpaceScreen> {
  late String space;
  late List<String> doors;

  @override
  void initState() {
    super.initState();
    space = widget.space;
    doors = appData.Data.doors[space] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doors in $space'),
        actions: [
          IconButton(
            icon: Image(
              image: FileImage(File(appData.Data.images['home_screen'] ?? 'images/default_image.png')),
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
        itemCount: doors.length,
        itemBuilder: (context, index) {
          return _buildRow(index);
        },
      ),
    );
  }

  Widget _buildRow(int index) {
    String door = doors[index];
    String doorStatus = appData.Data.doorStatus[door] ?? 'locked';
    bool isClosed = appData.Data.doorClosed[door] ?? true;
    String closedImageKey = isClosed ? 'closed' : 'open';

    return ListTile(
      title: Text(door),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image(
            image: FileImage(File(appData.Data.images[doorStatus] ?? 'images/default_image.png')),
          ),
          SizedBox(width: 10),
          Image(
            image: FileImage(File(appData.Data.images[closedImageKey] ?? 'images/default_image.png')),
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () => _showDoorActions(context, door),
          ),
        ],
      ),
    );
  }

  void _showDoorActions(BuildContext context, String door) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Actions for $door'),
          content: Text('Choose an action for this door.'),
          actions: appData.Actions.all.map((action) {
            return TextButton(
              child: Text(action.capitalize()),
              onPressed: () {
                setState(() {
                  if(action == appData.Actions.unlock || action == appData.Actions.unlockShortly || action == appData.Actions.lock) {
                    appData.Data.doorStatus[door] = action;
                    if (action == appData.Actions.unlockShortly) {
                      Future.delayed(Duration(seconds: 10), () {
                        setState(() {
                          appData.Data.doorStatus[door] = appData.Actions.lock;
                        });
                      });
                    }
                  } else {
                     // Update doorClosed status based on action
                    if (action == appData.Actions.open) {
                      setState(() {
                          appData.Data.doorClosed[door] = false;
                        });
                    } else if (action == appData.Actions.close) {
                      setState(() {
                          appData.Data.doorClosed[door] = true;
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
