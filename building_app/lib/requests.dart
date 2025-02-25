import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:logger/logger.dart';
import 'tree.dart';
import 'reader.dart';

var logger = Logger();

Future<Tree> getTree(String areaId) async {
  const String BASE_URL = "http://localhost:8080";
  Uri uri = Uri.parse("${BASE_URL}/get_children?$areaId");
  final response = await http.get(uri);
  // response is NOT a Future because of await
  if (response.statusCode == 200) {
    // TODO: change prints by logs, use package Logger for instance 
    // which is the most popular, see https://pub.dev/packages/logger
    logger.i("statusCode=${response.statusCode}");
    logger.i(response.body);
    // If the server did return a 200 OK response, then parse the JSON.
    Map<String, dynamic> decoded = convert.jsonDecode(response.body);
    return Tree(decoded);
  } else {
    // If the server did not return a 200 OK response, then throw an exception.
    logger.e("statusCode=${response.statusCode}");
    throw Exception('failed to get answer to request $uri');
  }
}

Future<Reader> sendRequest(String action, String doorId) async {
  const String BASE_URL = "http://localhost:8080";
  Uri uri = Uri.parse("${BASE_URL}/reader?credential=11343&action=${action}&datetime=2024-09-21T09:30&doorId=${doorId}");
  final response = await http.get(uri);
  // response is NOT a Future because of await
  if (response.statusCode == 200) {
    // TODO: change prints by logs, use package Logger for instance 
    // which is the most popular, see https://pub.dev/packages/logger
    logger.i("statusCode=${response.statusCode}");
    logger.i(response.body);
    // If the server did return a 200 OK response, then parse the JSON.
    Map<String, dynamic> decoded = convert.jsonDecode(response.body);
    return Reader(decoded);
  } else {
    // If the server did not return a 200 OK response, then throw an exception.
    logger.e("statusCode=${response.statusCode}");
    throw Exception('failed to get answer to request $uri');
  }
}