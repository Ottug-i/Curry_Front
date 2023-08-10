import 'package:ottugi_curry/model/recipe_detail_response.dart';
import 'package:ottugi_curry/model/recipe_list_page_response.dart';
import 'package:ottugi_curry/model/search_queries.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'recipe_repository.g.dart';

@RestApi(baseUrl: "http://192.168.0.51:8080")
abstract class RecipeRepository {
  factory RecipeRepository(Dio dio, {String baseUrl}) = _RecipeRepository;

  @GET('/api/recipe/getRecipeDetail')
  Future<RecipeDetailResponse> getRecipeDetail(
      @Query("recipeId") int recipeId, @Query("userId") int userId);

  // 전체 결과
  @POST('/api/recipe/getRecipeList')
  Future<RecipeListPageResponse> getMenuList(@Body() requestJson);

  @GET('/api/recipe/searchByBox')
  Future<RecipeListPageResponse> searchByBox(
      @Queries() SearchQueries searchQueries);
}
