class FetchDataException implements Exception {
  String _messages;

  FetchDataException(this._messages);

  String toString() {
    return "Exception : $_messages";
  }
}
