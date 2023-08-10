import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:ottugi_curry/model/bookmark_update.dart';
import 'package:ottugi_curry/model/recipe_list_page_response.dart';

part 'bookmark_repository.g.dart';

@RestApi(baseUrl: "http://192.168.0.51:8080")
abstract class BookmarkRepository {
  factory BookmarkRepository(Dio dio, {String baseUrl}) = _BookmarkRepository;

  // 북마크 추가, 삭제
  @POST('/api/bookmark/addAndRemoveBookmark')
  Future<bool> updateBookmark(@Body() Bookmark param);

  // 북마크 목록
  @GET('/api/bookmark/getBookmarkAll')
  Future<RecipeListPageResponse> getBookmark(@Query("page") int? page,
      @Query("size") int? size, @Query("userId") int id);

  // 이름으로 검색
  @GET('/api/bookmark/searchByName')
  Future<RecipeListPageResponse> searchByName(
      @Query("page") int? page,
      @Query("size") int? size,
      @Query("userId") int id,
      @Query("name") String name);

  // 옵션으로 검색
  @GET('/api/bookmark/searchByOption')
  Future<RecipeListPageResponse> searchByOption(
      @Query("page") int? page,
      @Query("size") int? size,
      @Query("userId") int id,
      @Query("composition") String? composition,
      @Query("difficulty") String? difficulty,
      @Query("time") String? time);
}
