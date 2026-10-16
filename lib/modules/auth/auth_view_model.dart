import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/routes/app_routes.dart';
import '../../core/utils/validators.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/cart_repository.dart';
import '../../data/repositories/order_repository.dart';
import '../../data/repositories/user_repository.dart';

/// Shared auth logic for Login & Register screens (MVVM ViewModel).
class AuthViewModel extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  // Login fields
  final TextEditingController loginIdentifier = TextEditingController();
  final TextEditingController loginPassword = TextEditingController();

  // Register fields
  final TextEditingController registerName = TextEditingController();
  final TextEditingController registerEmail = TextEditingController();
  final TextEditingController registerPhone = TextEditingController();
  final TextEditingController registerPassword = TextEditingController();

  final RxBool obscurePassword = true.obs;
  final RxBool isLoading = false.obs;
  final RxBool rememberMe = true.obs;

  void toggleObscure() => obscurePassword.value = !obscurePassword.value;

  // ---------------- Login ----------------
  Future<void> login() async {
    if (!(loginFormKey.currentState?.validate() ?? false)) return;
    isLoading.value = true;
    try {
      final user = await _authRepository.login(
        loginIdentifier.text.trim(),
        loginPassword.text,
      );
      _ensureDependencies();
      Get.snackbar(
        'Welcome back!',
        'Signed in as ${user.fullName}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.12),
        margin: const EdgeInsets.all(12),
      );
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      Get.snackbar(
        'Sign in failed',
        e.toString().replaceFirst('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.12),
        margin: const EdgeInsets.all(12),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ---------------- Register ----------------
  Future<void> register() async {
    if (!(registerFormKey.currentState?.validate() ?? false)) return;
    isLoading.value = true;
    try {
      await _authRepository.register(
        fullName: registerName.text.trim(),
        email: registerEmail.text.trim(),
        phone: registerPhone.text.trim(),
        password: registerPassword.text,
      );
      _ensureDependencies();
      Get.snackbar(
        'Account created',
        'Welcome to Shoe Store!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.12),
        margin: const EdgeInsets.all(12),
      );
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      Get.snackbar(
        'Registration failed',
        e.toString().replaceFirst('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.12),
        margin: const EdgeInsets.all(12),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ---------------- Social ----------------
  Future<void> signInWithGoogle() async {
    isLoading.value = true;
    try {
      await _authRepository.signInWithGoogle();
      _ensureDependencies();
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      Get.snackbar(
        'Google sign-in',
        e.toString().replaceFirst('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(12),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithFacebook() async {
    // Plug in flutter_facebook_auth here if needed.
    Get.snackbar(
      'Facebook',
      'Facebook sign-in is configured via your Meta developer app.',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(12),
    );
  }

  Future<void> signInWithApple() async {
    isLoading.value = true;
    try {
      await _authRepository.signInWithApple();
      _ensureDependencies();
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      Get.snackbar(
        'Apple sign-in',
        e.toString().replaceFirst('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(12),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void forgotPassword() {
    final email = loginIdentifier.text.trim();
    if (Validators.email(email) == null) {
      _authRepository.sendPasswordReset(email);
    }
    Get.snackbar(
      'Reset link sent',
      'Check your inbox to reset the password.',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(12),
    );
  }

  void goToRegister() => Get.toNamed(AppRoutes.register);
  void goToLogin() => Get.back();

  /// Registers shared data repositories used across the app.
  void _ensureDependencies() {
    if (!Get.isRegistered<CartRepository>()) Get.put(CartRepository());
    if (!Get.isRegistered<OrderRepository>()) Get.put(OrderRepository());
    if (!Get.isRegistered<UserRepository>()) Get.put(UserRepository());
  }

  @override
  void onClose() {
    loginIdentifier.dispose();
    loginPassword.dispose();
    registerName.dispose();
    registerEmail.dispose();
    registerPhone.dispose();
    registerPassword.dispose();
    super.onClose();
  }
}
