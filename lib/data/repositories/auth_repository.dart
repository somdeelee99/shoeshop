import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../core/services/storage_service.dart';
import '../mock/mock_data.dart';
import '../models/user_model.dart';
import '../providers/api_endpoints.dart';
import '../providers/api_provider.dart';

/// Handles email/phone + password auth and social sign-in.
class AuthRepository {
  AuthRepository({ApiProvider? provider});

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  /// Login with email/phone + password. Falls back to mock session.
  Future<UserModel> login(String identifier, String password) async {
    if (ApiProvider.useMock) {
      await Future<void>.delayed(const Duration(milliseconds: 900));
      await StorageService.setToken('mock-token-${DateTime.now().millisecond}');
      return MockData.user;
    }
    try {
      final response = await ApiProvider.post(
        ApiEndpoints.login,
        data: {'identifier': identifier, 'password': password},
      );
      final data = response.data as Map<String, dynamic>;
      await StorageService.setToken(data['token'] as String);
      return UserModel.fromJson(data['user'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  Future<UserModel> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
    if (ApiProvider.useMock) {
      await Future<void>.delayed(const Duration(milliseconds: 1100));
      await StorageService.setToken('mock-token-${DateTime.now().millisecond}');
      return MockData.user.copyWith(
        fullName: fullName,
        email: email,
        phone: phone,
      );
    }
    try {
      final response = await ApiProvider.post(
        ApiEndpoints.register,
        data: {
          'full_name': fullName,
          'email': email,
          'phone': phone,
          'password': password,
        },
      );
      final data = response.data as Map<String, dynamic>;
      await StorageService.setToken(data['token'] as String);
      return UserModel.fromJson(data['user'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  /// Google sign-in → backend session exchange.
  Future<UserModel> signInWithGoogle() async {
    try {
      final account = await _googleSignIn.signIn();
      if (account == null) throw Exception('Google sign-in cancelled');
      final auth = await account.authentication;
      debugPrint('Google idToken: ${auth.idToken != null}');

      if (ApiProvider.useMock) {
        await StorageService.setToken('mock-google-token');
        return MockData.user.copyWith(
          fullName: account.displayName ?? MockData.user.fullName,
          email: account.email,
          avatarUrl: account.photoUrl ?? MockData.user.avatarUrl,
        );
      }

      final response = await ApiProvider.post(
        ApiEndpoints.socialLogin,
        data: {
          'provider': 'google',
          'id_token': auth.idToken,
          'access_token': auth.accessToken,
        },
      );
      final data = response.data as Map<String, dynamic>;
      await StorageService.setToken(data['token'] as String);
      return UserModel.fromJson(data['user'] as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Google sign-in failed: $e');
    }
  }

  /// Apple sign-in (iOS / macOS only).
  Future<UserModel> signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      if (ApiProvider.useMock) {
        await StorageService.setToken('mock-apple-token');
        return MockData.user.copyWith(
          email: credential.email ?? MockData.user.email,
          fullName:
              '${credential.givenName ?? ''} ${credential.familyName ?? ''}'
                      .trim()
                      .isEmpty
                  ? MockData.user.fullName
                  : '${credential.givenName ?? ''} ${credential.familyName ?? ''}'
                      .trim(),
        );
      }

      final response = await ApiProvider.post(
        ApiEndpoints.socialLogin,
        data: {
          'provider': 'apple',
          'identity_token': credential.identityToken,
          'authorization_code': credential.authorizationCode,
        },
      );
      final data = response.data as Map<String, dynamic>;
      await StorageService.setToken(data['token'] as String);
      return UserModel.fromJson(data['user'] as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Apple sign-in failed: $e');
    }
  }

  Future<void> logout() async {
    try {
      await _googleSignIn.signOut();
    } catch (_) {}
    await StorageService.clearSession();
  }

  Future<bool> isLoggedIn() async {
    final token = await StorageService.getToken();
    return token != null && token.isNotEmpty;
  }

  Future<void> sendPasswordReset(String email) async {
    if (ApiProvider.useMock) {
      await Future<void>.delayed(const Duration(milliseconds: 600));
      return;
    }
    await ApiProvider.post('/auth/forgot-password', data: {'email': email});
  }

  Exception _mapError(DioException e) {
    final message = e.response?.data is Map
        ? (e.response!.data['message'] as String? ?? 'Request failed')
        : 'Network error. Please try again.';
    return Exception(message);
  }
}
