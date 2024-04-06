import 'package:soundspace/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource{
  Future<String> signUp({
    required String email,
    required String password,
    required String displayName,
    required int age,
    required String? gender,
  });
  Future<String> login({
    required String email,
    required String password,
  });

  Future<String> emailCheck({
    required String email,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource{
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImpl(this.supabaseClient)

  @override
  Future<String> emailCheck({
    required String email,
  }) {
    // TODO: implement emailCheck
    throw UnimplementedError();
  }

  @override
  Future<String> login({
    required String email, 
    required String password,
  }) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<String> signUp({
    required String email, 
    required String password, 
    required String displayName, 
    required int age, 
    required String? gender,
  }) async{
    try{
      final response = await supabaseClient.auth.signUp(
      password: password, 
      email: email,
      data: {
        'displayName': displayName,
        'age' : age,
        'gender': gender,

      }
    );
    if (response.user == null){
      throw const ServerException('User is null!');
    }
    return response.user!.id;
    }catch(e){
      throw ServerException(e.toString());
    }
  }

}