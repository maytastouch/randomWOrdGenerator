import 'dart:convert';

class Prune {
  static String removeInvalidCharacters(String jsonString) {
    // Remove all occurrences of "ʊ" and "ʌ" with an empty string
    jsonString = jsonString.replaceAll("ʊ", "").replaceAll("ʌ", "");

    try {
      var jsonList = jsonDecode(jsonString);

      if (jsonList.isNotEmpty) {
        var firstJsonObject = jsonList[0];
        return jsonEncode(firstJsonObject);
      } else {
        return ''; // Return an empty string or handle the case when the list is empty.
      }
    } catch (e) {
      return ''; // Handle JSON decoding errors here, if needed.
    }
  }
}
