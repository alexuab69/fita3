class Reader {
  late String reasons;
  late bool authorized;
  late String action;
  late String state;
  late String doorId;
  late bool closed;


  Reader(Map<String, dynamic> data) {
    reasons = data['reasons'];
    authorized = data['authorized'];
    action = data['action'];
    state = data['state'];
    doorId = data['doorId'];
    closed = data['closed'];
  }
}
