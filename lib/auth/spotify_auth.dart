import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hiss_app/api_client.dart';
import 'package:hiss_app/storage.dart';

  const clientid = 'efa883dc56374ce29ca658a7bdde188a';
  const redirectUri = 'hissapp://http://127.0.0.1:65010/authorize_callback';
  const callbackUrlScheme = 'hissapp';
  const scope = 'user-read-private user-read-email user-library-read user-library-modify user-top-read user-follow-modify playlist-modify-public playlist-modify-private user-follow-read';
Future authenticate(BuildContext context) async {
  
  final authClient = spotifyApiGateway.authClient;
  final keyPair = authClient.getKeyPair();
  try {
    final code = await authClient.authorize(
      redirectUri: redirectUri,
      clientId: clientid,
      callbackUrlScheme: callbackUrlScheme,
      scope: scope,
      codeChallenge: keyPair.codeChallenge,
    );

    if (code == null) {
      debugPrint("Authorization failed.");
      return;
    }

    final tokenResponse = await authClient.getToken(
      code: code,
      codeVerifier: keyPair.codeVerifier,
      redirectUri: redirectUri,
      clientId: clientid,
      header: {
        'requiresToken': false,
      },
    );
    final storageService = StorageService();
    if (tokenResponse.refreshToken != null &&
        tokenResponse.accessToken != null) {
         storageService.saveToken(accessToken: tokenResponse.accessToken.toString(), refreshToken: tokenResponse.refreshToken.toString());
    }
    if (context.mounted == false) return;
        debugPrint('Yetkilendirildi');
  
  } on DioError catch (e) {
    debugPrint("DioError occurred: $e");
  }
}

class YetkilendirmeSonuclari {
  Future<String?> getCurrentUserProfile() async {
    final spotifyUserService = spotifyApiGateway.userClient;
    try{
      final profil = await spotifyUserService.getCurrentUsersProfile();
      return profil.displayName;
    } on DioError catch(e) {
      debugPrint('Hata ${e.message}');
      return null;
    }
  }
}

 
