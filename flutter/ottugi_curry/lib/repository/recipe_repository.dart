import 'package:ottugi_curry/model/recipe_response.dart';
import 'package:ottugi_curry/model/recipe_list_response.dart';
import 'package:ottugi_curry/model/search_queries.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'recipe_repository.g.dart';

@RestApi(baseUrl: "http://192.168.0.51:8080")
abstract class RecipeRepository {
  factory RecipeRepository(Dio dio, {String baseUrl}) = _RecipeRepository;

  @GET('/api/recipe/getRecipeDetail')
  Future<RecipeResponse> getRecipeDetail(
      @Query("recipeId") int recipeId, @Query("userId") int userId);

  // 전체 결과
  @POST('/api/recipe/getRecipeList')
  Future<RecipeListResponse> getMenuList(@Body() requestJson);

  @GET('/api/recipe/searchByBox')
  Future<RecipeListResponse> searchByBox(
      @Queries() SearchQueries searchQueries);
}
