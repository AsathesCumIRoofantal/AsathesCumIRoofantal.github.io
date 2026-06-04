import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'products_services_controller.dart';

class ProductsServicesView extends GetView<ProductsServicesController> {
  final bool isEmbedded;
  const ProductsServicesView({super.key, this.isEmbedded = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tertiary = theme.colorScheme.tertiary;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [theme.scaffoldBackgroundColor, theme.colorScheme.surface],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            _buildSearchBar(context),
            Obx(() {
              final list = controller.filteredProducts;
              if (list.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.inventory_2_outlined,
                        size: 64,
                        color: theme.dividerColor.withValues(alpha: 0.1),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'No products matching your scan.',
                        style: TextStyle(color: Colors.white24),
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                shrinkWrap: isEmbedded,
                physics: isEmbedded
                    ? const NeverScrollableScrollPhysics()
                    : null,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return _buildProductCard(context, list[index]);
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: TextField(
        onChanged: (value) => controller.searchQuery.value = value,
        decoration: InputDecoration(
          hintText: 'Search by Title or #Tags...',
          prefixIcon: Icon(Icons.search, color: theme.dividerColor),
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

  Widget _buildProductCard(BuildContext context, ProductModel product) {
    final theme = Theme.of(context);
    final tertiary = theme.colorScheme.tertiary;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: theme.cardColor.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        product.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    Text(
                      DateFormat('MMM dd').format(product.timestamp),
                      style: TextStyle(fontSize: 10, color: theme.dividerColor),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: product.metaTags
                      .map(
                        (tag) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: tertiary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: tertiary.withValues(alpha: 0.2),
                            ),
                          ),
                          child: Text(
                            tag,
                            style: TextStyle(
                              color: tertiary,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
          if (product.identifiers.isNotEmpty) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              color: Colors.white.withValues(alpha: 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'RECOGNITION CODES:',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      color: Colors.white54,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 16,
                    runSpacing: 8,
                    children: product.identifiers.entries
                        .map(
                          (e) => Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.qr_code_2,
                                size: 14,
                                color: theme.colorScheme.primary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${e.key}: ',
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                e.value,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: theme.colorScheme.primary,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
          if (product.links.isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Text(
                'PRODUCT FEATURES:',
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: Colors.white54,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: product.links
                    .map(
                      (link) => InkWell(
                        onTap: () {}, // Simulated action
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.secondary.withValues(
                              alpha: 0.1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: theme.colorScheme.secondary.withValues(
                                alpha: 0.2,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.launch_rounded,
                                size: 14,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                link.title,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _showAddProductModal(BuildContext context) {
    final titleController = TextEditingController();
    final tagController = TextEditingController();
    final barcodeController = TextEditingController();
    final qrController = TextEditingController();
    final keyController = TextEditingController();
    final linkTitleController = TextEditingController();
    final linkUrlController = TextEditingController();

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
              'Establish Catalogue Entry',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: _inputDecoration(
                        'Product/Service Name',
                        Icons.inventory_rounded,
                        context,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'META DATA TAGS',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: tagController,
                            decoration: _inputDecoration(
                              'Add Recognition Tag (e.g. #New)',
                              Icons.tag_rounded,
                              context,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        IconButton.filled(
                          onPressed: () {
                            controller.addTempTag(tagController.text);
                            tagController.clear();
                          },
                          icon: const Icon(Icons.add),
                          style: IconButton.styleFrom(
                            backgroundColor: tertiary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Obx(
                      () => Wrap(
                        spacing: 8,
                        children: controller.tempTags
                            .map(
                              (tag) => Chip(
                                label: Text(tag),
                                onDeleted: () => controller.removeTempTag(tag),
                                backgroundColor: tertiary.withValues(
                                  alpha: 0.05,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'IDENTIFICATION CODES',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: barcodeController,
                      decoration: _inputDecoration(
                        'Barcode / Serial No.',
                        Icons.barcode_reader,
                        context,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: qrController,
                      decoration: _inputDecoration(
                        'QR Mapping URL',
                        Icons.qr_code,
                        context,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: keyController,
                      decoration: _inputDecoration(
                        'Internal Key / Asset ID',
                        Icons.key_rounded,
                        context,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'FEATURE LINKS',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: theme.cardColor.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          TextField(
                            controller: linkTitleController,
                            decoration: const InputDecoration(
                              labelText: 'Link Title (e.g. Feature Demo)',
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: linkUrlController,
                            decoration: const InputDecoration(
                              labelText: 'Target URL',
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              onPressed: () {
                                controller.addTempLink(
                                  linkTitleController.text,
                                  linkUrlController.text,
                                );
                                linkTitleController.clear();
                                linkUrlController.clear();
                              },
                              icon: const Icon(Icons.link_rounded),
                              label: const Text('ADD FEATURE LINK'),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: tertiary),
                                foregroundColor: tertiary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Obx(
                      () => Column(
                        children: controller.tempLinks
                            .asMap()
                            .entries
                            .map(
                              (e) => Card(
                                margin: const EdgeInsets.only(bottom: 8),
                                child: ListTile(
                                  dense: true,
                                  leading: const Icon(Icons.link, size: 18),
                                  title: Text(
                                    e.value.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    e.value.url,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      size: 18,
                                      color: Colors.redAccent,
                                    ),
                                    onPressed: () =>
                                        controller.removeTempLink(e.key),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
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
                onPressed: () => controller.addProduct(
                  title: titleController.text,
                  barcode: barcodeController.text,
                  qrCode: qrController.text,
                  key: keyController.text,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: tertiary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'ESTABLISH CATALOGUE',
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
