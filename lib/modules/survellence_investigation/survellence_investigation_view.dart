import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'survellence_investigation_controller.dart';

class SurvellenceInvestigationView
    extends GetView<SurvellenceInvestigationController> {
  const SurvellenceInvestigationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Surveillance & Investigation',
      subtitle:
          'Conduct proportionate investigations with structured evidence chains, clear custody logs, and oversight controls. '
          'AIR ensures every inquiry is defensible, auditable, and respectful of due process.',
      icon: Icons.manage_search,
      items: const [
        SampleContentItem(
          title: 'Case Registry',
          subtitle:
              'Open and track investigation cases with unique identifiers, assigned investigators, and current status. '
              'A centralised registry prevents duplicate investigations and makes cross-case pattern analysis possible.',
          icon: Icons.folder_special_outlined,
        ),
        SampleContentItem(
          title: 'Evidence Chain',
          subtitle:
              'Log every piece of evidence with its source, collection method, timestamp, and chain-of-custody record. '
              'An unbroken evidence chain is essential for legal admissibility and internal credibility.',
          icon: Icons.link,
        ),
        SampleContentItem(
          title: 'Surveillance Scope',
          subtitle:
              'Define the authorised scope of each surveillance activity — who, what, where, and for how long. '
              'Explicit scope boundaries prevent mission creep and protect the rights of individuals under observation.',
          icon: Icons.policy_outlined,
        ),
        SampleContentItem(
          title: 'Witness & Source Log',
          subtitle:
              'Record witness statements, informant tips, and source reliability ratings with appropriate confidentiality controls. '
              'Structured source management reduces the risk of acting on unverified or biased information.',
          icon: Icons.record_voice_over_outlined,
        ),
        SampleContentItem(
          title: 'Oversight & Authorisation',
          subtitle:
              'Require sign-off from designated authorities before escalating surveillance intensity or accessing sensitive data. '
              'Layered authorisation keeps investigations proportionate and shields the organisation from legal exposure.',
          icon: Icons.verified_user_outlined,
        ),
        SampleContentItem(
          title: 'Findings & Recommendations',
          subtitle:
              'Document investigation conclusions, supporting evidence, and recommended actions in a structured report. '
              'Clear findings separate facts from inferences and give decision-makers what they need to act responsibly.',
          icon: Icons.plagiarism_outlined,
        ),
        SampleContentItem(
          title: 'Case Closure & Review',
          subtitle:
              'Close cases with a formal review that assesses whether the investigation was proportionate and effective. '
              'Post-case reviews improve future investigations and demonstrate accountability to oversight bodies.',
          icon: Icons.task_alt,
        ),
      ],
    );
  }
}
