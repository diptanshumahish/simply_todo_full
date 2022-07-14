import 'package:shared_preferences/shared_preferences.dart';

// ignore: prefer_typing_uninitialized_variables
var username;
saveData(String fname) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString("fname", fname);
}

fetchData(String firstName) async {
  return firstName;
}
