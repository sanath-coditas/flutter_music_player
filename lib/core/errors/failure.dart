// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class Failure {
  final String message;

  Failure({required this.message});
}

class FetchFailure implements Failure {
  @override
  final String message;
  FetchFailure({
    required this.message,
  });
}

class PlayFailure implements Failure {
  @override
  final String message;
  PlayFailure({
    required this.message,
  });
}

class PauseFailure implements Failure {
  @override
  final String message;
  PauseFailure({
    required this.message,
  });
}

class SeekFailure implements Failure {
  @override
  final String message;
  SeekFailure({
    required this.message,
  });
}