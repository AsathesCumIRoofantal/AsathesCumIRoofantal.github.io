import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'interviews_controller.dart';

class InterviewsView extends GetView<InterviewsController> {
  final bool isEmbedded;
  const InterviewsView({super.key, this.isEmbedded = false});

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Interviews',
      subtitle:
          'Standardise your interview process with structured question guides, scoring rubrics, and debrief templates. '
          'Ensure every candidate receives a fair, consistent, and well-documented evaluation.',
      icon: Icons.record_voice_over,
      items: const [
        SampleContentItem(
          title: 'Question Bank',
          subtitle:
              'Access a library of competency-based interview questions organised by role and skill level. '
              'Add custom questions and tag them to specific evaluation criteria for easy retrieval.',
          icon: Icons.quiz,
        ),
        SampleContentItem(
          title: 'Interview Guide Builder',
          subtitle:
              'Assemble a tailored interview guide by selecting questions from the bank and setting time allocations. '
              'Share the guide with all panel members before the interview to ensure alignment.',
          icon: Icons.edit_document,
        ),
        SampleContentItem(
          title: 'Scoring Rubric',
          subtitle:
              'Define clear scoring criteria for each question so all panellists evaluate on the same scale. '
              'Rubrics reduce unconscious bias and make comparative scoring straightforward.',
          icon: Icons.rule,
        ),
        SampleContentItem(
          title: 'Live Interview Notes',
          subtitle:
              'Capture candidate responses and panel observations in real time during the interview. '
              'Notes are linked to specific questions and stored securely against the candidate record.',
          icon: Icons.note_alt,
        ),
        SampleContentItem(
          title: 'Panel Debrief',
          subtitle:
              'Facilitate a structured post-interview debrief where each panellist submits independent scores. '
              'The system aggregates scores and flags significant disagreements for discussion.',
          icon: Icons.groups,
        ),
        SampleContentItem(
          title: 'Candidate Records',
          subtitle:
              'Maintain a complete record of each candidate\'s interview history, scores, and outcomes. '
              'Records are searchable and exportable for compliance and reporting purposes.',
          icon: Icons.person_search,
        ),
        SampleContentItem(
          title: 'Outcome & Feedback',
          subtitle:
              'Record the final hiring decision and generate a structured feedback letter for the candidate. '
              'Feedback templates ensure communication is professional, specific, and legally sound.',
          icon: Icons.feedback,
        ),
      ],
    );
  }
}



