import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SoundHapticService {
  // Haptic Feedback Methods
  static void lightImpact() {
    HapticFeedback.lightImpact();
  }

  static void mediumImpact() {
    HapticFeedback.mediumImpact();
  }

  static void heavyImpact() {
    HapticFeedback.heavyImpact();
  }

  static void selectionClick() {
    HapticFeedback.selectionClick();
  }

  static void vibrate() {
    HapticFeedback.vibrate();
  }

  // Custom Haptic Patterns
  static void successPattern() {
    // Success pattern: light + medium
    lightImpact();
    Future.delayed(const Duration(milliseconds: 100), () {
      mediumImpact();
    });
  }

  static void errorPattern() {
    // Error pattern: heavy + light + heavy
    heavyImpact();
    Future.delayed(const Duration(milliseconds: 150), () {
      lightImpact();
      Future.delayed(const Duration(milliseconds: 100), () {
        heavyImpact();
      });
    });
  }

  static void notificationPattern() {
    // Notification pattern: light + light + medium
    lightImpact();
    Future.delayed(const Duration(milliseconds: 100), () {
      lightImpact();
      Future.delayed(const Duration(milliseconds: 100), () {
        mediumImpact();
      });
    });
  }

  static void achievementPattern() {
    // Achievement pattern: medium + light + medium + heavy
    mediumImpact();
    Future.delayed(const Duration(milliseconds: 100), () {
      lightImpact();
      Future.delayed(const Duration(milliseconds: 100), () {
        mediumImpact();
        Future.delayed(const Duration(milliseconds: 100), () {
          heavyImpact();
        });
      });
    });
  }

  // Interactive Haptic Feedback
  static void buttonPress() {
    selectionClick();
  }

  static void cardTap() {
    lightImpact();
  }

  static void swipeGesture() {
    mediumImpact();
  }

  static void longPress() {
    heavyImpact();
  }

  static void dragStart() {
    lightImpact();
  }

  static void dragEnd() {
    mediumImpact();
  }

  // Game-like Haptic Feedback
  static void scoreIncrease() {
    lightImpact();
  }

  static void levelUp() {
    successPattern();
  }

  static void achievementUnlocked() {
    achievementPattern();
  }

  static void gameOver() {
    errorPattern();
  }

  static void powerUp() {
    mediumImpact();
    Future.delayed(const Duration(milliseconds: 200), () {
      heavyImpact();
    });
  }

  // UI State Haptic Feedback
  static void stateChange() {
    lightImpact();
  }

  static void toggleSwitch() {
    selectionClick();
  }

  static void sliderMove() {
    lightImpact();
  }

  static void checkboxToggle() {
    selectionClick();
  }

  static void radioButtonSelect() {
    selectionClick();
  }

  // Navigation Haptic Feedback
  static void pageTransition() {
    lightImpact();
  }

  static void tabSwitch() {
    mediumImpact();
  }

  static void backNavigation() {
    lightImpact();
  }

  static void modalOpen() {
    mediumImpact();
  }

  static void modalClose() {
    lightImpact();
  }

  // Form Haptic Feedback
  static void inputFocus() {
    lightImpact();
  }

  static void inputBlur() {
    lightImpact();
  }

  static void validationError() {
    errorPattern();
  }

  static void validationSuccess() {
    successPattern();
  }

  static void successFeedback() {
    successPattern();
  }

  static void formSubmit() {
    mediumImpact();
  }

  // List and Grid Haptic Feedback
  static void itemSelect() {
    selectionClick();
  }

  static void itemDeselect() {
    lightImpact();
  }

  static void listScroll() {
    // Only trigger on significant scroll
    lightImpact();
  }

  static void gridItemTap() {
    lightImpact();
  }

  static void refreshPull() {
    mediumImpact();
  }

  // Search and Filter Haptic Feedback
  static void searchStart() {
    lightImpact();
  }

  static void searchResult() {
    mediumImpact();
  }

  static void filterApply() {
    selectionClick();
  }

  static void filterClear() {
    lightImpact();
  }

  // Animation Haptic Feedback
  static void animationStart() {
    lightImpact();
  }

  static void animationComplete() {
    mediumImpact();
  }

  static void loadingComplete() {
    successPattern();
  }

  static void loadingError() {
    errorPattern();
  }

  // Custom Duration Haptic Feedback
  static void customPattern(List<HapticFeedbackType> pattern, List<int> delays) {
    if (pattern.length != delays.length) return;
    
    for (int i = 0; i < pattern.length; i++) {
      Future.delayed(Duration(milliseconds: delays[i]), () {
        _triggerHaptic(pattern[i]);
      });
    }
  }

  static void _triggerHaptic(HapticFeedbackType type) {
    switch (type) {
      case HapticFeedbackType.lightImpact:
        lightImpact();
        break;
      case HapticFeedbackType.mediumImpact:
        mediumImpact();
        break;
      case HapticFeedbackType.heavyImpact:
        heavyImpact();
        break;
      case HapticFeedbackType.selectionClick:
        selectionClick();
        break;
      case HapticFeedbackType.vibrate:
        vibrate();
        break;
    }
  }

  // Adaptive Haptic Feedback
  static void adaptiveFeedback({
    required double intensity,
    required double duration,
  }) {
    // Convert intensity (0.0 to 1.0) to appropriate haptic type
    if (intensity < 0.3) {
      lightImpact();
    } else if (intensity < 0.7) {
      mediumImpact();
    } else {
      heavyImpact();
    }
    
    // If duration is long, add additional feedback
    if (duration > 1000) {
      Future.delayed(Duration(milliseconds: duration.toInt()), () {
        lightImpact();
      });
    }
  }

  // Context-Aware Haptic Feedback
  static void contextAwareFeedback({
    required String context,
    required bool isPositive,
    double? intensity,
  }) {
    switch (context) {
      case 'button':
        buttonPress();
        break;
      case 'card':
        cardTap();
        break;
      case 'navigation':
        pageTransition();
        break;
      case 'form':
        if (isPositive) {
          validationSuccess();
        } else {
          validationError();
        }
        break;
      case 'game':
        if (isPositive) {
          scoreIncrease();
        } else {
          gameOver();
        }
        break;
      case 'achievement':
        achievementUnlocked();
        break;
      default:
        // Default to light impact
        lightImpact();
    }
    
    // Override with custom intensity if provided
    if (intensity != null) {
      adaptiveFeedback(intensity: intensity, duration: 100);
    }
  }

  // Batch Haptic Feedback
  static void batchFeedback(List<HapticFeedbackType> feedbacks, {
    int delayBetween = 100,
  }) {
    for (int i = 0; i < feedbacks.length; i++) {
      Future.delayed(Duration(milliseconds: i * delayBetween), () {
        _triggerHaptic(feedbacks[i]);
      });
    }
  }

  // Conditional Haptic Feedback
  static void conditionalFeedback({
    required bool condition,
    required HapticFeedbackType trueFeedback,
    required HapticFeedbackType falseFeedback,
  }) {
    if (condition) {
      _triggerHaptic(trueFeedback);
    } else {
      _triggerHaptic(falseFeedback);
    }
  }

  // Delayed Haptic Feedback
  static void delayedFeedback({
    required HapticFeedbackType feedback,
    required int delayMs,
  }) {
    Future.delayed(Duration(milliseconds: delayMs), () {
      _triggerHaptic(feedback);
    });
  }

  // Repeating Haptic Feedback
  static void repeatingFeedback({
    required HapticFeedbackType feedback,
    required int repeatCount,
    required int intervalMs,
  }) {
    for (int i = 0; i < repeatCount; i++) {
      Future.delayed(Duration(milliseconds: i * intervalMs), () {
        _triggerHaptic(feedback);
      });
    }
  }
}

