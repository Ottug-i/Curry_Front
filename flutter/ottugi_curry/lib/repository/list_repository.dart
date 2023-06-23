import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:ottugi_curry/model/menu.dart';
import 'package:ottugi_curry/model/menu_list.dart';

part 'list_repository.g.dart';

@RestApi(baseUrl: "http://192.168.160.1:8080")
abstract class MenuRepository {
  factory MenuRepository(Dio dio, {String baseUrl}) = _MenuRepository;

  // 전체 결과
  @POST('/api/recipe/getRecipeList')
  Future<List<MenuModel>> getMenuList(@Body() MenuList param);
}
