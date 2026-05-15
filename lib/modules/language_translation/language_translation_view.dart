import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'language_translation_controller.dart';

class LanguageTranslationView extends GetView<LanguageTranslationController> {
  const LanguageTranslationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Language & Translation',
      subtitle:
          'Manage multilingual work with glossaries, trusted translators, and cultural nuance notes in one place. '
          'AIR ensures that meaning — not just words — crosses language boundaries accurately.',
      icon: Icons.translate,
      items: const [
        SampleContentItem(
          title: 'Project Glossary',
          subtitle:
              'Build a domain-specific glossary of approved terms, acronyms, and proper nouns for each language pair. '
              'A shared glossary eliminates inconsistent translations and speeds up every future document.',
          icon: Icons.menu_book_outlined,
        ),
        SampleContentItem(
          title: 'Translator Registry',
          subtitle:
              'Maintain a vetted list of human translators and AI tools, each rated by language pair, domain, and turnaround time. '
              'Knowing who to call for legal Arabic or technical Mandarin saves critical hours under deadline.',
          icon: Icons.record_voice_over_outlined,
        ),
        SampleContentItem(
          title: 'Cultural Nuance Notes',
          subtitle:
              'Attach cultural context flags to translated content — idioms that do not transfer, taboo topics, and tone adjustments. '
              'Nuance notes prevent embarrassing or offensive mistranslations in sensitive communications.',
          icon: Icons.lightbulb_outline,
        ),
        SampleContentItem(
          title: 'Translation Memory',
          subtitle:
              'Store previously approved translations so identical or similar segments are reused automatically. '
              'Translation memory cuts costs, ensures consistency, and dramatically reduces review time.',
          icon: Icons.memory_outlined,
        ),
        SampleContentItem(
          title: 'Document Pipeline',
          subtitle:
              'Track each document through its translation lifecycle — submitted, in progress, reviewed, and approved. '
              'A clear pipeline prevents bottlenecks and makes it easy to audit which version is authoritative.',
          icon: Icons.description_outlined,
        ),
        SampleContentItem(
          title: 'Quality Review',
          subtitle:
              'Run back-translation checks and readability scores to catch errors before content goes live. '
              'Structured quality gates are especially important for legal, medical, and diplomatic materials.',
          icon: Icons.fact_check_outlined,
        ),
        SampleContentItem(
          title: 'Language Coverage Map',
          subtitle:
              'See at a glance which languages your content is available in and where gaps exist. '
              'The coverage map helps prioritise translation investment based on audience size and strategic importance.',
          icon: Icons.language,
        ),
      ],
    );
  }
}
