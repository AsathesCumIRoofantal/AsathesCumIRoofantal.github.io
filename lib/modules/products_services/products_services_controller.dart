import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeatureLinkModel {
  final String title;
  final String url;

  FeatureLinkModel({required this.title, required this.url});
}

class ProductModel {
  final String id;
  final String title;
  final List<String> metaTags;
  final Map<String, String> identifiers; // e.g. {'Barcode': '12345', 'QR': 'ABC-XYZ'}
  final List<FeatureLinkModel> links;
  final DateTime timestamp;

  ProductModel({
    required this.id,
    required this.title,
    required this.metaTags,
    required this.identifiers,
    required this.links,
    required this.timestamp,
  });
}

class ProductsServicesController extends GetxController {
  var productsList = <ProductModel>[].obs;
  var searchQuery = ''.obs;

  // Form State
  var tempTags = <String>[].obs;
  var tempLinks = <FeatureLinkModel>[].obs;

  List<ProductModel> get filteredProducts {
    if (searchQuery.value.isEmpty) {
      return productsList;
    }
    final query = searchQuery.value.toLowerCase();
    return productsList.where((p) {
      return p.title.toLowerCase().contains(query) ||
             p.metaTags.any((t) => t.toLowerCase().contains(query));
    }).toList();
  }

  @override
  void onInit() {
    super.onInit();
    _loadSamples();
  }

  void _loadSamples() {
    productsList.addAll([
      ProductModel(
        id: '1',
        title: 'AIR Core Atlas',
        metaTags: ['#AI', '#Core', '#Transparency'],
        identifiers: {'Barcode': 'AIR-001-ALPHA', 'QR': 'HTTPS://AIR.ORG/ATLAS-001'},
        links: [
          FeatureLinkModel(title: 'View Specs', url: 'https://docs.air.org/specs'),
          FeatureLinkModel(title: 'Live Demo', url: 'https://demo.air.org/atlas'),
        ],
        timestamp: DateTime.now().subtract(const Duration(days: 10)),
      ),
      ProductModel(
        id: '2',
        title: 'Sync Mesh Service',
        metaTags: ['#Networking', '#Sync', '#Decentralized'],
        identifiers: {'InternalKey': 'MESH-X72', 'AssetID': '9928-112-X'},
        links: [
          FeatureLinkModel(title: 'Node Setup', url: 'https://air.org/mesh/setup'),
        ],
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
      ),
    ]);
  }

  void addTempTag(String tag) {
    if (tag.isNotEmpty && !tempTags.contains(tag)) {
      tempTags.add(tag.startsWith('#') ? tag : '#$tag');
    }
  }

  void removeTempTag(String tag) => tempTags.remove(tag);

  void addTempLink(String title, String url) {
    if (title.isNotEmpty && url.isNotEmpty) {
      tempLinks.add(FeatureLinkModel(title: title, url: url));
    }
  }

  void removeTempLink(int index) => tempLinks.removeAt(index);

  void addProduct({
    required String title,
    required String barcode,
    required String qrCode,
    required String key,
  }) {
    if (title.isEmpty) {
      Get.snackbar('Error', 'Product Title is required.');
      return;
    }

    final identifiers = <String, String>{};
    if (barcode.isNotEmpty) identifiers['Barcode'] = barcode;
    if (qrCode.isNotEmpty) identifiers['QR'] = qrCode;
    if (key.isNotEmpty) identifiers['Key'] = key;

    final newProduct = ProductModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      metaTags: List<String>.from(tempTags),
      identifiers: identifiers,
      links: List<FeatureLinkModel>.from(tempLinks),
      timestamp: DateTime.now(),
    );

    productsList.insert(0, newProduct);
    
    // Reset form
    tempTags.clear();
    tempLinks.clear();
    
    Get.back(); // Close modal
    
    Get.snackbar(
      'Catalogued',
      'Product successfully established in the AIR ecosystem.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withOpacity(0.1),
      colorText: Colors.green,
    );
  }
}
