import 'package:ottugi_curry/model/rank_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'rank_repository.g.dart';

@RestApi()
abstract class RankRepository {
  factory RankRepository(Dio dio, {String baseUrl}) = _RankRepository;

  @GET('/api/rank/list')
  Future<List<RankResponse>> getRankList();

}