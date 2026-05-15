import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ease_tools_controller.dart';

class EaseToolsView extends GetView<EaseToolsController> {
  const EaseToolsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ease Tools',
          style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              theme.scaffoldBackgroundColor,
              theme.colorScheme.surface,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              Expanded(
                child: Obx(() {
                  return GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: controller.tools.length,
                    itemBuilder: (context, index) {
                      return _buildToolCard(context, controller.tools[index]);
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PRODUCTIVITY SUITE',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              color: theme.colorScheme.tertiary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Simplify your workflow with integrated utility tools.',
            style: TextStyle(fontSize: 14, color: Colors.white54),
          ),
        ],
      ),
    );
  }

  Widget _buildToolCard(BuildContext context, EaseTool tool) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: tool.color.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: tool.color.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: tool.color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(tool.icon, color: tool.color, size: 24),
          ),
          const Spacer(),
          Text(
            tool.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            tool.description,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.white38,
              height: 1.4,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Icon(
            Icons.arrow_forward_rounded,
            size: 16,
            color: tool.color.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}
