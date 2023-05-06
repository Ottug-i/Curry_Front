import 'package:ottugi_curry/config/config.dart';

int getUserId() {
  return int.parse(userStorage.getItem('id'));
}

String getUserNickname() {
  return userStorage.getItem('nickname') ?? '계란러버덕';
}

String getUserEmail() {
  return userStorage.getItem('email') ?? '';
}