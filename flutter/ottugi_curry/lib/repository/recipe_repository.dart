import 'package:ottugi_curry/model/recipe_detail_response.dart';
import 'package:ottugi_curry/model/recipe_list_page_response.dart';
import 'package:ottugi_curry/model/search_queries.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'recipe_repository.g.dart';

@RestApi()
abstract class RecipeRepository {
  factory RecipeRepository(Dio dio, {String baseUrl}) = _RecipeRepository;

  // 레시피 상세
  @GET('/api/recipe')
  Future<RecipeDetailResponse> getRecipeDetail(
      @Query("recipeId") int recipeId, @Query("userId") int userId);

  // 레시피 검색 (이름, 옵션)
  @GET('/api/recipe/search')
  Future<RecipeListPageResponse> getSearch(
      @Queries() SearchQueries searchQueries);
}
