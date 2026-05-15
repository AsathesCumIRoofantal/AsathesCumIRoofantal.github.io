import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'forgivness_controller.dart';

class ForgivnessView extends GetView<ForgivnessController> {
  const ForgivnessView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Forgiveness',
      subtitle:
          'Forgiveness in AIR is a practice of release — letting go of the grip a past harm has on your present decisions. It does not require pretending the harm never happened; it requires choosing not to let it define what comes next.',
      icon: Icons.healing_outlined,
      items: const [
        SampleContentItem(
          title: 'What Forgiveness Is Not',
          subtitle:
              'Forgiveness is not condoning, excusing, or forgetting. It is not reconciliation — you can forgive someone and still choose not to have them in your life. Clarify your definition so you\'re not waiting for the wrong thing.',
          icon: Icons.info_outline,
        ),
        SampleContentItem(
          title: 'The Harm Inventory',
          subtitle:
              'Before you can release something, you have to name it clearly. Write down what happened, how it affected you, and what you\'re still carrying. Specificity is the first step toward genuine release.',
          icon: Icons.edit_note_outlined,
        ),
        SampleContentItem(
          title: 'Forgiveness Timeline',
          subtitle:
              'Forgiveness is rarely a single moment — it\'s a process that unfolds over time. Log where you are in the process for each significant harm and track your movement without forcing a timeline.',
          icon: Icons.timeline_outlined,
        ),
        SampleContentItem(
          title: 'Self-Forgiveness',
          subtitle:
              'The hardest forgiveness is often the kind you owe yourself. Log the mistakes you\'re still punishing yourself for, acknowledge what you\'ve learned, and practice releasing the self-judgment that no longer serves you.',
          icon: Icons.self_improvement_outlined,
        ),
        SampleContentItem(
          title: 'Forgiveness vs. Trust',
          subtitle:
              'Forgiving someone does not automatically restore trust. Trust is rebuilt through consistent behavior over time. Keep these two processes separate — you can forgive fully while rebuilding trust slowly.',
          icon: Icons.lock_open_outlined,
        ),
        SampleContentItem(
          title: 'Releasing Resentment',
          subtitle:
              'Resentment is the cost of unforgiveness — it occupies mental space that could be used for something better. Log the resentments you\'re carrying and the cost they\'re extracting from your daily energy and focus.',
          icon: Icons.free_cancellation_outlined,
        ),
        SampleContentItem(
          title: 'Repair & Reconciliation',
          subtitle:
              'When both parties want to rebuild, forgiveness can open the door to reconciliation. Log the steps you\'ve taken toward repair — the conversations, the agreements, the new behaviors — and track whether trust is growing.',
          icon: Icons.handshake_outlined,
        ),
      ],
    );
  }
}
