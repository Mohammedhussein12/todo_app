import 'package:flutter/widgets.dart';

import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? currentUser;

  void updateUser(UserModel? user) {
    currentUser = user;
    notifyListeners();
  }
}
