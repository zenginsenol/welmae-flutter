import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';
import 'app_spacing.dart';

class AppWidgets {
  // App Bar - Detaylı ve güçlü tasarım
  static AppBar appBar({
    required String title,
    Widget? leading,
    List<Widget>? actions,
    bool automaticallyImplyLeading = true,
    bool centerTitle = true,
    double? elevation,
    Color? backgroundColor,
    Color? foregroundColor,
    PreferredSizeWidget? bottom,
    double? toolbarHeight,
    double? titleSpacing,
    double? leadingWidth,
  }) {
    return AppBar(
      title: Text(
        title,
        style: AppTextStyles.headlineMedium.copyWith(
          color: foregroundColor ?? AppColors.onPrimary,
        ),
      ),
      leading: leading,
      actions: actions,
      automaticallyImplyLeading: automaticallyImplyLeading,
      centerTitle: centerTitle,
      elevation: elevation ?? 0,
      backgroundColor: backgroundColor ?? AppColors.primary,
      foregroundColor: foregroundColor ?? AppColors.onPrimary,
      bottom: bottom,
      toolbarHeight: toolbarHeight ?? kToolbarHeight,
      titleSpacing: titleSpacing ?? NavigationToolbar.kMiddleSpacing,
      leadingWidth: leadingWidth ?? 48,
    );
  }

