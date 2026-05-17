import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'statistics_controller.dart';

class StatisticsView extends GetView<StatisticsController> {
  final bool isEmbedded;
  const StatisticsView({super.key, this.isEmbedded = false});

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Statistics',
      subtitle:
          'Surface the numbers that matter — distributions, trends, and honest baselines — without drowning in noise. '
          'AIR turns raw data into clear statistical narratives that support better decisions.',
      icon: Icons.query_stats,
      items: const [
        SampleContentItem(
          title: 'Baseline Metrics',
          subtitle:
              'Establish honest baselines for the key quantities you track — what is normal, what is the range, and what is an outlier. '
              'Without a baseline, every number is meaningless and every change looks significant.',
          icon: Icons.horizontal_rule,
        ),
        SampleContentItem(
          title: 'Distribution Analysis',
          subtitle:
              'Examine how values are spread across a dataset — mean, median, variance, skew, and tail behaviour. '
              'Understanding distributions prevents the common mistake of treating averages as if they represent everyone.',
          icon: Icons.bar_chart,
        ),
        SampleContentItem(
          title: 'Trend Detection',
          subtitle:
              'Identify statistically significant trends in time-series data, separating real signals from random noise. '
              'Trend detection tells you whether things are genuinely improving, declining, or just fluctuating.',
          icon: Icons.trending_up,
        ),
        SampleContentItem(
          title: 'Correlation Explorer',
          subtitle:
              'Test relationships between variables to find genuine correlations and flag spurious ones. '
              'Correlation analysis guides hypothesis formation but always reminds you that correlation is not causation.',
          icon: Icons.scatter_plot_outlined,
        ),
        SampleContentItem(
          title: 'Confidence Intervals',
          subtitle:
              'Display estimates with their uncertainty ranges so decision-makers understand how much to trust each number. '
              'Confidence intervals are the honest alternative to false precision in reported statistics.',
          icon: Icons.error_outline,
        ),
        SampleContentItem(
          title: 'Anomaly Alerts',
          subtitle:
              'Flag data points that fall outside expected ranges and trigger investigation before they become crises. '
              'Early anomaly detection is far cheaper than discovering problems after they have compounded.',
          icon: Icons.notifications_active_outlined,
        ),
        SampleContentItem(
          title: 'Statistical Reports',
          subtitle:
              'Generate plain-language summaries of statistical findings for audiences who do not read raw numbers. '
              'Good statistical communication is as important as good statistical analysis.',
          icon: Icons.assessment_outlined,
        ),
      ],
    );
  }
}



