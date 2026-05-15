import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'medical_controller.dart';

class MedicalView extends GetView<MedicalController> {
  const MedicalView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Medical',
      subtitle:
          'Manage health appointments, medical reports, and consent-aware document storage in one secure place. '
          'All medical data is handled with strict privacy controls and role-based access.',
      icon: Icons.local_hospital,
      items: const [
        SampleContentItem(
          title: 'Appointments',
          subtitle:
              'Schedule, reschedule, and track medical appointments for individuals or groups. '
              'Automated reminders are sent to both the individual and the medical officer in advance.',
          icon: Icons.calendar_month,
        ),
        SampleContentItem(
          title: 'Medical Reports',
          subtitle:
              'Upload and store medical examination reports, fitness certificates, and specialist referrals. '
              'Reports are version-controlled so the most recent assessment is always clearly identified.',
          icon: Icons.description,
        ),
        SampleContentItem(
          title: 'Fitness Status',
          subtitle:
              'View the current fitness-for-duty status of each individual at a glance. '
              'Status flags — Fit, Restricted, or Unfit — are updated automatically when new reports are filed.',
          icon: Icons.health_and_safety,
        ),
        SampleContentItem(
          title: 'Consent Management',
          subtitle:
              'Record and manage informed consent for medical procedures, data sharing, and research participation. '
              'Consent records are timestamped and cannot be altered once submitted.',
          icon: Icons.verified_user,
        ),
        SampleContentItem(
          title: 'Vaccination Records',
          subtitle:
              'Maintain a complete immunisation history including vaccine type, batch number, and next due date. '
              'Expiry alerts notify individuals and administrators when boosters are required.',
          icon: Icons.vaccines,
        ),
        SampleContentItem(
          title: 'Referrals & Follow-Ups',
          subtitle:
              'Track specialist referrals from initial request through to outcome documentation. '
              'Follow-up tasks are automatically created when a referral is marked as completed.',
          icon: Icons.transfer_within_a_station,
        ),
        SampleContentItem(
          title: 'Privacy & Access Control',
          subtitle:
              'Configure who can view, edit, or export each individual\'s medical records. '
              'Access logs are maintained for every record interaction to support compliance audits.',
          icon: Icons.lock,
        ),
      ],
    );
  }
}
