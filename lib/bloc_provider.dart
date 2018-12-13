import 'package:bloc_arch/api/const.dart';
import 'package:bloc_arch/model/SearchModel.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc_arch/api/api.dart';

class BlocProvider {
  final _api = new Api();
  final String _EMPTY = "_empty_";

  final _fetcher = new PublishSubject<SearchModel>();

  stream() => _fetcher.stream;

  void dispose() {
    if (!_fetcher.isClosed) {
      _fetcher.close();
    }
  }

  void fetchQueryList() async {
    fetchUrl(SEARCH_URL, (map) => SearchModel.fromJson(map));
  }

  void fetchUrl(String url, Function handleData) async {
    _api.fetchUrl(url, (map) {
      _fetcher.sink.add(handleData(map));
    }, (errorMsg) {
      _fetcher.sink.addError(errorMsg, null);
    }, () {
      _fetcher.sink.addError(_EMPTY);
    });
  }

  Widget streamBuilder<T>({
    T initalData,
    Function success,
    Function error,
    Function empty,
    Function loading,
    Function finished,
  }) {
    return StreamBuilder(
        stream: stream(),
        initialData: initalData,
        builder: (context, AsyncSnapshot<T> snapshot) {
          if (finished != null) {
            finished();
          }
          if (snapshot.hasData) {
            if (success != null) return success(snapshot.data);
          } else if (snapshot.hasError) {
            final errorStr = snapshot.error;
            if (errorStr == _EMPTY) {
              if (empty != null) return empty();
            } else {
              if (error != null) return error(errorStr);
            }
          } else {
            if (loading != null) return loading();
          }
        });
  }

  static BlocProvider newInstance() => new BlocProvider();
}
