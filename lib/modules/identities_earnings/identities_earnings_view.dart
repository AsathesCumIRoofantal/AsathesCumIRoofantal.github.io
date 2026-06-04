import 'package:air_app/widgets/air_home_context_strip.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'identities_earnings_controller.dart';

class IdentitiesEarningsView extends GetView<IdentitiesEarningsController> {
  final bool isEmbedded;
  const IdentitiesEarningsView({super.key, this.isEmbedded = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tertiary = theme.colorScheme.tertiary;

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                theme.scaffoldBackgroundColor,
                theme.colorScheme.surface,
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                _buildSummaryHeader(context),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: AirHomeContextStrip(
                    compact: true,
                    extraLine:
                        'What you log here should agree with the IDENTITY tab and the ENTITIES / UNIONS you already catalogue—those tabs stay on the home screen underneath this route.',
                  ),
                ),
                _buildSearchBar(context),
                Obx(() {
                  final list = controller.filteredEarnings;
                  if (list.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off_rounded,
                            size: 64,
                            color: tertiary.withValues(alpha: 0.3),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No accomplishments match your search.',
                            style: TextStyle(color: theme.dividerColor),
                          ),
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: isEmbedded,
                    physics: isEmbedded
                        ? const NeverScrollableScrollPhysics()
                        : null,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return _buildEarningCard(context, list[index]);
                    },
                  );
                }),
              ],
            ),
          ),
        ),

        Positioned(
          right: 20,
          top: -20,
          child: FloatingActionButton.extended(
            onPressed: () => _showAddEarningModal(context),
            label: const Text(
              'Log Identity Job',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white54,
              ),
            ),
            icon: const Icon(Icons.add_task_rounded, color: Colors.white54),
            backgroundColor: tertiary,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryHeader(BuildContext context) {
    final theme = Theme.of(context);
    final tertiary = theme.colorScheme.tertiary;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: tertiary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: tertiary.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TOTAL ACCUMULATED VALUE',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: tertiary,
                ),
              ),
              const SizedBox(height: 8),
              Obx(
                () => Text(
                  '${controller.totalCredits.toInt()} AIR-V',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Icon(Icons.account_balance_wallet_rounded, color: tertiary, size: 40),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        onChanged: (value) => controller.searchQuery.value = value,
        decoration: InputDecoration(
          hintText: 'Search by Title or Job Details...',
          prefixIcon: Icon(
            Icons.search,
            color: theme.colorScheme.tertiary.withValues(alpha: 0.5),
          ),
          filled: true,
          fillColor: theme.cardColor.withValues(alpha: 0.3),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
        ),
      ),
    );
  }

  Widget _buildEarningCard(BuildContext context, IdentityEarningModel item) {
    final theme = Theme.of(context);
    final tertiary = theme.colorScheme.tertiary;
    final isEntity = item.type == IdentityType.entity;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: theme.cardColor.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: tertiary.withValues(alpha: 0.1)),
      ),
      child: ExpansionTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isEntity
                ? theme.colorScheme.primary.withValues(alpha: 0.1)
                : theme.colorScheme.secondary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isEntity ? Icons.category_rounded : Icons.hub_rounded,
            color: isEntity
                ? theme.colorScheme.primary
                : theme.colorScheme.secondary,
            size: 20,
          ),
        ),
        title: Text(
          item.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.earnings,
              style: TextStyle(
                color: tertiary,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Text(
              DateFormat('MMM dd, yyyy - HH:mm').format(item.dateTime),
              style: TextStyle(fontSize: 10, color: theme.dividerColor),
            ),
          ],
        ),
        childrenPadding: const EdgeInsets.all(20),
        children: [
          const Divider(),
          const SizedBox(height: 8),
          const Text(
            'JOB DETAIL RECORD:',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            item.jobDetail,
            style: TextStyle(
              color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.8),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  void _showAddEarningModal(BuildContext context) {
    final titleController = TextEditingController();
    final earningsController = TextEditingController();
    final jobDetailController = TextEditingController();
    final type = IdentityType.entity.obs;
    final theme = Theme.of(context);
    final tertiary = theme.colorScheme.tertiary;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          left: 24,
          right: 24,
          top: 24,
        ),
        child: Column(
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.dividerColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Log Identity Accomplishment',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: _inputDecoration(
                        'Identity Title',
                        Icons.person_pin_rounded,
                        context,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: earningsController,
                      decoration: _inputDecoration(
                        'Earnings / Accomplishment (e.g. 500 Credits)',
                        Icons.military_tech_rounded,
                        context,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildTypeToggle(
                            'ENTITY',
                            IdentityType.entity,
                            type.value,
                            (v) => type.value = v,
                            context,
                          ),
                          const SizedBox(width: 16),
                          _buildTypeToggle(
                            'UNION',
                            IdentityType.union,
                            type.value,
                            (v) => type.value = v,
                            context,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: jobDetailController,
                      maxLines: 6,
                      decoration: _inputDecoration(
                        'Job Detail Mapping',
                        Icons.description_rounded,
                        context,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () => controller.addEarning(
                  title: titleController.text,
                  earnings: earningsController.text,
                  type: type.value,
                  jobDetail: jobDetailController.text,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: tertiary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'MINT IDENTITY VALUE',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white54,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeToggle(
    String label,
    IdentityType target,
    IdentityType current,
    Function(IdentityType) onSelect,
    BuildContext context,
  ) {
    final isSelected = target == current;
    final theme = Theme.of(context);
    final color = target == IdentityType.entity
        ? theme.colorScheme.primary
        : theme.colorScheme.secondary;

    return GestureDetector(
      onTap: () => onSelect(target),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? color.withValues(alpha: 0.2)
              : theme.cardColor.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? color
                : theme.dividerColor.withValues(alpha: 0.1),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? color : theme.dividerColor,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(
    String label,
    IconData icon,
    BuildContext context,
  ) {
    final theme = Theme.of(context);
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(
        icon,
        color: theme.colorScheme.tertiary.withValues(alpha: 0.7),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: theme.colorScheme.tertiary, width: 2),
      ),
      filled: true,
      fillColor: theme.cardColor.withValues(alpha: 0.5),
    );
  }
}
