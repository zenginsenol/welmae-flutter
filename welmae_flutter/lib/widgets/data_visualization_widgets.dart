import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../app/theme/typography.dart';
import '../app/theme/dimensions.dart';
import '../app/theme/colors.dart';

class DataVisualizationWidgets {
  // Line Chart Widget
  static Widget buildLineChart({
    required List<ChartDataPoint> dataPoints,
    required String title,
    Color? lineColor,
    Color? fillColor,
    Color? gridColor,
    double height = 200.0,
    bool showGrid = true,
    bool showPoints = true,
    bool showArea = true,
  }) {
    final line = lineColor ?? AppColors.primary;
    final fill = fillColor ?? line.withValues(alpha: 0.1);
    final grid = gridColor ?? Colors.grey[300]!;
    
    return Container(
      height: height,
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
          Expanded(
            child: CustomPaint(
              painter: LineChartPainter(
                dataPoints: dataPoints,
                lineColor: line,
                fillColor: fill,
                gridColor: grid,
                showGrid: showGrid,
                showPoints: showPoints,
                showArea: showArea,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Bar Chart Widget
  static Widget buildBarChart({
    required List<ChartDataPoint> dataPoints,
    required String title,
    Color? barColor,
    Color? gridColor,
    double height = 200.0,
    bool showGrid = true,
    bool showValues = true,
    bool horizontal = false,
  }) {
    final bars = barColor ?? AppColors.primary;
    final grid = gridColor ?? Colors.grey[300]!;
    
    return Container(
      height: height,
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
          Expanded(
            child: CustomPaint(
              painter: BarChartPainter(
                dataPoints: dataPoints,
                barColor: bars,
                gridColor: grid,
                showGrid: showGrid,
                showValues: showValues,
                horizontal: horizontal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Pie Chart Widget
  static Widget buildPieChart({
    required List<ChartDataPoint> dataPoints,
    required String title,
    double size = 200.0,
    bool showLabels = true,
    bool showValues = true,
    bool showLegend = true,
  }) {
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
          SizedBox(
            width: size,
            height: size,
            child: CustomPaint(
              painter: PieChartPainter(
                dataPoints: dataPoints,
                showLabels: showLabels,
                showValues: showValues,
              ),
            ),
          ),
          if (showLegend) ...[
            const SizedBox(height: AppSpacing.md),
            _buildPieChartLegend(dataPoints),
          ],
        ],
      ),
    );
  }

  // Area Chart Widget
  static Widget buildAreaChart({
    required List<ChartDataPoint> dataPoints,
    required String title,
    Color? areaColor,
    Color? lineColor,
    Color? gridColor,
    double height = 200.0,
    bool showGrid = true,
    bool showLine = true,
    bool showGradient = true,
  }) {
    final area = areaColor ?? AppColors.primary;
    final line = lineColor ?? area;
    final grid = gridColor ?? Colors.grey[300]!;
    
    return Container(
      height: height,
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
          Expanded(
            child: CustomPaint(
              painter: AreaChartPainter(
                dataPoints: dataPoints,
                areaColor: area,
                lineColor: line,
                gridColor: grid,
                showGrid: showGrid,
                showLine: showLine,
                showGradient: showGradient,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Radar Chart Widget
  static Widget buildRadarChart({
    required List<ChartDataPoint> dataPoints,
    required String title,
    Color? fillColor,
    Color? lineColor,
    Color? gridColor,
    double size = 200.0,
    bool showGrid = true,
    bool showLabels = true,
    bool showValues = true,
  }) {
    final fill = fillColor ?? AppColors.primary;
    final line = lineColor ?? fill;
    final grid = gridColor ?? Colors.grey[300]!;
    
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
          SizedBox(
            width: size,
            height: size,
            child: CustomPaint(
              painter: RadarChartPainter(
                dataPoints: dataPoints,
                fillColor: fill,
                lineColor: line,
                gridColor: grid,
                showGrid: showGrid,
                showLabels: showLabels,
                showValues: showValues,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Gauge Chart Widget
  static Widget buildGaugeChart({
    required double value,
    required double min,
    required double max,
    required String title,
    String? unit,
    Color? gaugeColor,
    Color? backgroundColor,
    double size = 150.0,
    bool showValue = true,
    bool showMinMax = true,
  }) {
    final gauge = gaugeColor ?? AppColors.primary;
    final background = backgroundColor ?? Colors.grey[300]!;
    
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
          SizedBox(
            width: size,
            height: size,
            child: CustomPaint(
              painter: GaugeChartPainter(
                value: value,
                min: min,
                max: max,
                gaugeColor: gauge,
                backgroundColor: background,
                showValue: showValue,
                showMinMax: showMinMax,
                unit: unit,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Timeline Widget
  static Widget buildTimeline({
    required List<TimelineEvent> events,
    required String title,
    Color? lineColor,
    Color? eventColor,
    bool showConnectors = true,
    bool showDates = true,
  }) {
    final line = lineColor ?? AppColors.primary;
    final event = eventColor ?? line;
    
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
          CustomPaint(
            painter: TimelinePainter(
              events: events,
              lineColor: line,
              eventColor: event,
              showConnectors: showConnectors,
              showDates: showDates,
            ),
            child: SizedBox(
              height: events.length * 80.0,
              child: Column(
                children: events.map((event) => _buildTimelineEventItem(event)).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Heatmap Widget
  static Widget buildHeatmap({
    required List<List<double>> data,
    required List<String> rowLabels,
    required List<String> columnLabels,
    required String title,
    Color? lowColor,
    Color? highColor,
    bool showValues = true,
    bool showLegend = true,
  }) {
    final low = lowColor ?? Colors.blue;
    final high = highColor ?? Colors.red;
    
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
          CustomPaint(
            painter: HeatmapPainter(
              data: data,
              rowLabels: rowLabels,
              columnLabels: columnLabels,
              lowColor: low,
              highColor: high,
              showValues: showValues,
            ),
            child: SizedBox(
              height: data.length * 40.0 + 60.0,
              width: data[0].length * 60.0 + 100.0,
            ),
          ),
          if (showLegend) ...[
            const SizedBox(height: AppSpacing.md),
            _buildHeatmapLegend(low, high),
          ],
        ],
      ),
    );
  }

  // Helper Methods
  static Widget _buildPieChartLegend(List<ChartDataPoint> dataPoints) {
    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.sm,
      children: dataPoints.map((point) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: point.color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              point.label,
              style: AppTypography.bodySmall,
            ),
          ],
        );
      }).toList(),
    );
  }

  static Widget _buildTimelineEventItem(TimelineEvent event) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: event.color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: AppTypography.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (event.description != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    event.description!,
                    style: AppTypography.bodySmall.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
                if (event.date != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    event.date!,
                    style: AppTypography.bodySmall.copyWith(
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildHeatmapLegend(Color lowColor, Color highColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Düşük',
          style: AppTypography.bodySmall,
        ),
        const SizedBox(width: AppSpacing.sm),
        Container(
          width: 100,
          height: 20,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [lowColor, highColor],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          'Yüksek',
          style: AppTypography.bodySmall,
        ),
      ],
    );
  }
}

// Data Models
class ChartDataPoint {
  final String label;
  final double value;
  final Color? color;
  final String? description;

  ChartDataPoint({
    required this.label,
    required this.value,
    this.color,
    this.description,
  });
}

class TimelineEvent {
  final String title;
  final String? description;
  final String? date;
  final Color? color;

  TimelineEvent({
    required this.title,
    this.description,
    this.date,
    this.color,
  });
}

// Custom Painters
class LineChartPainter extends CustomPainter {
  final List<ChartDataPoint> dataPoints;
  final Color lineColor;
  final Color fillColor;
  final Color gridColor;
  final bool showGrid;
  final bool showPoints;
  final bool showArea;

  LineChartPainter({
    required this.dataPoints,
    required this.lineColor,
    required this.fillColor,
    required this.gridColor,
    required this.showGrid,
    required this.showPoints,
    required this.showArea,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (dataPoints.isEmpty) return;

    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    // Calculate scales
    final maxValue = dataPoints.map((p) => p.value).reduce(math.max);
    final minValue = dataPoints.map((p) => p.value).reduce(math.min);
    final valueRange = maxValue - minValue;

    // Draw grid
    if (showGrid) {
      for (int i = 0; i <= 5; i++) {
        final y = size.height - (i / 5) * size.height;
        canvas.drawLine(
          Offset(0, y),
          Offset(size.width, y),
          gridPaint,
        );
      }
    }

    // Create path for line and area
    final path = Path();
    final areaPath = Path();

    for (int i = 0; i < dataPoints.length; i++) {
      final point = dataPoints[i];
      final x = (i / (dataPoints.length - 1)) * size.width;
      final y = size.height - ((point.value - minValue) / valueRange) * size.height;

      if (i == 0) {
        path.moveTo(x, y);
        areaPath.moveTo(x, y);
      } else {
        path.lineTo(x, y);
        areaPath.lineTo(x, y);
      }

      // Draw points
      if (showPoints) {
        canvas.drawCircle(Offset(x, y), 4, paint);
      }
    }

    // Draw area
    if (showArea) {
      areaPath.lineTo(size.width, size.height);
      areaPath.lineTo(0, size.height);
      areaPath.close();
      canvas.drawPath(areaPath, fillPaint);
    }

    // Draw line
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class BarChartPainter extends CustomPainter {
  final List<ChartDataPoint> dataPoints;
  final Color barColor;
  final Color gridColor;
  final bool showGrid;
  final bool showValues;
  final bool horizontal;

  BarChartPainter({
    required this.dataPoints,
    required this.barColor,
    required this.gridColor,
    required this.showGrid,
    required this.showValues,
    required this.horizontal,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (dataPoints.isEmpty) return;

    final paint = Paint()
      ..color = barColor
      ..style = PaintingStyle.fill;

    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    // Calculate scales
    final maxValue = dataPoints.map((p) => p.value).reduce(math.max);
    final barWidth = horizontal ? size.height / dataPoints.length : size.width / dataPoints.length;
    final barSpacing = barWidth * 0.2;

    // Draw grid
    if (showGrid) {
      for (int i = 0; i <= 5; i++) {
        if (horizontal) {
          final y = (i / 5) * size.height;
          canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
        } else {
          final x = (i / 5) * size.width;
          canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
        }
      }
    }

    // Draw bars
    for (int i = 0; i < dataPoints.length; i++) {
      final point = dataPoints[i];
      final barLength = (point.value / maxValue) * (horizontal ? size.width : size.height);

      if (horizontal) {
        final y = i * barWidth + barSpacing / 2;
        final rect = Rect.fromLTWH(0, y, barLength, barWidth - barSpacing);
        canvas.drawRect(rect, paint);
      } else {
        final x = i * barWidth + barSpacing / 2;
        final rect = Rect.fromLTWH(x, size.height - barLength, barWidth - barSpacing, barLength);
        canvas.drawRect(rect, paint);
      }

      // Draw values
      if (showValues) {
        textPainter.text = TextSpan(
          text: point.value.toStringAsFixed(1),
          style: AppTypography.bodySmall,
        );
        textPainter.layout();

        if (horizontal) {
          final y = i * barWidth + barWidth / 2 - textPainter.height / 2;
          textPainter.paint(canvas, Offset(barLength + 5, y));
        } else {
          final x = i * barWidth + barWidth / 2 - textPainter.width / 2;
          textPainter.paint(canvas, Offset(x, size.height - barLength - textPainter.height - 5));
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class PieChartPainter extends CustomPainter {
  final List<ChartDataPoint> dataPoints;
  final bool showLabels;
  final bool showValues;

  PieChartPainter({
    required this.dataPoints,
    required this.showLabels,
    required this.showValues,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (dataPoints.isEmpty) return;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 * 0.8;
    final total = dataPoints.map((p) => p.value).reduce((a, b) => a + b);

    double startAngle = 0;
    for (final point in dataPoints) {
      final sweepAngle = (point.value / total) * 2 * math.pi;
      final paint = Paint()
        ..color = point.color ?? AppColors.primary
        ..style = PaintingStyle.fill;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class AreaChartPainter extends CustomPainter {
  final List<ChartDataPoint> dataPoints;
  final Color areaColor;
  final Color lineColor;
  final Color gridColor;
  final bool showGrid;
  final bool showLine;
  final bool showGradient;

  AreaChartPainter({
    required this.dataPoints,
    required this.areaColor,
    required this.lineColor,
    required this.gridColor,
    required this.showGrid,
    required this.showLine,
    required this.showGradient,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Similar to LineChartPainter but with gradient fill
    // Implementation details...
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class RadarChartPainter extends CustomPainter {
  final List<ChartDataPoint> dataPoints;
  final Color fillColor;
  final Color lineColor;
  final Color gridColor;
  final bool showGrid;
  final bool showLabels;
  final bool showValues;

  RadarChartPainter({
    required this.dataPoints,
    required this.fillColor,
    required this.lineColor,
    required this.gridColor,
    required this.showGrid,
    required this.showLabels,
    required this.showValues,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Radar chart implementation
    // Implementation details...
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class GaugeChartPainter extends CustomPainter {
  final double value;
  final double min;
  final double max;
  final Color gaugeColor;
  final Color backgroundColor;
  final bool showValue;
  final bool showMinMax;
  final String? unit;

  GaugeChartPainter({
    required this.value,
    required this.min,
    required this.max,
    required this.gaugeColor,
    required this.backgroundColor,
    required this.showValue,
    required this.showMinMax,
    this.unit,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Gauge chart implementation
    // Implementation details...
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class TimelinePainter extends CustomPainter {
  final List<TimelineEvent> events;
  final Color lineColor;
  final Color eventColor;
  final bool showConnectors;
  final bool showDates;

  TimelinePainter({
    required this.events,
    required this.lineColor,
    required this.eventColor,
    required this.showConnectors,
    required this.showDates,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Timeline implementation
    // Implementation details...
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class HeatmapPainter extends CustomPainter {
  final List<List<double>> data;
  final List<String> rowLabels;
  final List<String> columnLabels;
  final Color lowColor;
  final Color highColor;
  final bool showValues;

  HeatmapPainter({
    required this.data,
    required this.rowLabels,
    required this.columnLabels,
    required this.lowColor,
    required this.highColor,
    required this.showValues,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Heatmap implementation
    // Implementation details...
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
