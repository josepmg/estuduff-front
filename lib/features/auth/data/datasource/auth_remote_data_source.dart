import 'dart:convert';
import 'dart:developer' as logger;
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:estuduff/core/platform/connection.dart';
import 'package:estuduff/core/platform/settings.dart';
import 'package:estuduff/features/auth/data/model/user_model.dart';
import 'package:estuduff/features/auth/domain/entity/user.dart';

abstract class AuthRemoteDataSource {
  Future<User> signIn(String email, String password);

  Future<User> signUp({
    String name,
    String email,
    String password,
    int programId,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<User> signIn(String email, String password) async {
    try {
      Response response = await Connection.post('/login',
          data: {
            "email": email,
            "password": _hashPassword(password),
          });
      return UserModel.fromJson(response.data);
    } catch (e) {
      logger.log(
        "Error: ${e.toString()}",
        name: "AuthRemoteDataSourceImpl - signIn",
      );
      throw e();
    }
  }

  @override
  Future<User> signUp({
    String name,
    String email,
    String password,
    int programId,
  }) async {
    try {
      Response response = await Connection.post('/register', data: {
        "name": name,
        "email": email,
        "password": _hashPassword(password),
        "programId": programId,
      });
      return UserModel.fromJson(response.data);
    } catch (e) {
      logger.log(
        "Error: ${e.toString()}",
        name: "AuthRemoteDataSourceImpl - signUp",
      );
      throw e();
    }
  }

  String _hashPassword(String plainText) {
    var hmacSha256 =
        new Hmac(sha256, utf8.encode(Settings.HMAC_KEY)); // HMAC-SHA256
    var ciphertext = hmacSha256.convert(utf8.encode(plainText));
    logger.log("ciphertext: $ciphertext",
        name: "AuthRemoteDataSourceImpl - _hashPassword");
    return ciphertext.toString();
  }
}
