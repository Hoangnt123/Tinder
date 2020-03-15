import 'package:testpycoflutter/data/model/user_data.dart';
import 'package:testpycoflutter/utils/dependency_injection.dart';

abstract class TinderPageContract {
  void showPeople(User user);
  void showFavoritePeple();
  void showError(String message);
}

class TinderPageListContract {
  TinderPageContract _view;
  UserRepository _repository;
  TinderPageListContract(this._view) {
    _repository = new Injector().userRepository;
  }

  void nextPeople() {
    assert(_view != null);
    _repository.fetchUser().then((user) {
      _view.showPeople(user);
    }).catchError((onError) {
      _view.showError(onError.toString());
    });

  }
}
