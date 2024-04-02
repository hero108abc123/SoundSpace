import 'package:dio/dio.dart';
import 'package:soundspace/interface/interfaces.dart';

class EmailCheckService extends IEmailCheck{

  EmailCheck(String email) async{
    final api = 'https://localhost:7213/api/Auth/emailcheck';
    final data = {"email": email};
    final dio = Dio();
    Response response;
    response = await dio.post(api, data: data);
    if(response.statusCode == 200){
      return response.data['email'];
    }else{
      return null;
    }
  }
}