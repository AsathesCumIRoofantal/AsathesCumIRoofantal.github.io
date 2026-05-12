import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'rewards_credits_controller.dart';

class RewardsCreditsView extends GetView<RewardsCreditsController> {
  const RewardsCreditsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('REWARDS & CREDITS', style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildBalanceHeader(context)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            sliver: SliverToBoxAdapter(
              child: Text(
                "RECENT TRANSACTIONS",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 2, color: Colors.grey.withOpacity(0.7)),
              ),
            ),
          ),
          Obx(() => SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final reward = controller.rewards[index];
                return _buildRewardCard(context, reward);
              },
              childCount: controller.rewards.length,
            ),
          )),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showIssueRewardSheet(context),
        label: const Text("CREATE REWARD STUFF"),
        icon: const Icon(Icons.stars),
        backgroundColor: Colors.amber[700],
      ),
    );
  }

  Widget _buildBalanceHeader(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.amber[800]!, Colors.amber[400]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.amber.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.account_balance_wallet_outlined, color: Colors.white, size: 40),
          const SizedBox(height: 16),
          const Text(
            "AVAILABLE BALANCE",
            style: TextStyle(color: Colors.white70, letterSpacing: 2, fontSize: 12, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Obx(() => Text(
            controller.rewards.fold(0, (sum, r) => sum + r.points).toString(),
            style: const TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold),
          )),
          const SizedBox(height: 8),
          const Text(
            "AIR CREDITS",
            style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardCard(BuildContext context, Reward reward) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.stars, color: Colors.amber[700], size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(reward.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(reward.reason, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                const SizedBox(height: 8),
                Text(
                  "${reward.category.toUpperCase()} • ${DateFormat('MMM dd, yyyy').format(reward.date)}",
                  style: TextStyle(color: Colors.grey[400], fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Text(
            "+${reward.points}",
            style: TextStyle(color: Colors.green[600], fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      ),
    );
  }

  void _showIssueRewardSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("ISSUE NEW REWARD", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2)),
              const SizedBox(height: 24),
              _buildField(controller.titleController, "Reward Title", Icons.emoji_events_outlined),
              const SizedBox(height: 16),
              _buildField(controller.pointsController, "Points (e.g. 100)", Icons.add_circle_outline, keyboardType: TextInputType.number),
              const SizedBox(height: 16),
              _buildField(controller.reasonController, "Reason/Description", Icons.notes, maxLines: 2),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.addManualReward(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber[700],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("CONFIRM CREDIT", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildField(TextEditingController ctrl, String label, IconData icon, {TextInputType? keyboardType, int maxLines = 1}) {
    return TextField(
      controller: ctrl,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 20, color: Colors.amber[700]),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.amber[700]!, width: 2),
        ),
      ),
    );
  }
}
