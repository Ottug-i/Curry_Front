import 'package:ottugi_curry/model/ingredient_request.dart';
import 'package:ottugi_curry/model/recipe_list_page_response.dart';
import 'package:ottugi_curry/model/recipe_response.dart';
import 'package:ottugi_curry/model/rating_request.dart';
import 'package:ottugi_curry/model/rating_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'recommend_repository.g.dart';

@RestApi()
abstract class RecommendRepository {
  factory RecommendRepository(Dio dio, {String baseUrl}) = _RecommendRepository;

  // 북마크에 따른 추천 레시피 조회
  @GET('/api/recommend/bookmark/list')
  Future<List<RecipeResponse>> getRecommendBookmarkList(
      @Query("page") int page, @Query("recipeId") int recipeId, @Query("userId") int userId);

  // 재료에 따른 추천 레시피 조회
  @POST('/api/recommend/ingredients/list')
  Future<RecipeListPageResponse> postRecommendIngredientsList(
      @Body() IngredientRequest ingredientRequest);

  // 초기 랜덤 레시피 평점
  @GET('/api/recommend/initial')
  Future<List<RecipeResponse>> getRecommendInitialRating();

  // 레시피 평점 조회
  @GET('/api/recommend/rating')
  Future<RatingResponse?> getRecommendRating(
      @Query("recipeId") int recipeId, @Query("userId") int userId);

  // 레시피 평점 추가/수정
  @POST('/api/recommend/rating')
  Future<bool> postRecommendRating(
      @Body() RatingRequest ratingRequest);

  // 레시피 평점 삭제
  @DELETE('/api/recommend/rating')
  Future<bool> deleteRecommendRating(
      @Query("recipeId") int recipeId, @Query("userId") int userId);

  // 레시피 평점에 따른 추천 레시피 조회
  @GET('/api/recommend/rating/list')
  Future<List<RecipeResponse>> getRecommendRatingList(
      @Query("page") int page, @Query("bookmarkList") List<int> bookmarkList, @Query("userId") int userId);
}