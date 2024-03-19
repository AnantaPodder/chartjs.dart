// Copyright (c) 2015, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:html';
import 'dart:math' as math;

import 'package:chartjs/chartjs.dart';

void main() {
  var rnd = math.Random();
  var dates = <DateTime>[DateTime.parse('2012-01-12'), DateTime.parse('2012-02-18'), DateTime.parse('2012-03-08'), DateTime.parse('2012-04-22'), DateTime.parse('2012-05-18'), DateTime.parse('2012-06-18'),
  DateTime.parse('2012-08-18'), DateTime.parse('2012-10-18'), DateTime.parse('2012-12-13'), DateTime.parse('2013-02-29'), DateTime.parse('2013-04-19'), DateTime.parse('2013-06-19')];

  var data = LinearChartData(datasets: <ChartDataSets>[
    ChartDataSets(
        label: 'My First dataset',
        backgroundColor: 'rgba(220,220,220,0.5)',
        data: dates.map((d) => ChartPoint(x: d.toString(), y:rnd.nextInt(100))).toList(),
        fill: '+1',
        ),
    ChartDataSets(
        label: 'My Second dataset',
        backgroundColor: 'rgba(151,187,205,0.7)',
        data: dates.map((d)  => ChartPoint(x: d.toString(), y:rnd.nextInt(100))).toList()
        )]);

  var config = ChartConfiguration(
      type: 'line',
      data: data,
      options: ChartOptions(
	      animation: ChartAnimationOptions(duration: 1000, easing: 'easeOutSine'),
	      scales: ChartScales(type: 'linear', xAxes: [ChartXAxe(type: 'time', bounds: 'ticks',
                  ticks: TimeTickOptions(source: 'auto', display: true, major: MajorMinorTickOptions(fontStyle: 'bold', fontColor: 'red')), 
                  time: TimeScale(tooltipFormat: 'MM/DD/YYYY', unit: 'month', stepSize: 2, displayFormats: TimeDisplayFormat(year: 'MMM YYYY',month: 'MMM YYYY')), 
                  scaleLabel: ScaleTitleOptions(labelString: 'Time', display: true, padding: 20)
                  )], 
            yAxes: [ChartYAxe(ticks: LinearTickOptions(beginAtZero: true, max: 120, stepSize: 5), scaleLabel: ScaleTitleOptions(labelString: 'Value', display: true, padding: 20))]),
	      tooltips: ChartTooltipOptions(enabled:true, titleFontColor: '#ff7f7b', bodyFontSize:24, mode:'nearest', caretSize: 15, 
            callbacks:ChartTooltipCallback(labelTextColor: (item, chart) => data.datasets[item.datasetIndex].backgroundColor)),
	      responsive: true));

  var data2 = LinearChartData(datasets: <ChartDataSets>[
    ChartDataSets(
        label: 'My First dataset',
        backgroundColor: 'rgba(220,220,220,0.5)',
        data: dates.sublist(0,6).map((d) => ChartPoint(x: d.toString(), y:rnd.nextInt(100))).toList(),
        borderWidth: BorderWidthConfig(left: 4, top: 8)
        ),
    ChartDataSets(
        label: 'My Second dataset',
        backgroundColor: 'rgba(151,187,205,0.7)',
        data: dates.sublist(0,6).map((d)  => ChartPoint(x: d.toString(), y:rnd.nextInt(100))).toList(),
        borderWidth: (_) => rnd.nextInt(5) +2,
        )]);
  var config2 = ChartConfiguration(
      type: 'bar',
      data: data2,
      options: ChartOptions(
	      animation: ChartAnimationOptions(duration: 1000, easing: 'easeOutSine'),
	      scales: ChartScales(type: 'linear', 
            xAxes: [ChartXAxe(type: 'time', distribution: 'series',
                  maxBarThickness: 20,
                  offset: true,
                  ticks: TimeTickOptions(source: 'data', display: true), 
                  gridLines: GridLineOptions(offsetGridLines: true),
                  time: TimeScale(tooltipFormat: 'MM/DD/YYYY', displayFormats: TimeDisplayFormat(month: 'll')), 
                  scaleLabel: ScaleTitleOptions(labelString: 'Time', display: true, padding: 20)
                  )], 
            yAxes: [ChartYAxe( minBarLength: 20,
                  ticks: LinearTickOptions(beginAtZero: true, max: 120, stepSize: 5), 
                  scaleLabel: ScaleTitleOptions(labelString: 'Value', display: true, padding: 20))]),
	      tooltips: ChartTooltipOptions(enabled:true, titleFontColor: '#ff7f7b', bodyFontSize:24, mode:'index', axis: 'x', caretSize: 15, intersect: false),
	      responsive: true));

  var colors = <String>['Red', 'Blue', 'Yellow', 'Green', 'Violet', 'Orange'];
  var data3 = LinearChartData(datasets: <ChartDataSets>[
    ChartDataSets(
        label: 'My First dataset',
        backgroundColor: 'rgba(220,220,220,0.5)',
        data: colors.map((d) => rnd.nextInt(100)).toList(),
        steppedLine: 'middle',
        fill: false
        ),
    ChartDataSets(
        label: 'My Second dataset',
        backgroundColor: 'rgba(151,187,205,0.7)',
        data: colors.map((d) => rnd.nextInt(100)).toList(),
        lineTension: 0,
        fill: false
        )])
        ;
  var config3 = ChartConfiguration(
      type: 'line',
      data: data3,
      options: ChartOptions(
	      animation: ChartAnimationOptions(duration: 1000, easing: 'easeOutSine'),
	      scales: ChartScales(type: 'linear', xAxes: [ChartXAxe(type: 'category',
                  labels: colors,
                  scaleLabel: ScaleTitleOptions(labelString: 'Colors', display: true, padding: 20)
                  )], 
            yAxes: [ChartYAxe(
                  ticks: LinearTickOptions(beginAtZero: true, max: 120, stepSize: 5), 
                  scaleLabel: ScaleTitleOptions(labelString: 'Value', display: true, padding: 20, lineHeight: 2.5))]),
	      tooltips: ChartTooltipOptions(enabled:true, titleFontColor: '#ff7f7b', bodyFontSize:24, mode:'index', axis: 'x', caretSize: 15, intersect: false),
	      responsive: true,
        legend: ChartLegendOptions(onLeave: (e, li) => print(li.text)),
        title: ChartTitleOptions(display: true, fontSize: 15, text: ['Stepped', 'and not stepped'], lineHeight: 1.5),
        ));

  
  var data4 = LinearChartData(labels:colors, datasets: <ChartDataSets>[
    ChartDataSets(
        label: 'Colors',
        backgroundColor:  colors.map((c) => c.toLowerCase()).toList(),
        borderColor: (context) => context.dataIndex % 2 == 0 ? 'grey' : 'black',
        borderAlign: 'inner',
        data: colors.map((d) => rnd.nextInt(100)).toList()
        )]);
  var config4 = ChartConfiguration(
      type: 'polarArea',
      data: data4,
      options: ChartOptions(
	      animation: ChartAnimationOptions(duration: 1000, easing: 'easeOutSine', 
        onComplete: (animationObject) => print(animationObject.animationObject == animationObject && animationObject.chart == animationObject.chartInstance && animationObject.duration == 1000)),
        scale: RadialLinearScale(
          gridLines: GridLineOptions(circular: true, borderDash: [4, 2]),
          angleLines: AngleLineOptions(display: true, borderDash: [4, 2]),
          pointLabels: PointLabelOptions(display: true)
        ),
	      responsive: true,
        ));


  Chart(querySelector('#canvas') as CanvasElement, config);

  Chart(querySelector('#canvas2') as CanvasElement, config2);

  Chart(querySelector('#canvas3') as CanvasElement, config3);

  Chart(querySelector('#canvas4') as CanvasElement, config4);
}

