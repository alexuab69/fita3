import 'package:flutter/material.dart';


class Actions {
  static const String open = "open";
  static const String close = "close";
  static const String lock = "lock";
  static const String unlock = "unlock";
  static const String unlockShortly = "unlock_shortly";
  static List<String> all = <String>[open,close, lock, unlock, unlockShortly];
  // not const because we will assign it to some groups and later can be change
  // in the screen of actions
}

class Data {

  static List<String> partitions = <String>['P basement', 'P ground_floor', 'P floor1'];
  static Map<String, List<String>> spaces = {
    'P basement': ['parking'],
    'P ground_floor': ['hall', 'room1', 'room2'],
    'P floor1': ['corridor', 'room3', 'IT'],
  };
  static Map<String, List<String>> doors = {
    'parking': ['D1', 'D2'],  
    'hall': ['D3', 'D4'],
    'room1': ['D5'],
    'room2': ['D6'],
    'corridor': ['D7'],
    'room3': ['D8'],
    'IT': ['D9'],
  };

  static Map<String, String> images = {
    'home_screen' : 'images/home_screen.png',
    'lock' : 'images/locked.png',
    'unlock' : 'images/unlocked.png',
    'unlock_shortly' : 'images/unlocked.png',
    'open' : 'images/opened.jpg',
    'closed' : 'images/closed.jpg',
  };

  static Map<String, String> doorStatus = {
    'D1': Actions.lock,
    'D2': Actions.lock,
    'D3': Actions.lock,
    'D4': Actions.lock,
    'D5': Actions.lock,
    'D6': Actions.lock,
    'D7': Actions.lock,
    'D8': Actions.lock,
    'D9': Actions.lock,
  };

  static Map<String, bool> doorClosed = {
    'D1': true,
    'D2': true,
    'D3': true,
    'D4': true,
    'D5': true,
    'D6': true,
    'D7': true,
    'D8': true,
    'D9': true,
  };
}
