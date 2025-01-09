import 'package:building_app/main.dart';
import 'package:flutter/material.dart';
import 'data.dart' as appData;
import 'tree.dart';
import 'dart:io';
import 'requests.dart';

class SpaceScreen extends StatefulWidget {
  final String id;

  const SpaceScreen({super.key, required this.id});

  @override
  State<SpaceScreen> createState() => _SpaceScreenState();
}

class _SpaceScreenState extends State<SpaceScreen> {
  late Future<Tree> futureTree;

  @override
  void initState() {
    super.initState();
    futureTree = getTree(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Tree>(
      future: futureTree,
      builder: (context, snapshot) {
        // anonymous function
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              title: Text(snapshot.data!.root.id),
              actions: <Widget>[
                IconButton(icon: const Icon(Icons.home), onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Home Page')),
                    );
                  }
                ),
              ],
            ),
            body: ListView.separated(
              padding: const EdgeInsets.all(16.0),
              itemCount: snapshot.data!.root.children.length,
              itemBuilder: (BuildContext context, int i) =>
                  _buildRow(snapshot.data!.root.children[i], i),
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        // By default, show a progress indicator
        return Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ));
      },
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
                    door.state = action;
                    if (action == appData.Actions.unlockShortly) {
                      Future.delayed(Duration(seconds: 10), () {
                        setState(() {
                          door.state = appData.Actions.lock;
                        });
                      });
                    }
                  } else {
                     // Update doorClosed status based on action
                    if (action == appData.Actions.open) {
                      setState(() {
                          door.closed = false;
                        });
                    } else if (action == appData.Actions.close) {
                      setState(() {
                          door.closed = true;
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