import 'package:dio/dio.dart';
import 'package:soundspace/interface/login_interface.dart';
import 'package:soundspace/models/user_model.dart';

class LoginService extends ILogin{
  @override
  Future<UserModel?> login(String email, String password) async{
    final api = 'https://localhost:7213/api/Auth/login';
    final data = {"email": email, "password": password};
    final dio = Dio();
    Response response;
    response = await dio.post(api, data: data);
    if(response.statusCode == 200){
      final body = response.data;
      return UserModel(name: body['displayName'], token: body['token']);
    }else{
      return null;
    }
  }
}