  // Elevated Button - Detaylı ve güçlü tasarım
  static Widget elevatedButton({
    required String text,
    required VoidCallback onPressed,
    Color? backgroundColor,
    Color? foregroundColor,
    double? elevation,
    EdgeInsetsGeometry? padding,
    BorderSide? borderSide,
    OutlinedBorder? shape,
    Widget? icon,
    Widget? label,
    bool? isExpanded,
    double? width,
    double? height,
    bool? isLoading,
    bool? isFullWidth,
  }) {
    return SizedBox(
      width: isFullWidth == true ? double.infinity : width,
      height: height ?? 56,
      child: ElevatedButton(
        onPressed: isLoading == true ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primary,
          foregroundColor: foregroundColor ?? AppColors.onPrimary,
          elevation: elevation ?? 2,
          padding:
              padding ??
              const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.md,
              ),
          side: borderSide ?? BorderSide.none,
          shape:
              shape ??
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.sm),
              ),
        ),
        child: isLoading == true
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    foregroundColor ?? AppColors.onPrimary,
                  ),
                ),
              )
            : Row(
                mainAxisSize: isExpanded == true
                    ? MainAxisSize.max
                    : MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[icon, SizedBox(width: AppSpacing.sm)],
                  label ??
                      Text(
                        text,
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: foregroundColor ?? AppColors.onPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                ],
              ),
      ),
    );
  }

  // Outlined Button - Detaylı ve güçlü tasarım
  static Widget outlinedButton({
    required String text,
    required VoidCallback onPressed,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderColor,
    double? elevation,
    EdgeInsetsGeometry? padding,
    BorderSide? borderSide,
    OutlinedBorder? shape,
    Widget? icon,
    Widget? label,
    bool? isExpanded,
    double? width,
    double? height,
    bool? isLoading,
    bool? isFullWidth,
  }) {
    return SizedBox(
      width: isFullWidth == true ? double.infinity : width,
      height: height ?? 56,
      child: OutlinedButton(
        onPressed: isLoading == true ? null : onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor ?? Colors.transparent,
          foregroundColor: foregroundColor ?? AppColors.primary,
          elevation: elevation ?? 0,
          padding:
              padding ??
              const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.md,
              ),
          side:
              borderSide ??
              BorderSide(color: borderColor ?? AppColors.primary, width: 1),
          shape:
              shape ??
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.sm),
              ),
        ),
        child: isLoading == true
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    foregroundColor ?? AppColors.primary,
                  ),
                ),
              )
            : Row(
                mainAxisSize: isExpanded == true
                    ? MainAxisSize.max
                    : MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[icon, SizedBox(width: AppSpacing.sm)],
                  label ??
                      Text(
                        text,
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: foregroundColor ?? AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                ],
              ),
      ),
    );
  }

  // Text Button - Detaylı ve güçlü tasarım
  static Widget textButton({
    required String text,
    required VoidCallback onPressed,
    Color? foregroundColor,
    EdgeInsetsGeometry? padding,
    TextStyle? textStyle,
    Widget? icon,
    bool? isExpanded,
    bool? isLoading,
  }) {
    return TextButton(
      onPressed: isLoading == true ? null : onPressed,
      style: TextButton.styleFrom(
        foregroundColor: foregroundColor ?? AppColors.primary,
        padding:
            padding ??
            const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
      ),
      child: isLoading == true
          ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  foregroundColor ?? AppColors.primary,
                ),
              ),
            )
          : Row(
              mainAxisSize: isExpanded == true
                  ? MainAxisSize.max
                  : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[icon, SizedBox(width: AppSpacing.sm)],
                Text(
                  text,
                  style:
                      textStyle ??
                      AppTextStyles.bodyLarge.copyWith(
                        color: foregroundColor ?? AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
    );
  }

  // Input Field - Detaylı ve güçlü tasarım
  static Widget inputField({
    required String labelText,
    required TextEditingController controller,
    String? hintText,
    TextInputType? keyboardType,
    bool? obscureText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    int? maxLines,
    int? minLines,
    bool? enabled,
    bool? readOnly,
    TextInputAction? textInputAction,
    void Function(String?)? onSaved,
    void Function()? onTap,
    bool? autofocus,
    TextCapitalization? textCapitalization,
    TextAlign? textAlign,
    bool? expands,
    int? maxLength,
    bool? enableIMEPersonalizedLearning,
    bool? enableInteractiveSelection,
    bool? enableSuggestions,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.sm),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.sm),
          borderSide: BorderSide(color: AppColors.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.sm),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.sm),
          borderSide: BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.sm),
          borderSide: BorderSide(color: AppColors.error, width: 2),
        ),
      ),
      keyboardType: keyboardType,
      obscureText: obscureText ?? false,
      validator: validator,
      onChanged: onChanged,
      maxLines: maxLines,
      minLines: minLines,
      enabled: enabled,
      readOnly: readOnly ?? false,
      textInputAction: textInputAction,
      onSaved: onSaved,
      onTap: onTap,
      autofocus: autofocus ?? false,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      textAlign: textAlign ?? TextAlign.start,
      expands: expands ?? false,
      maxLength: maxLength,
      enableIMEPersonalizedLearning: enableIMEPersonalizedLearning ?? true,
      enableInteractiveSelection: enableInteractiveSelection ?? true,
      enableSuggestions: enableSuggestions ?? true,
    );
  }

  // Card - Detaylı ve güçlü tasarım
  static Widget card({
    required Widget child,
    Color? color,
    Color? shadowColor,
    double? elevation,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    VoidCallback? onTap,
    bool? hasShadow,
  }) {
    return Card(
      color: color ?? AppColors.surface,
      shadowColor: shadowColor ?? Colors.black,
      elevation: hasShadow == false ? 0 : (elevation ?? 2),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(AppSpacing.md),
      ),
      margin: margin ?? const EdgeInsets.all(AppSpacing.md),
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius ?? BorderRadius.circular(AppSpacing.md),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(AppSpacing.lg),
          child: child,
        ),
      ),
    );
  }

  // Divider - Detaylı ve güçlü tasarım
  static Widget divider({
    Color? color,
    double? height,
    double? thickness,
    double? indent,
    double? endIndent,
  }) {
    return Divider(
      color: color ?? AppColors.outline,
      height: height ?? 1,
      thickness: thickness ?? 1,
      indent: indent ?? 0,
      endIndent: endIndent ?? 0,
    );
  }

  // Loading Indicator - Detaylı ve güçlü tasarım
  static Widget loadingIndicator({
    Color? color,
    double? strokeWidth,
    double? size,
  }) {
    return SizedBox(
      width: size ?? 40,
      height: size ?? 40,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth ?? 4,
        valueColor: AlwaysStoppedAnimation<Color>(color ?? AppColors.primary),
      ),
    );
  }

  // Error Widget - Detaylı ve güçlü tasarım
  static Widget errorWidget({
    required String message,
    VoidCallback? onRetry,
    Color? color,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error_outline, color: color ?? AppColors.error, size: 48),
        SizedBox(height: AppSpacing.md),
        Text(
          message,
          style: AppTextStyles.bodyLarge.copyWith(
            color: color ?? AppColors.error,
          ),
          textAlign: TextAlign.center,
        ),
        if (onRetry != null) ...[
          SizedBox(height: AppSpacing.lg),
          elevatedButton(text: 'Tekrar Dene', onPressed: onRetry),
        ],
      ],
    );
  }

  // Empty State Widget - Detaylı ve güçlü tasarım
  static Widget emptyState({
    required String title,
    String? message,
    Widget? icon,
    VoidCallback? onAction,
    String? actionText,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[icon, SizedBox(height: AppSpacing.xl)],
        Text(
          title,
          style: AppTextStyles.headlineSmall,
          textAlign: TextAlign.center,
        ),
        if (message != null) ...[
          SizedBox(height: AppSpacing.md),
          Text(
            message,
            style: AppTextStyles.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
        if (onAction != null && actionText != null) ...[
          SizedBox(height: AppSpacing.xl),
          elevatedButton(text: actionText, onPressed: onAction),
        ],
      ],
    );
  }
}
