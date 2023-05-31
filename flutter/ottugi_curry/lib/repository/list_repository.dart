import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:ottugi_curry/model/menu.dart';
import 'package:ottugi_curry/model/menu_list.dart';

part 'list_repository.g.dart';

@RestApi(baseUrl: "http://10.0.2.2:8080")
abstract class MenuRepository {
  factory MenuRepository(Dio dio, {String baseUrl}) = _MenuRepository;

  // 전체 결과
  @POST('/api/recipe/getRecipeList')
  Future<List<MenuModel>> getMenuList(@Body() MenuList param);

/*
  // 전체 결과
  @GET('/api/user/getProfile')
  Future<MenuModel> getProfile(@Query("id") int id);

  // 검색 결과
  @PUT('/api/user/setProfile')
  Future<MenuModel> setProfile(@Body() MenuModel user);

  */
}
