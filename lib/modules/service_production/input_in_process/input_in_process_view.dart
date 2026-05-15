import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'input_in_process_controller.dart';

class InputInProcessView extends GetView<InputInProcessController> {
  const InputInProcessView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SampleContentPage(
      title: 'Input In Process',
      subtitle:
          'Track and validate everything that enters the AIR pipeline before any transformation begins. '
          'Capturing inputs accurately at the source prevents errors from compounding downstream.',
      icon: Icons.input_rounded,
      items: [
        SampleContentItem(
          title: 'Input Source Registry',
          subtitle:
              'Catalogue every channel — manual entry, API feed, file upload, or sensor stream — that delivers data into AIR. '
              'Each source is tagged with owner, format, and expected frequency so gaps are spotted immediately.',
          icon: Icons.device_hub_rounded,
        ),
        SampleContentItem(
          title: 'Pre-Processing Validation',
          subtitle:
              'Run schema checks, range guards, and duplicate filters on raw inputs before they advance to the process stage. '
              'Rejected records are quarantined with a clear reason code so they can be corrected and resubmitted.',
          icon: Icons.rule_rounded,
        ),
        SampleContentItem(
          title: 'Ingestion Queue Monitor',
          subtitle:
              'View the live queue of items waiting to enter the pipeline, including volume, lag, and priority tier. '
              'Alerts fire automatically when queue depth exceeds the configured threshold for any source.',
          icon: Icons.queue_rounded,
        ),
        SampleContentItem(
          title: 'Input Classification',
          subtitle:
              'Assign each incoming item a category, urgency level, and routing tag as it arrives. '
              'Classification rules can be automated via keyword matching or manually overridden by authorised operators.',
          icon: Icons.label_important_outline_rounded,
        ),
        SampleContentItem(
          title: 'Load & Throughput Metrics',
          subtitle:
              'Monitor real-time ingestion rates, peak-load windows, and error percentages across all active streams. '
              'Historical trend charts help capacity planners anticipate surges before they cause bottlenecks.',
          icon: Icons.speed_rounded,
        ),
        SampleContentItem(
          title: 'Intake Audit Log',
          subtitle:
              'Every input event is stamped with timestamp, source identity, and operator action for full traceability. '
              'The audit log is immutable and exportable for compliance reviews or incident investigations.',
          icon: Icons.history_edu_rounded,
        ),
        SampleContentItem(
          title: 'Initialise New Input Stream',
          subtitle:
              'Register a brand-new data source by defining its schema, delivery method, and SLA expectations. '
              'Once registered, the stream is live-monitored and included in all downstream pipeline reports.',
          icon: Icons.add_to_photos_outlined,
        ),
      ],
    );
  }
}
