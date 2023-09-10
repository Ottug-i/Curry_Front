import 'package:ottugi_curry/config/config.dart';

int getUserId() {
  print('print getUserId: ${int.parse(userStorage.getItem(Config.id) ?? '')}');
  return int.parse(userStorage.getItem(Config.id) ?? '');
}

String getUserNickname() {
  return userStorage.getItem(Config.nickName) ?? '';
}

String getUserEmail() {
  return userStorage.getItem(Config.email) ?? '';
}

Future<String> getUserToken() async {
  return await tokenStorage.read(key: 'token') ?? '';
}