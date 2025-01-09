
class Actions {
  static const String open = "opened";
  static const String close = "closed";
  static const String lock = "locked";
  static const String unlock = "unlocked";
  static const String unlockShortly = "unlocked_shortly";
  static List<String> all = <String>[open,close, lock, unlock, unlockShortly];
  // not const because we will assign it to some groups and later can be change
  // in the screen of actions
}

class Data {

  static Map<String, String> images = {
    'home_screen' : 'images/home_screen.png',
    'locked' : 'images/locked.png',
    'unlocked' : 'images/unlocked.png',
    'unlocked_shortly' : 'images/unlocked.png',
    'opened' : 'images/opened.jpg',
    'closed' : 'images/closed.jpg',
  };
}
