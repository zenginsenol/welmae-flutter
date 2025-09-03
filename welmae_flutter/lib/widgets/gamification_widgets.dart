import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../app/theme/typography.dart';
import '../app/theme/dimensions.dart';
import '../app/theme/colors.dart';

class GamificationWidgets {
  // Achievement Badge Widget
  static Widget buildAchievementBadge({
    required String title,
    required String description,
    required IconData icon,
    required AchievementLevel level,
    required bool isUnlocked,
    double size = 80.0,
    VoidCallback? onTap,
  }) {
    final colors = _getAchievementColors(level);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: isUnlocked
              ? RadialGradient(
                  colors: [colors['primary']!, colors['secondary']!],
                  center: Alignment.topLeft,
                  radius: 0.8,
                )
              : null,
          color: isUnlocked ? null : Colors.grey[300],
          boxShadow: isUnlocked
              ? [
                  BoxShadow(
                    color: colors['primary']!.withValues(alpha: 0.4),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ]
              : null,
        ),
        child: Stack(
          children: [
            // Icon
            Center(
              child: Icon(
                icon,
                color: isUnlocked ? Colors.white : Colors.grey[500],
                size: size * 0.4,
              ),
            ),

            // Level indicator
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: size * 0.3,
                height: size * 0.3,
                decoration: BoxDecoration(
                  color: isUnlocked ? colors['accent']! : Colors.grey[400],
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Center(
                  child: Text(
                    _getLevelSymbol(level),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size * 0.15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            // Lock overlay
            if (!isUnlocked)
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withValues(alpha: 0.3),
                ),
                child: Center(
                  child: Icon(
                    Icons.lock,
                    color: Colors.white,
                    size: size * 0.3,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Progress Bar with Animation
  static Widget buildProgressBar({
    required double currentValue,
    required double targetValue,
    required String title,
    String? subtitle,
    Color? progressColor,
    Color? backgroundColor,
    double height = 20.0,
    bool showPercentage = true,
    bool showAnimation = true,
  }) {
    final progress = (currentValue / targetValue).clamp(0.0, 1.0);
    final color = progressColor ?? AppColors.primary;
    final background = backgroundColor ?? Colors.grey[300]!;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTypography.titleSmall.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (showPercentage)
                Text(
                  '${(progress * 100).round()}%',
                  style: AppTypography.bodySmall.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
          if (subtitle != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              subtitle,
              style: AppTypography.bodySmall.copyWith(color: Colors.grey[600]),
            ),
          ],
          const SizedBox(height: AppSpacing.sm),

          // Progress bar
          Container(
            height: height,
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(height / 2),
            ),
            child: Stack(
              children: [
                // Background
                Container(
                  height: height,
                  decoration: BoxDecoration(
                    color: background,
                    borderRadius: BorderRadius.circular(height / 2),
                  ),
                ),

                // Progress fill
                AnimatedContainer(
                  duration: showAnimation
                      ? const Duration(milliseconds: 800)
                      : Duration.zero,
                  width: progress * double.infinity,
                  height: height,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [color, color.withValues(alpha: 0.8)],
                    ),
                    borderRadius: BorderRadius.circular(height / 2),
                    boxShadow: [
                      BoxShadow(
                        color: color.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),

                // Shimmer effect
                if (showAnimation && progress > 0)
                  _buildShimmerEffect(height, progress),
              ],
            ),
          ),

          // Values
          const SizedBox(height: AppSpacing.xs),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                currentValue.toStringAsFixed(1),
                style: AppTypography.bodySmall.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              Text(
                targetValue.toStringAsFixed(1),
                style: AppTypography.bodySmall.copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Level Progress Widget
  static Widget buildLevelProgress({
    required int currentLevel,
    required double currentXP,
    required double xpForNextLevel,
    required String title,
    Color? levelColor,
    double size = 120.0,
  }) {
    final color = levelColor ?? AppColors.primary;
    final progress = (currentXP / xpForNextLevel).clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          Text(
            title,
            style: AppTypography.titleMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Level circle
          SizedBox(
            width: size,
            height: size,
            child: Stack(
              children: [
                // Background circle
                Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[200],
                  ),
                ),

                // Progress circle
                CustomPaint(
                  size: Size(size, size),
                  painter: LevelProgressPainter(
                    progress: progress,
                    color: color,
                    strokeWidth: 8.0,
                  ),
                ),

                // Level number
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        currentLevel.toString(),
                        style: TextStyle(
                          fontSize: size * 0.3,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                      Text(
                        'Seviye',
                        style: AppTypography.bodySmall.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          // XP progress
          Text(
            '${currentXP.toStringAsFixed(0)} / ${xpForNextLevel.toStringAsFixed(0)} XP',
            style: AppTypography.bodyMedium.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // Streak Counter Widget
  static Widget buildStreakCounter({
    required int currentStreak,
    required int bestStreak,
    required String title,
    required IconData streakIcon,
    Color? streakColor,
    bool showAnimation = true,
  }) {
    final color = streakColor ?? Colors.orange;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color.withValues(alpha: 0.1), color.withValues(alpha: 0.05)],
        ),
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: AppTypography.titleMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Streak icon with animation
          AnimatedContainer(
            duration: showAnimation
                ? const Duration(milliseconds: 500)
                : Duration.zero,
            transform: Matrix4.identity()..scale(showAnimation ? 1.1 : 1.0),
            child: Icon(streakIcon, color: color, size: 48),
          ),

          const SizedBox(height: AppSpacing.md),

          // Current streak
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                currentStreak.toString(),
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                'gün',
                style: AppTypography.bodyMedium.copyWith(color: color),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.sm),

          // Best streak
          Text(
            'En iyi: $bestStreak gün',
            style: AppTypography.bodySmall.copyWith(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  // Reward Card Widget
  static Widget buildRewardCard({
    required String title,
    required String description,
    required IconData icon,
    required RewardType type,
    required bool isAvailable,
    VoidCallback? onClaim,
    double height = 120.0,
  }) {
    final colors = _getRewardColors(type);

    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isAvailable
              ? [colors['primary']!, colors['secondary']!]
              : [Colors.grey[400]!, Colors.grey[500]!],
        ),
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        boxShadow: [
          BoxShadow(
            color: (isAvailable ? colors['primary']! : Colors.grey[400]!)
                .withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isAvailable ? onClaim : null,
          borderRadius: BorderRadius.circular(AppSizes.radiusLg),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                // Icon
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Icon(icon, color: Colors.white, size: 30),
                ),

                const SizedBox(width: AppSpacing.md),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: AppTypography.titleSmall.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        description,
                        style: AppTypography.bodySmall.copyWith(
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                // Claim button
                if (isAvailable)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                    ),
                    child: Text(
                      'Al',
                      style: AppTypography.bodySmall.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Leaderboard Widget
  static Widget buildLeaderboard({
    required List<LeaderboardEntry> entries,
    required String title,
    int maxEntries = 10,
    Color? topRankColor,
  }) {
    final topColor = topRankColor ?? Colors.amber;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTypography.titleMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          ...entries.take(maxEntries).toList().asMap().entries.map((entry) {
            final index = entry.key;
            final user = entry.value;
            final isTop3 = index < 3;

            return Container(
              margin: const EdgeInsets.only(bottom: AppSpacing.sm),
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: isTop3
                    ? topColor.withValues(alpha: 0.1)
                    : Colors.grey[50],
                borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                border: Border.all(
                  color: isTop3
                      ? topColor.withValues(alpha: 0.3)
                      : Colors.grey[200]!,
                ),
              ),
              child: Row(
                children: [
                  // Rank
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: isTop3 ? topColor : Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        (index + 1).toString(),
                        style: TextStyle(
                          color: isTop3 ? Colors.white : Colors.grey[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: AppSpacing.md),

                  // User info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name,
                          style: AppTypography.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (user.subtitle != null) ...[
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            user.subtitle!,
                            style: AppTypography.bodySmall.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  // Score
                  Text(
                    user.score.toString(),
                    style: AppTypography.titleMedium.copyWith(
                      color: isTop3 ? topColor : Colors.grey[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  // Helper Methods
  static Map<String, Color> _getAchievementColors(AchievementLevel level) {
    switch (level) {
      case AchievementLevel.bronze:
        return {
          'primary': Colors.orange[700]!,
          'secondary': Colors.orange[500]!,
          'accent': Colors.orange[300]!,
        };
      case AchievementLevel.silver:
        return {
          'primary': Colors.grey[600]!,
          'secondary': Colors.grey[400]!,
          'accent': Colors.grey[300]!,
        };
      case AchievementLevel.gold:
        return {
          'primary': Colors.amber[600]!,
          'secondary': Colors.amber[400]!,
          'accent': Colors.amber[300]!,
        };
      case AchievementLevel.platinum:
        return {
          'primary': Colors.blue[600]!,
          'secondary': Colors.blue[400]!,
          'accent': Colors.blue[300]!,
        };
      case AchievementLevel.diamond:
        return {
          'primary': Colors.purple[600]!,
          'secondary': Colors.purple[400]!,
          'accent': Colors.purple[300]!,
        };
    }
  }

  static String _getLevelSymbol(AchievementLevel level) {
    switch (level) {
      case AchievementLevel.bronze:
        return '🥉';
      case AchievementLevel.silver:
        return '🥈';
      case AchievementLevel.gold:
        return '🥇';
      case AchievementLevel.platinum:
        return '💎';
      case AchievementLevel.diamond:
        return '💠';
    }
  }

  static Map<String, Color> _getRewardColors(RewardType type) {
    switch (type) {
      case RewardType.xp:
        return {'primary': Colors.green[600]!, 'secondary': Colors.green[400]!};
      case RewardType.coin:
        return {'primary': Colors.amber[600]!, 'secondary': Colors.amber[400]!};
      case RewardType.gem:
        return {'primary': Colors.blue[600]!, 'secondary': Colors.blue[400]!};
      case RewardType.item:
        return {
          'primary': Colors.purple[600]!,
          'secondary': Colors.purple[400]!,
        };
    }
  }

  static Widget _buildShimmerEffect(double height, double progress) {
    return Container(
      width: progress * double.infinity,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            Colors.white.withValues(alpha: 0.3),
            Colors.transparent,
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
        borderRadius: BorderRadius.circular(height / 2),
      ),
    );
  }
}

// Enums
enum AchievementLevel { bronze, silver, gold, platinum, diamond }

enum RewardType { xp, coin, gem, item }

// Data Models
class LeaderboardEntry {
  final String name;
  final String? subtitle;
  final int score;
  final String? avatar;

  LeaderboardEntry({
    required this.name,
    this.subtitle,
    required this.score,
    this.avatar,
  });
}

// Custom Painters
class LevelProgressPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;

  LevelProgressPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
