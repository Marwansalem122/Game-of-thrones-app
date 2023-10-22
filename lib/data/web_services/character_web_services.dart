import 'package:bloc_test/constant/string.dart';
import 'package:dio/dio.dart';

class CharactersWebServices {
  late Dio dio;

  CharactersWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: basUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(milliseconds: 20 * 1000),
      receiveTimeout: const Duration(milliseconds: 20 * 1000),
    );
    dio = Dio(options);
  }
  Future<List<dynamic>> getAllcharacters() async {
    try {
      Response response = await dio.get("Characters");
   //  print(response.data.toString());
      return response.data;
    } catch (e) {
    //  print(e.toString());
      return [];
    }
  }
}
