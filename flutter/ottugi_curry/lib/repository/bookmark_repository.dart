import 'package:ottugi_curry/model/search_queries.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:ottugi_curry/model/bookmark_update.dart';
import 'package:ottugi_curry/model/recipe_list_page_response.dart';

part 'bookmark_repository.g.dart';

@RestApi()
abstract class BookmarkRepository {
  factory BookmarkRepository(Dio dio, {String baseUrl}) = _BookmarkRepository;

  // 북마크 추가, 삭제
  @POST('/api/bookmark')
  Future<bool> postBookmark(@Body() Bookmark param);

  // 북마크 목록 조회
  @GET('/api/bookmark/list')
  Future<RecipeListPageResponse> getBookmark(@Query("page") int? page,
      @Query("size") int? size, @Query("userId") int id);

  // 북마크 검색 (이름, 옵션)
  @GET('/api/bookmark/search')
  Future<RecipeListPageResponse> getSearch(
      @Queries() SearchQueries searchQueries);
}
