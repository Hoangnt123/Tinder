
import 'package:testpycoflutter/data/model/user_data.dart';
import 'package:testpycoflutter/utils/dependency_injection.dart';

abstract class FavoriteListViewContract {
  void onLoadFavorireComplete(List<User> users);
  void onLoadUserError(String message);
}

class FavoritePresenter {
  FavoriteListViewContract  _view;
  UserRepository _repository;

  FavoritePresenter(this._view) {
    _repository = new Injector().userRepository;
  }

  void loadFavoritePeople() {
    assert(_view != null);
    _repository.getAllUser().then((users) {
      _view.onLoadFavorireComplete(users);
    }).catchError((onError) {
      _view.onLoadUserError(onError.toString());
    });
  }
}

