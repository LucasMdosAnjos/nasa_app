class GetPicturesOfTheDayException implements Exception{
  final String message;

  GetPicturesOfTheDayException(this.message);

  @override
  String toString() {
    return message;
  }
}