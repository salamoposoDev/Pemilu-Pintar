import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieCart extends StatelessWidget {
  const PieCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      legend: const Legend(isVisible: true),
      series: <PieSeries<_PieData, String>>[
        PieSeries<_PieData, String>(
          explode: true,
          explodeIndex: 0,
          dataSource: [
            _PieData('Survey 12000', 12000),
            _PieData('Quick Count 9700', 9700),
          ],
          xValueMapper: (_PieData data, _) => data.xData,
          yValueMapper: (_PieData data, _) => data.yData,
          dataLabelMapper: (_PieData data, _) => data.text,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
        ),
      ],
    );
  }
}

class _PieData {
  _PieData(this.xData, this.yData, [this.text]);
  final String xData;
  final num yData;
  String? text;
}
