import 'package:ottugi_curry/model/recipe_response.dart';
import 'package:ottugi_curry/model/rating_request.dart';
import 'package:ottugi_curry/model/rating_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'recommend_repository.g.dart';

@RestApi(baseUrl: "http://192.168.0.51:8080")
abstract class RecommendRepository {
  factory RecommendRepository(Dio dio, {String baseUrl}) = _RecommendRepository;

  @GET('/api/recommend/bookmark')
  Future<List<RecipeResponse>> getBookmark(
      @Query("page") int page, @Query("recipeId") int recipeId, @Query("userId") int userId);

  @GET('/api/recommend/rating')
  Future<List<RecipeResponse>> getRating(
      @Query("page") int page, @Query("bookmarkList") List<int> bookmarkList, @Query("userId") int userId);

  @GET('/api/recommend/user')
  Future<RatingResponse?> getUserRating(
      @Query("recipeId") int recipeId, @Query("userId") int userId);

  @POST('/api/recommend/user')
  Future<bool> postUserRating(
      @Body() RatingRequest ratingRequest);
}