import 'package:ottugi_curry/model/lately_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'lately_repository.g.dart';

@RestApi(baseUrl: "http://192.168.219.109:8080")
abstract class LatelyRepository {
  factory LatelyRepository(Dio dio, {String baseUrl}) = _LatelyRepository;

  @GET('/api/lately/getLatelyAll')
  Future<List<LatelyResponse>> getLatelyAll(@Query("userId") int id);
}
