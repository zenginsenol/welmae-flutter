import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'screens/welcome_onboarding_screen.dart';
import 'screens/new_onboarding_screen.dart';
import 'screens/auth/new_otp_verification_screen.dart';
import 'screens/auth/user_details_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/signup_success_screen.dart';
import 'screens/location_selection_screen.dart';
import 'screens/country_selection_screen.dart';
import 'screens/country_map_screen.dart';
import 'screens/phone_login_screen.dart';
import 'screens/home_page.dart';
import 'screens/explore_screen.dart';
import 'screens/create_trip_screen.dart';
import 'screens/create_trip_details_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/subscription_screen.dart';
import 'screens/messages_screen.dart';
import 'screens/trip_management_screen.dart';
import 'screens/profile_guide_screen.dart';
import 'screens/profile_settings_screen.dart';
import 'app/theme/theme.dart';
import 'app/theme/typography.dart';
import 'providers/app_provider.dart';
import 'providers/user_provider.dart';
import 'providers/auth_provider.dart';

void main() {
  runApp(const WelmaeMinimalApp());
}

class WelmaeMinimalApp extends StatelessWidget {
  const WelmaeMinimalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()..initializeAuth()),
      ],
      child: Consumer<AppProvider>(
        builder: (context, appProvider, child) {
          return MaterialApp(
            title: 'Welmae',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.light, // Force light theme for now
            initialRoute: '/', // Change initial route back to splash screen
            routes: {
              '/': (context) => const SplashScreen(),
              '/welcome-onboarding': (context) =>
                  const WelcomeOnboardingScreen(),
              '/phone-onboarding': (context) => const NewOnboardingScreen(),
              '/location-selection': (context) => const LocationSelectionScreen(),
              '/country-selection': (context) => const CountrySelectionScreen(),
              '/country-map': (context) => const CountryMapScreen(),
              '/phone-login': (context) => const PhoneLoginScreen(),
              '/login': (context) => const LoginScreen(),
              '/signup': (context) => const SignupScreen(),
              '/signup-success': (context) => const SignupSuccessScreen(),
              '/home': (context) => const HomePage(),
              '/explore': (context) => const ExploreScreen(),
              '/create-trip': (context) => const CreateTripScreen(),
              '/profile': (context) => const ProfileScreen(),
              '/subscription': (context) => const SubscriptionScreen(),
              '/messages': (context) => const MessagesScreen(),
              '/trip-management': (context) => const TripManagementScreen(),
              '/profile-guide': (context) => const ProfileGuideScreen(),
              '/profile-settings': (context) => const ProfileSettingsScreen(),
            },
            onGenerateRoute: (settings) {
              if (settings.name == '/otp-verification') {
                final args = settings.arguments as Map<String, dynamic>;
                return MaterialPageRoute(
                  builder: (context) => NewOtpVerificationScreen(
                    phoneNumber: args['phoneNumber'],
                    otpId: args['otpId'],
                    expiresAt: args['expiresAt'],
                  ),
                );
              }
              if (settings.name == '/user-details') {
                final args = settings.arguments as Map<String, dynamic>?;
                return MaterialPageRoute(
                  builder: (context) => UserDetailsScreen(
                    phoneNumber: args?['phoneNumber'] ?? '',
                    isNewUser: args?['isNewUser'] ?? true,
                  ),
                );
              }
              if (settings.name == '/create-trip-details') {
                final args = settings.arguments as Map<String, dynamic>;
                return MaterialPageRoute(
                  builder: (context) => CreateTripDetailsScreen(
                    tripType: args['tripType'],
                    title: args['title'],
                  ),
                );
              }

              return null;
            },
          );
        },
      ),
    );
  }
}
