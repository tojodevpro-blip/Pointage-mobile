import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../theme/app_tokens.dart';

class PresencePoint {
  const PresencePoint({required this.label, required this.value});

  final String label;
  final int value;
}

class PresenceBarChart extends StatelessWidget {
  const PresenceBarChart({super.key, required this.points});

  final List<PresencePoint> points;

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    final maxValue = points.fold<int>(
      0,
      (value, point) => math.max(value, point.value),
    );
    return BarChart(
      BarChartData(
        maxY: math.max(1, (maxValue * 1.25).ceilToDouble()),
        alignment: BarChartAlignment.spaceAround,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= points.length) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    points[index].label,
                    style: TextStyle(fontSize: 10, color: tokens.muted),
                  ),
                );
              },
            ),
          ),
        ),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (_) => tokens.text,
            getTooltipItem: (group, groupIndex, rod, rodIndex) =>
                BarTooltipItem(
                  '${points[group.x].value}',
                  TextStyle(color: tokens.surface, fontWeight: FontWeight.w700),
                ),
          ),
        ),
        barGroups: [
          for (var i = 0; i < points.length; i++)
            BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: points[i].value.toDouble(),
                  width: 18,
                  color: tokens.primary,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(6),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
