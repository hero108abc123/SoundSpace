import 'package:dio/dio.dart';

abstract class IRegister {
  Register(String email, String password,String displayName, int age, String gender) async{
    final api = 'https://localhost:7213/api/Auth/register';
    final data = {"email": email, "password": password,"displayName": displayName, "age": age, "gender": gender};
    final dio = Dio();
    Response response;
    response = await dio.post(api, data: data);
    return response.data;
  }
}