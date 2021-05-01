import 'package:dio/dio.dart';
import 'package:login/models/user.dart';

class AuthenticationBloc {
  static Future<User> login(String email, String password) async {
    try {
      Response response;
      var dio = Dio();
      response = await dio.put('https://jsonplaceholder.typicode.com/posts/2',
          data: {'id': "1", 'title': email, 'body': password, 'userId': 0});
      print(response.data.toString());
      print(response.statusCode);

      if (response.statusCode != 200) return null;

      return User.fromJson(response.data);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
