import 'package:ottugi_curry/model/recipe_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'recipe_repository.g.dart';

@RestApi(baseUrl: "http://192.168.0.51:8080")
abstract class RecipeRepository {
  factory RecipeRepository(Dio dio, {String baseUrl}) = _RecipeRepository;

  @GET('/api/recipe/getRecipeDetail')
  Future<RecipeResponse> getRecipeDetail(
      @Query("recipeId") int recipeId, @Query("userId") int userId);
}
