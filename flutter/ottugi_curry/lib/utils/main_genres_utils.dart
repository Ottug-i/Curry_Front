// 첫 번째 추천 레시피의 메인 장르를 스토리지에 저장하기
import 'package:ottugi_curry/config/config.dart';

void saveMainGenreToStorage(String mainGenre) async {
  await mainGenreStorage.setItem(Config.mainGenre, mainGenre);
}

String getMainGenreFromStorage() {
  return mainGenreStorage.getItem(Config.mainGenre);
}