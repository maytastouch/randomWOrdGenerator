class Urls {
  static const baseUrl = "https://api.dictionaryapi.dev/api/v2/entries/en/";
  static String currentDefinition(String word) => '$baseUrl$word';

  static const baseRandUrl = "https://random-word-api.herokuapp.com/word";
}
