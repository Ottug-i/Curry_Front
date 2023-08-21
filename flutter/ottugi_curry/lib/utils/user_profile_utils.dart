import 'package:ottugi_curry/config/config.dart';

int getUserId() {
  print('print getUserId(): ${userStorage.getItem(Config.id).toString()}');
  return int.parse(userStorage.getItem(Config.id) ?? '1');
}

String getUserNickname() {
  return userStorage.getItem(Config.nickName) ?? '계란러버덕';
}

String getUserEmail() {
  return userStorage.getItem(Config.email) ?? '';
}

Future<String> getUserToken() async {
  return await tokenStorage.read(key: 'token') ?? '';
}