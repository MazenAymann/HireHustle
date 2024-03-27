// import 'package:dio/dio.dart';
//
// class CharactersWebServices {
//   late Dio dio;
//
//   CharactersWebServices() {
//     BaseOptions options = BaseOptions(
//       baseUrl: '',
//       receiveDataWhenStatusError: true,
//       connectTimeout: Duration(seconds: 3), // 60 seconds,
//       receiveTimeout: Duration(seconds: 3),
//     );
//
//     dio = Dio(options);
//   }
//
//   Future<List<dynamic>> getAllCharacters() async {
//     try {
//       // Endpoint
//       Response response = await dio.get('characters');
//       print(response.data.toString());
//       return response.data.map((character) => Character.fromJson(character)).toList();
//     } catch (e) {
//       print(e.toString());
//       return [];
//     }
//
//   }
//
//   Future<List<dynamic>> getCharacterQuotes(String charName) async {
//     try {
//       Response response = await dio.get('quote' , queryParameters: {'author' : charName});
//       print(response.data.toString());
//       return response.data.map((character) => Character.fromJson(character)).toList();
//     } catch (e) {
//       print(e.toString());
//       return [];
//     }
//   }
//
//
//
// }