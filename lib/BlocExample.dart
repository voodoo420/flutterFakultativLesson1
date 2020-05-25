import 'package:rxdart/rxdart.dart';

class Bloc {
  final _intFetcher = PublishSubject<int>();
  bool _isDisposed = false;

  Stream<int> get getInt => _intFetcher.stream;

  fetchInt() async {
    _isDisposed = false;
    _intFetcher.addStream(getRandomValues());
  }

  Stream<int> getRandomValues() async* {
    int value = 0;
    while (!_isDisposed) {
      await Future.delayed(Duration(seconds: 1));
      yield ++value;
    }
  }

  void dispose() {
    _isDisposed = true;
    _intFetcher.close();
  }
}

final bloc = Bloc();