import 'package:flutter/material.dart';
import '../app/theme/typography.dart';
import '../app/theme/dimensions.dart';

class NeumorphismWidgets {
  // Neumorphism Container
  static Widget buildNeumorphicContainer({
    required Widget child,
    double depth = 8.0,
    double intensity = 0.8,
    Color? baseColor,
    double borderRadius = 16.0,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    bool isPressed = false,
    bool isConcave = false,
  }) {
    final color = baseColor ?? Colors.grey[300]!;
    final pressedDepth = isPressed ? depth * 0.5 : depth;
    
    if (isConcave) {
      return Container(
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withValues(alpha: intensity),
              offset: Offset(-pressedDepth, -pressedDepth),
              blurRadius: pressedDepth,
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: intensity * 0.3),
              offset: Offset(pressedDepth, pressedDepth),
              blurRadius: pressedDepth,
            ),
          ],
        ),
        child: child,
      );
    }
    
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withValues(alpha: intensity),
            offset: Offset(-pressedDepth, -pressedDepth),
            blurRadius: pressedDepth,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: intensity * 0.3),
            offset: Offset(pressedDepth, pressedDepth),
            blurRadius: pressedDepth,
            spreadRadius: 1,
          ),
        ],
      ),
      child: child,
    );
  }

  // Neumorphism Button
  static Widget buildNeumorphicButton({
    required String text,
    required VoidCallback onPressed,
    IconData? icon,
    double depth = 8.0,
    double intensity = 0.8,
    Color? baseColor,
    double borderRadius = 16.0,
    EdgeInsetsGeometry? padding,
    Color? textColor,
    double? width,
    double? height,
    bool isPressed = false,
  }) {
    final color = baseColor ?? Colors.grey[300]!;
    final pressedDepth = isPressed ? depth * 0.5 : depth;
    
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: width,
        height: height,
        padding: padding ?? const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withValues(alpha: intensity),
              offset: Offset(-pressedDepth, -pressedDepth),
              blurRadius: pressedDepth,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: intensity * 0.3),
              offset: Offset(pressedDepth, pressedDepth),
              blurRadius: pressedDepth,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: textColor ?? Colors.grey[700],
                size: 20,
              ),
              const SizedBox(width: AppSpacing.sm),
            ],
            Text(
              text,
              style: AppTypography.bodyMedium.copyWith(
                color: textColor ?? Colors.grey[700],
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Neumorphism Card
  static Widget buildNeumorphicCard({
    required Widget child,
    double depth = 12.0,
    double intensity = 0.8,
    Color? baseColor,
    double borderRadius = 20.0,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    bool isPressed = false,
  }) {
    final color = baseColor ?? Colors.grey[200]!;
    final pressedDepth = isPressed ? depth * 0.5 : depth;
    
    return Container(
      margin: margin ?? const EdgeInsets.all(AppSpacing.md),
      padding: padding ?? const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withValues(alpha: intensity),
            offset: Offset(-pressedDepth, -pressedDepth),
            blurRadius: pressedDepth,
            spreadRadius: 2,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: intensity * 0.2),
            offset: Offset(pressedDepth, pressedDepth),
            blurRadius: pressedDepth,
            spreadRadius: 2,
          ),
        ],
      ),
      child: child,
    );
  }

  // Neumorphism Input Field
  static Widget buildNeumorphicInput({
    required String label,
    String? hint,
    TextEditingController? controller,
    bool obscureText = false,
    TextInputType? keyboardType,
    IconData? prefixIcon,
    IconData? suffixIcon,
    VoidCallback? onSuffixTap,
    double depth = 6.0,
    double intensity = 0.8,
    Color? baseColor,
    double borderRadius = 16.0,
    EdgeInsetsGeometry? padding,
    Color? textColor,
    Color? labelColor,
    bool isFocused = false,
  }) {
    final color = baseColor ?? Colors.grey[300]!;
    final focusDepth = isFocused ? depth * 0.3 : depth;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.bodySmall.copyWith(
            color: labelColor ?? Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Container(
          padding: padding ?? const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withValues(alpha: intensity),
                offset: Offset(-focusDepth, -focusDepth),
                blurRadius: focusDepth,
                spreadRadius: 1,
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: intensity * 0.3),
                offset: Offset(focusDepth, focusDepth),
                blurRadius: focusDepth,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            children: [
              if (prefixIcon != null) ...[
                Icon(
                  prefixIcon,
                  color: textColor ?? Colors.grey[600],
                  size: 20,
                ),
                const SizedBox(width: AppSpacing.sm),
              ],
              Expanded(
                child: TextField(
                  controller: controller,
                  obscureText: obscureText,
                  keyboardType: keyboardType,
                  style: TextStyle(
                    color: textColor ?? Colors.grey[700],
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: TextStyle(
                      color: textColor?.withValues(alpha: 0.5) ?? Colors.grey[500],
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              if (suffixIcon != null) ...[
                const SizedBox(width: AppSpacing.sm),
                GestureDetector(
                  onTap: onSuffixTap,
                  child: Icon(
                    suffixIcon,
                    color: textColor ?? Colors.grey[600],
                    size: 20,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  // Neumorphism Switch
  static Widget buildNeumorphicSwitch({
    required bool value,
    required ValueChanged<bool> onChanged,
    double depth = 6.0,
    double intensity = 0.8,
    Color? baseColor,
    Color? activeColor,
    double width = 60.0,
    double height = 30.0,
  }) {
    final color = baseColor ?? Colors.grey[300]!;
    final active = activeColor ?? Colors.blue;
    
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: value ? active : color,
          borderRadius: BorderRadius.circular(height / 2),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withValues(alpha: intensity),
              offset: Offset(-depth * 0.5, -depth * 0.5),
              blurRadius: depth * 0.5,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: intensity * 0.3),
              offset: Offset(depth * 0.5, depth * 0.5),
              blurRadius: depth * 0.5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: height - 4,
            height: height - 4,
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular((height - 4) / 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  offset: const Offset(1, 1),
                  blurRadius: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Neumorphism Slider
  static Widget buildNeumorphicSlider({
    required double value,
    required ValueChanged<double> onChanged,
    double min = 0.0,
    double max = 100.0,
    double depth = 8.0,
    double intensity = 0.8,
    Color? baseColor,
    Color? activeColor,
    double height = 20.0,
  }) {
    final color = baseColor ?? Colors.grey[300]!;
    final active = activeColor ?? Colors.blue;
    
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(height / 2),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withValues(alpha: intensity),
            offset: Offset(-depth * 0.5, -depth * 0.5),
            blurRadius: depth * 0.5,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: intensity * 0.3),
            offset: Offset(depth * 0.5, depth * 0.5),
            blurRadius: depth * 0.5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Stack(
        children: [
          // Active track
          Container(
            width: (value - min) / (max - min) * double.infinity,
            height: height,
            decoration: BoxDecoration(
              color: active,
              borderRadius: BorderRadius.circular(height / 2),
            ),
          ),
          // Thumb
          Positioned(
            left: (value - min) / (max - min) * (double.infinity - height) - height / 2,
            child: Container(
              width: height,
              height: height,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(height / 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    offset: const Offset(2, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Neumorphism Progress Bar
  static Widget buildNeumorphicProgressBar({
    required double progress,
    double depth = 6.0,
    double intensity = 0.8,
    Color? baseColor,
    Color? progressColor,
    double height = 20.0,
    double borderRadius = 10.0,
    bool showPercentage = true,
  }) {
    final color = baseColor ?? Colors.grey[300]!;
    final active = progressColor ?? Colors.blue;
    
    return Column(
      children: [
        Container(
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withValues(alpha: intensity),
                offset: Offset(-depth * 0.5, -depth * 0.5),
                blurRadius: depth * 0.5,
                spreadRadius: 1,
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: intensity * 0.3),
                offset: Offset(depth * 0.5, depth * 0.5),
                blurRadius: depth * 0.5,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Stack(
            children: [
              // Progress fill
              Container(
                width: progress * double.infinity,
                height: height,
                decoration: BoxDecoration(
                  color: active,
                  borderRadius: BorderRadius.circular(borderRadius),
                  boxShadow: [
                    BoxShadow(
                      color: active.withValues(alpha: 0.5),
                      offset: const Offset(1, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (showPercentage) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            '${(progress * 100).round()}%',
            style: AppTypography.bodySmall.copyWith(
              color: Colors.grey[600],
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ],
    );
  }

  // Neumorphism Toggle Button
  static Widget buildNeumorphicToggle({
    required List<String> options,
    required int selectedIndex,
    required ValueChanged<int> onChanged,
    double depth = 6.0,
    double intensity = 0.8,
    Color? baseColor,
    Color? activeColor,
    double height = 40.0,
  }) {
    final color = baseColor ?? Colors.grey[300]!;
    final active = activeColor ?? Colors.blue;
    
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(height / 2),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withValues(alpha: intensity),
            offset: Offset(-depth * 0.5, -depth * 0.5),
            blurRadius: depth * 0.5,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: intensity * 0.3),
            offset: Offset(depth * 0.5, depth * 0.5),
            blurRadius: depth * 0.5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Stack(
        children: [
          // Active background
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            left: selectedIndex * (double.infinity / options.length),
            child: Container(
              width: double.infinity / options.length,
              height: height,
              decoration: BoxDecoration(
                color: active,
                borderRadius: BorderRadius.circular(height / 2),
                boxShadow: [
                  BoxShadow(
                    color: active.withValues(alpha: 0.5),
                    offset: const Offset(1, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
            ),
          ),
          // Options
          Row(
            children: options.asMap().entries.map((entry) {
              final index = entry.key;
              final option = entry.value;
              final isSelected = index == selectedIndex;
              
              return Expanded(
                child: GestureDetector(
                  onTap: () => onChanged(index),
                  child: Container(
                    height: height,
                    alignment: Alignment.center,
                    child: Text(
                      option,
                      style: AppTypography.bodySmall.copyWith(
                        color: isSelected ? Colors.white : Colors.grey[600],
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // Neumorphism Floating Action Button
  static Widget buildNeumorphicFAB({
    required IconData icon,
    required VoidCallback onPressed,
    double depth = 12.0,
    double intensity = 0.8,
    Color? baseColor,
    Color? iconColor,
    double size = 56.0,
  }) {
    final color = baseColor ?? Colors.grey[300]!;
    
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(size / 2),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withValues(alpha: intensity),
              offset: Offset(-depth * 0.5, -depth * 0.5),
              blurRadius: depth * 0.5,
              spreadRadius: 2,
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: intensity * 0.3),
              offset: Offset(depth * 0.5, depth * 0.5),
              blurRadius: depth * 0.5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Icon(
          icon,
          color: iconColor ?? Colors.grey[700],
          size: size * 0.4,
        ),
      ),
    );
  }
}
