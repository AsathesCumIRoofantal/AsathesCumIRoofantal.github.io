import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'limits_0_1_controller.dart';

class Limits01View extends GetView<Limits01Controller> {
  const Limits01View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SampleContentPage(
      title: 'Limits 0–1',
      subtitle:
          'Explore the domains where binary and threshold thinking apply — decisions that are either fully on or fully off, with no productive middle ground. '
          'Knowing where zero-or-one logic belongs prevents the false compromise that weakens commitments and blurs accountability.',
      icon: Icons.toggle_on_rounded,
      items: [
        SampleContentItem(
          title: 'Binary Decision Identifier',
          subtitle:
              'Determine whether a given decision is genuinely binary — where a partial answer is worse than either extreme — or whether it only feels binary due to framing. '
              'Many decisions that appear binary are actually continuous; the identifier helps you tell the difference before you commit.',
          icon: Icons.device_hub_rounded,
        ),
        SampleContentItem(
          title: 'Hard Limit Registry',
          subtitle:
              'Document your personal and organisational hard limits — the zero-tolerance lines that will not be crossed regardless of pressure or incentive. '
              'Hard limits are most useful when they are declared in advance; a limit decided under pressure is rarely a limit at all.',
          icon: Icons.block_rounded,
        ),
        SampleContentItem(
          title: 'Threshold Calibration Tool',
          subtitle:
              'Set precise thresholds for metrics that trigger automatic responses — when a score drops below X, action Y is taken without deliberation. '
              'Pre-set thresholds remove the cognitive load and emotional interference that degrade decision quality in high-stakes moments.',
          icon: Icons.tune_rounded,
        ),
        SampleContentItem(
          title: 'Commitment Integrity Check',
          subtitle:
              'Audit your existing commitments to identify any that have drifted from binary to conditional — and decide whether to restore the hard line or reclassify the commitment. '
              'Commitment drift is one of the most common ways that integrity erodes; the check makes it visible before it becomes a pattern.',
          icon: Icons.fact_check_rounded,
        ),
        SampleContentItem(
          title: 'Zero-Tolerance Policy Builder',
          subtitle:
              'Draft clear, enforceable zero-tolerance policies for your team or community — specifying the behaviour, the threshold, and the consequence with no ambiguity. '
              'Ambiguous policies are not policies; they are suggestions, and they are treated as such by everyone who encounters them.',
          icon: Icons.policy_rounded,
        ),
        SampleContentItem(
          title: 'Binary Thinking Pitfalls',
          subtitle:
              'Learn the common cognitive traps that cause people to apply binary thinking where nuance is needed — false dilemmas, all-or-nothing framing, and catastrophising. '
              'Understanding the pitfalls makes you a more precise thinker who applies zero-or-one logic only where it genuinely belongs.',
          icon: Icons.warning_rounded,
        ),
        SampleContentItem(
          title: 'On/Off State Monitor',
          subtitle:
              'Track the current state of your active binary commitments — which are fully on, which have been switched off, and which are at risk of drifting. '
              'The monitor makes your binary commitments visible and accountable, turning abstract principles into observable states.',
          icon: Icons.monitor_heart_rounded,
        ),
      ],
    );
  }
}
