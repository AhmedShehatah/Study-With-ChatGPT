import 'base_state.dart';

class BaseSuccessState<DATA> extends BaseState {
  final DATA? _data;

  DATA? get data {
    assert(_data != null);
    return _data;
  }

  const BaseSuccessState([this._data]);
}
