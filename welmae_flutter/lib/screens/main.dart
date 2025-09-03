import 'package:flutter/material.dart';

// This file provides navigation helpers and constants for screen files
class ScreenRoutes {
  static const String onboarding = '/';
  static const String phoneInput = '/phone-input';
  static const String otpVerification = '/otp-verification';
  static const String userDetails = '/user-details';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String main = '/main';
  static const String home = '/home';
  static const String explore = '/explore';
  static const String trips = '/trips';
  static const String profile = '/profile';
  static const String favorites = '/favorites';
  static const String tripPlanner = '/trip-planner';
  static const String createPost = '/create-post';
  static const String posts = '/posts';
  static const String profileEdit = '/profile-edit';
  static const String friends = '/friends';
  static const String groupTravel = '/group-travel';
  static const String destination = '/destination';
  static const String search = '/search';
  static const String notifications = '/notifications';
}

class NavigationHelper {
  static void navigateToMain(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      ScreenRoutes.main,
      (Route<dynamic> route) => false,
    );
  }

  static void navigateToOnboarding(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      ScreenRoutes.onboarding,
      (Route<dynamic> route) => false,
    );
  }

  static void navigateToLogin(BuildContext context) {
    Navigator.of(context).pushNamed(ScreenRoutes.login);
  }

  static void navigateToRegister(BuildContext context) {
    Navigator.of(context).pushNamed(ScreenRoutes.register);
  }

  static void navigateToOtpVerification(
    BuildContext context, {
    required String phoneNumber,
  }) {
    Navigator.of(context).pushNamed(
      ScreenRoutes.otpVerification,
      arguments: {'phoneNumber': phoneNumber},
    );
  }

  static void navigateToUserDetails(BuildContext context) {
    Navigator.of(context).pushNamed(ScreenRoutes.userDetails);
  }

  static void navigateBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void navigateToDestination(
    BuildContext context,
    String destinationId,
  ) {
    Navigator.of(
      context,
    ).pushNamed(ScreenRoutes.destination, arguments: destinationId);
  }
}
