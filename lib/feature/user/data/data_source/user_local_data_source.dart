import 'dart:convert';

import 'package:clean_arch_prac/core/database/Cache/cache_helper.dart';
import 'package:clean_arch_prac/core/errors/exceptions.dart';
import 'package:clean_arch_prac/feature/user/data/models/user_model.dart';

class UserLocalDataSource {
  final CacheHelper cacheHelper;
  final String key = 'CachedUser';

  UserLocalDataSource({required this.cacheHelper});

  cashUser(UserModel? userModel) {
    if (userModel != null) {
      cacheHelper.saveData(key: key, value: json.encode(userModel.toJson()));
    } else {
      throw CacheExeption(errorMessage: "No Internet Connection");
    }
  }

  Future<UserModel> getLastUser() {
    final jsonString = cacheHelper.getDataString(key: key);
    if (jsonString != null) {
      return Future.value(UserModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheExeption(errorMessage: "No User Entered before");
    }
  }
}
