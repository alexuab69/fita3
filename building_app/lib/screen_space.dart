import 'package:building_app/reader.dart';
import 'package:building_app/main.dart';
import 'package:flutter/material.dart';
import 'data.dart' as appData;
import 'tree.dart';
import 'requests.dart';

class SpaceScreen extends StatefulWidget {
  final String id;

  const SpaceScreen({super.key, required this.id});

  @override
  State<SpaceScreen> createState() => _SpaceScreenState();
}

class _SpaceScreenState extends State<SpaceScreen> {
  late Future<Tree> futureTree;
  late Future<Reader> futureReader;

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
            Icon(
            door.state == appData.DoorState.locked
              ? Icons.lock
              : door.state == appData.DoorState.propped
                ? Icons.warning
                : Icons.lock_open,
            ),
          SizedBox(width: 10),
          Icon(door.closed ? Icons.door_front_door : Icons.meeting_room),
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
                    if (action == appData.Actions.unlock || action == appData.Actions.unlockShortly) {
                      door.state = appData.DoorState.unlocked;
                      if (action == appData.Actions.unlockShortly) {
                        Future.delayed(Duration(seconds: 10), () {
                          setState(() {
                            door.state = appData.DoorState.locked;
                          });
                        });
                      }
                    } else if (action == appData.Actions.lock) {
                      door.state = appData.DoorState.locked;
                    } else {
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
                    futureReader = sendRequest(action, door.id);
                  }
                );
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