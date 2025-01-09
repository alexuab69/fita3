
class DoorState {
  static const String locked = "locked";
  static const String unlocked = "unlocked";
  static const String opened = "opened";
  static const String closed = "closed";
  static const String propped = "propped";
}

class Actions {
  static const String open = "open";
  static const String close = "close";
  static const String lock = "lock";
  static const String unlock = "unlock";
  static const String unlockShortly = "unlock_shortly";
  static List<String> all = <String>[open, close, lock, unlock, unlockShortly];
}

class Data {

  static Map<String, String> images = {
    'ground-floor' : 'images/home/ground-floor.png',
    'first-floor' : 'images/home/floor1.png',
    'second-floor' : 'images/home/floor2.png',
    'last-floor' : 'images/home/last-floor.png',
    'basement' : 'images/home/basement.png',
  };
}