// Haptic Feedback Types Enum
enum HapticFeedbackType {
  lightImpact,
  mediumImpact,
  heavyImpact,
  selectionClick,
  vibrate,
}

// Haptic Feedback Manager
class HapticFeedbackManager {
  static bool _isEnabled = true;
  static double _intensity = 1.0;
  static bool _isVibrationEnabled = true;

  // Enable/Disable haptic feedback
  static void setEnabled(bool enabled) {
    _isEnabled = enabled;
  }

  static bool get isEnabled => _isEnabled;

  // Set intensity (0.0 to 1.0)
  static void setIntensity(double intensity) {
    _intensity = intensity.clamp(0.0, 1.0);
  }

  static double get intensity => _intensity;

  // Enable/Disable vibration
  static void setVibrationEnabled(bool enabled) {
    _isVibrationEnabled = enabled;
  }

  static bool get isVibrationEnabled => _isVibrationEnabled;

  // Trigger haptic with current settings
  static void trigger(HapticFeedbackType type) {
    if (!_isEnabled) return;
    
    // Apply intensity scaling
    if (_intensity < 0.3) {
      type = HapticFeedbackType.lightImpact;
    } else if (_intensity < 0.7) {
      type = HapticFeedbackType.mediumImpact;
    }
    
    SoundHapticService._triggerHaptic(type);
  }

  // Quick access methods
  static void light() => trigger(HapticFeedbackType.lightImpact);
  static void medium() => trigger(HapticFeedbackType.mediumImpact);
  static void heavy() => trigger(HapticFeedbackType.heavyImpact);
  static void select() => trigger(HapticFeedbackType.selectionClick);
  static void vibrate() {
    if (_isVibrationEnabled) {
      trigger(HapticFeedbackType.vibrate);
    }
  }
}

// Sound Effect Service (Placeholder for future implementation)
class SoundEffectService {
  // This would integrate with audio packages like audioplayers or just_audio
  // For now, it's a placeholder structure
  
  static void playSound(String soundName) {
    // Implementation would go here
    debugPrint('Playing sound: $soundName');
  }

  static void playSuccessSound() {
    playSound('success');
  }

  static void playErrorSound() {
    playSound('error');
  }

  static void playNotificationSound() {
    playSound('notification');
  }

  static void playAchievementSound() {
    playSound('achievement');
  }

  static void playButtonClickSound() {
    playSound('button_click');
  }

  static void playPageTransitionSound() {
    playSound('page_transition');
  }

  static void playCardFlipSound() {
    playSound('card_flip');
  }

  static void playCoinCollectSound() {
    playSound('coin_collect');
  }

  static void playLevelUpSound() {
    playSound('level_up');
  }

  static void playGameOverSound() {
    playSound('game_over');
  }
}
