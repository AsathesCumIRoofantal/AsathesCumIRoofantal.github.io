import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'your_business_controller.dart';

class YourBusinessView extends GetView<YourBusinessController> {
  const YourBusinessView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SampleContentPage(
      title: 'Your Business',
      subtitle:
          'Declare your commercial or side-project footprint to AIR so the platform can surface matching services, relevant partners, and opportunities aligned with what you are building. '
          'Your business profile is the lens through which AIR understands your entrepreneurial identity — the more clearly you define it, the more precisely AIR can serve it.',
      icon: Icons.business_center_rounded,
      items: [
        SampleContentItem(
          title: 'Business Profile',
          subtitle:
              'Define your business — its name, sector, stage, core offering, and target market — in a structured profile that AIR uses to match you with relevant opportunities and partners. '
              'A clear profile is not just for others to read; it forces you to articulate what you are actually building, which is clarifying in itself.',
          icon: Icons.storefront_rounded,
        ),
        SampleContentItem(
          title: 'Service & Product Catalogue',
          subtitle:
              'List the services or products you offer — with descriptions, pricing models, and availability — so AIR can surface you to members who need exactly what you provide. '
              'A well-maintained catalogue turns your profile into an active business development tool rather than a static biography.',
          icon: Icons.inventory_rounded,
        ),
        SampleContentItem(
          title: 'Partnership Interests',
          subtitle:
              'Declare the types of partnerships you are open to — distribution, co-development, investment, advisory, or referral — so AIR can match you with the right kind of interest. '
              'Being specific about what you want attracts better-fit partners and filters out the noise of misaligned approaches.',
          icon: Icons.handshake_rounded,
        ),
        SampleContentItem(
          title: 'Business Milestones',
          subtitle:
              'Log your business milestones — first customer, first revenue, product launch, team hire, funding round — to build a credible track record that others can see and trust. '
              'Milestones are evidence of momentum; they signal to potential partners and customers that you are building something real.',
          icon: Icons.flag_rounded,
        ),
        SampleContentItem(
          title: 'Market Intelligence',
          subtitle:
              'Access AIR-curated market intelligence relevant to your sector — trends, competitor activity, regulatory changes, and emerging opportunities. '
              'Intelligence is only useful when it is timely and specific; AIR filters the noise to surface what actually matters for your business.',
          icon: Icons.insights_rounded,
        ),
        SampleContentItem(
          title: 'Business Compliance',
          subtitle:
              'Declare the regulatory and compliance frameworks your business operates under — licences held, standards met, and jurisdictions covered — so AIR can match you with partners who require that level of assurance. '
              'Compliance declarations build trust faster than any pitch; they show that you operate with integrity and understand your obligations.',
          icon: Icons.verified_rounded,
        ),
      ],
    );
  }
}
