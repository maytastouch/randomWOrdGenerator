import 'dart:convert';
import 'dart:io';

String removeInvalidCharacters(String jsonString) {
  var dir = Directory.current.path;
  if (dir.endsWith('/test')) {
    dir = dir.replaceAll('/test', '');
  }
  var jsonFilePath = File('$dir/test/$jsonString');

  try {
    var jsonString = jsonFilePath.readAsStringSync();
    // Remove all occurrences of "ʊ" and "ʌ" with an empty string
    jsonString = jsonString.replaceAll("ʊ", "").replaceAll("ʌ", "");

    var jsonList = jsonDecode(jsonString);

    if (jsonList.isNotEmpty) {
      var firstJsonObject = jsonList[0];
      return jsonEncode(firstJsonObject);
    } else {
      return ''; // Return an empty string or handle the case when the list is empty.
    }
  } catch (e) {
    return ''; // Handle file reading and JSON decoding errors here, if needed.
  }
}

String readFirstJson(String name) {
  var dir = Directory.current.path;
  if (dir.endsWith('/test')) {
    dir = dir.replaceAll('/test', '');
  }
  var jsonFilePath = File('$dir/test/$name');
  var jsonString = jsonFilePath.readAsStringSync();
  var jsonList = jsonDecode(jsonString);

  if (jsonList.isNotEmpty) {
    var firstJsonObject = jsonList[0];
    return jsonEncode(firstJsonObject);
  } else {
    return ''; // Return an empty string or handle the case when the list is empty.
  }
}

String readJson(String name) {
  var dir = Directory.current.path;
  if (dir.endsWith('/test')) {
    dir = dir.replaceAll('/test', '');
  }
  return File('$dir/test/$name').readAsStringSync();
}
