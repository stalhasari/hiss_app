
import 'package:dio/dio.dart';
import 'package:hiss_app/auth_services.dart';
import 'package:hiss_app/user/user_service.dart';

class SpotifyApi {
  final Dio _dio;

  SpotifyApi({
    String? basePathOverride,
    List<Interceptor>? interceptors,
  }) : _dio = Dio(
            BaseOptions(connectTimeout: 5000, receiveTimeout: 3000, headers: {
          'requiresToken': true,
        })) {
    if (interceptors != null) {
      _dio.interceptors.addAll(interceptors);
    }
  }


  

  AuthService get authClient {
    return AuthService(_dio);
  }


  UserService get userClient {
    return UserService(_dio);
  }


}