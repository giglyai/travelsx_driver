// import 'package:flutter/material.dart';
// import 'package:travelx_driver/earning/models/earning_filter_model.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
//
// ///ColumnChart
// class ColumnChart extends StatelessWidget {
//   final double? width;
//   final double? barWidth;
//   final double? spacing;
//   final double? height;
//   final double plotAreaBorderWidth;
//   final Legend? legend;
//   final String? xAxisName;
//   final String? yAxisName;
//   final Color? barColor;
//   final Color? secondaryBarColor;
//   final String? labelFormat;
//   final Color? Function(Metric, int)? pointColorMapper;
//   final Widget Function(dynamic, dynamic, dynamic, int, int)? tooltipBuilder;
//   final List<Metric> chartData;
//   final bool isDoubleColumnGraph;
//
//   const ColumnChart(
//       {super.key,
//       this.width,
//       this.barWidth,
//       this.spacing,
//       this.height,
//       required this.plotAreaBorderWidth,
//       this.legend,
//       this.xAxisName,
//       this.yAxisName,
//       this.barColor,
//       this.secondaryBarColor,
//       this.labelFormat,
//       this.pointColorMapper,
//       this.tooltipBuilder,
//       required this.chartData,
//       required this.isDoubleColumnGraph});
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//         width: width,
//         height: height,
//         child: SfCartesianChart(
//           plotAreaBorderWidth: plotAreaBorderWidth,
//           legend: legend ?? Legend(isVisible: false),
//           primaryXAxis: CategoryAxis(
//               title: AxisTitle(
//             text: yAxisName,
//           )),
//           primaryYAxis: NumericAxis(
//               labelFormat: labelFormat,
//               title: AxisTitle(
//                 text: xAxisName,
//               )),
//           series: _getDefaultColumnSeries(),
//           tooltipBehavior: TooltipBehavior(
//             tooltipPosition: TooltipPosition.auto,
//             enable: true,
//             builder: tooltipBuilder,
//           ),
//         ));
//   }
//
//   /// Returns the list of chart series which need to render on the columnchart.
//   List<ColumnSeries<Metric, String>> _getDefaultColumnSeries() {
//     return <ColumnSeries<Metric, String>>[
//       ColumnSeries<Metric, String>(
//           pointColorMapper: pointColorMapper,
//           color: barColor,
//           width: barWidth,
//           spacing: spacing ?? 0,
//           dataSource: chartData,
//           xValueMapper: (Metric sales, _) => sales.date,
//           yValueMapper: (Metric sales, _) {
//             print("Sales ${int.tryParse(sales.totalFee.toString()) ?? 1}");
//
//             return double.tryParse(sales.totalFee ?? "0.0");
//           }),
//     ];
//   }
//   //
//   // /// Returns the list of chart series which need to render on the columnchart.
//   // List<ColumnSeries<Metric, String>> _getDoublyColumnSeries() {
//   //   return <ColumnSeries<Metric, String>>[
//   //     ColumnSeries<Metric, String>(
//   //       color: barColor,
//   //       width: barWidth,
//   //       spacing: spacing ?? 0,
//   //       dataSource: chartData,
//   //       xValueMapper: (Metric sales, _) => sales.totalFee as String,
//   //       yValueMapper: (Metric sales, _) => 10,
//   //     ),
//   //     ColumnSeries<Metric, String>(
//   //       color: secondaryBarColor,
//   //       width: barWidth,
//   //       spacing: spacing ?? 0,
//   //       dataSource: chartData,
//   //       xValueMapper: (Metric sales, _) => sales.totalFee as String,
//   //       yValueMapper: (Metric sales, _) => 10,
//   //     ),
//   //   ];
//   // }
// }
