import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/user_model.dart';
import '../dummy_data.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  final Rx<User?> _firebaseUser = Rx<User?>(null);
  final Rx<UserModel?> _currentUser = Rx<UserModel?>(null);

  User? get firebaseUser => _firebaseUser.value;
  UserModel? get currentUser => _currentUser.value;
  User? get user => _firebaseUser.value;
  Rx<User?> get userRx => _firebaseUser;
  bool get isSignedIn => _firebaseUser.value != null;
  bool get isAdmin => _currentUser.value?.role == 'admin';
  bool get isTechnician => _currentUser.value?.role == 'technician';
  bool get isCustomer => _currentUser.value?.role == 'customer';

  @override
  void onInit() {
    super.onInit();
    _firebaseUser.bindStream(_auth.authStateChanges());
    ever(_firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) async {
    if (user == null) {
      Get.offAllNamed('/login');
    } else {
      await _loadUserData(user.uid);
      Get.offAllNamed('/base');
    }
  }

  Future<void> _loadUserData(String uid) async {
    try {
      final ref = _database.ref().child('users').child(uid);
      final snapshot = await ref.get();
      if (snapshot.exists) {
        final data = snapshot.value as Map<dynamic, dynamic>;
        _currentUser.value =
            UserModel.fromJson(Map<String, dynamic>.from(data));
        DummyData.setCurrentUser(_currentUser.value!);
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  Future<bool> signUpWithEmail({
    required String email,
    required String password,
    required String name,
    required String phone,
    String role = 'customer',
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        final user = UserModel(
          id: credential.user!.uid,
          name: name,
          email: email,
          phone: phone,
          role: role,
        );

        await _database
            .ref()
            .child('users')
            .child(credential.user!.uid)
            .set(user.toJson());
        _currentUser.value = user;
        DummyData.setCurrentUser(user);

        Get.snackbar(
          'Success! 🎉',
          'Account created successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      String message = 'An error occurred';
      if (e.code == 'weak-password') {
        message = 'The password is too weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists for this email';
      }
      Get.snackbar(
        'Error',
        message,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  Future<bool> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        await _loadUserData(credential.user!.uid);
        Get.snackbar(
          'Welcome! 🎉',
          'Signed in successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      String message = 'An error occurred';
      if (e.code == 'user-not-found') {
        message = 'No user found for this email';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided';
      }
      Get.snackbar(
        'Error',
        message,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      _currentUser.value = null;
      Get.snackbar(
        'Success',
        'Signed out successfully',
        backgroundColor: Colors.blue,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to sign out',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<bool> signInWithGoogle() async {
    try {
      Get.snackbar(
        'Coming Soon',
        'Google Sign-In will be available soon.',
        backgroundColor: Colors.blue,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Google Sign-In failed',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }
}
