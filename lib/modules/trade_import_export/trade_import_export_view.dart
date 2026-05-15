import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'trade_import_export_controller.dart';

class TradeImportExportView extends GetView<TradeImportExportController> {
  const TradeImportExportView({super.key});

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Trade, Import & Export',
      subtitle:
          'Manage trade lanes end-to-end — imports, exports, compliance requirements, and counterparty records. '
          'AIR keeps your cross-border activity organised, auditable, and regulation-ready.',
      icon: Icons.local_shipping_outlined,
      items: const [
        SampleContentItem(
          title: 'Trade Lane Registry',
          subtitle:
              'Document every active import and export corridor with origin, destination, commodity codes, and volume. '
              'A complete lane registry makes it easy to spot concentration risk and optimise logistics spend.',
          icon: Icons.route_outlined,
        ),
        SampleContentItem(
          title: 'Counterparty Profiles',
          subtitle:
              'Maintain due-diligence records for every supplier, buyer, freight forwarder, and customs broker. '
              'Verified counterparty profiles reduce the risk of sanctions violations and supply-chain fraud.',
          icon: Icons.business_outlined,
        ),
        SampleContentItem(
          title: 'Compliance Checklist',
          subtitle:
              'Track export control classifications, import tariff codes, and required licences for each shipment type. '
              'A structured checklist prevents costly delays at customs and protects against regulatory penalties.',
          icon: Icons.playlist_add_check_circle_outlined,
        ),
        SampleContentItem(
          title: 'Shipment Tracker',
          subtitle:
              'Log each shipment with its documents, carrier, expected and actual delivery dates, and any exceptions. '
              'Real-time tracking data lets you intervene early when a shipment is at risk of delay or seizure.',
          icon: Icons.inventory_2_outlined,
        ),
        SampleContentItem(
          title: 'Tariff & Duty Calculator',
          subtitle:
              'Estimate landed costs by applying current tariff rates, duties, and fees to planned shipments. '
              'Accurate cost modelling prevents margin surprises and supports better sourcing decisions.',
          icon: Icons.calculate_outlined,
        ),
        SampleContentItem(
          title: 'Sanctions Screening',
          subtitle:
              'Screen counterparties and destinations against current sanctions lists before committing to a trade. '
              'Automated screening flags high-risk parties early and creates an audit trail of due diligence.',
          icon: Icons.security_outlined,
        ),
        SampleContentItem(
          title: 'Trade Analytics',
          subtitle:
              'Analyse trade volumes, lead times, cost trends, and compliance incident rates across all lanes. '
              'Data-driven insights reveal which lanes are performing well and where operational improvements are needed.',
          icon: Icons.bar_chart_outlined,
        ),
      ],
    );
  }
}
