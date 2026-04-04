import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:drift/drift.dart' hide Column;
import '../../../shared/theme/app_colors.dart';
import '../../../shared/widgets/bilingual_text.dart';
import '../../../shared/widgets/shimmer_loader.dart';
import '../../../core/storage/app_database.dart';
import '../data/food_repository.dart';
import '../data/food_api_service.dart';
import '../data/vision_service.dart';

class FoodSearchScreen extends ConsumerStatefulWidget {
  final String? mealType;
  const FoodSearchScreen({super.key, this.mealType});

  @override
  ConsumerState<FoodSearchScreen> createState() => _FoodSearchScreenState();
}

class _FoodSearchScreenState extends ConsumerState<FoodSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<FoodItem> _results = [];
  bool _isLoading = false;

  Future<void> _scanBarcode() async {
    final barcode = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    
    if (barcode == '-1') return;
    
    setState(() => _isLoading = true);
    final api = ref.read(foodApiServiceProvider);
    final item = await api.fetchByBarcode(barcode);
    setState(() => _isLoading = false);
    
    if (item != null && mounted) {
      context.push('/food/detail', extra: {'item': item, 'mealType': widget.mealType});
    } else {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Barcode not found in database.")));
    }
  }

  Future<void> _scanLabel() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);
    if (image == null) return;
    
    setState(() => _isLoading = true);
    final vision = ref.read(visionServiceProvider);
    final nutrition = await vision.parseNutritionLabel(image.path);
    setState(() => _isLoading = false);
    
    if (nutrition.isNotEmpty && mounted) {
       // Create a temp item from OCR
       final item = FoodItem(
         id: 'ocr_${DateTime.now().millisecondsSinceEpoch}',
         name: "Scanned Label item",
         caloriesPer100g: nutrition['calories'] ?? 0,
         proteinPer100g: nutrition['protein'] ?? 0,
         carbsPer100g: nutrition['carbs'] ?? 0,
         fatPer100g: nutrition['fat'] ?? 0,
         ironPer100g: nutrition['iron'],
         calciumPer100g: nutrition['calcium'],
         isIndian: true,
         source: 'Label OCR',
       );
       context.push('/food/detail', extra: {'item': item, 'mealType': widget.mealType});
    }
  }

  void _onSearch(String query) async {
    if (query.isEmpty) {
      setState(() => _results = []);
      return;
    }
    setState(() => _isLoading = true);
    final repo = ref.read(foodRepositoryProvider);
    final results = await repo.searchFood(query);
    setState(() {
      _results = results;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BilingualText(
          english: "Search ${widget.mealType ?? 'Food'}",
          hindi: "${widget.mealType ?? 'भोजन'} खोजें",
          englishStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: "Search dishes like 'Dal Tadka'...",
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchController.text.isNotEmpty 
                        ? IconButton(icon: const Icon(Icons.clear), onPressed: () { 
                            _searchController.clear(); 
                            _onSearch(''); 
                          })
                        : null,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onChanged: _onSearch,
                  ),
                ),
                const SizedBox(width: 8),
                _scanButton(Icons.qr_code_scanner, _scanBarcode),
                const SizedBox(width: 4),
                _scanButton(Icons.camera_alt, _scanLabel),
              ],
            ),
          ),
          Expanded(
            child: _isLoading 
              ? _buildShimmer()
              : _results.isEmpty && _searchController.text.isNotEmpty
                ? _buildEmptyState()
                : _buildResults(),
          ),
        ],
      ),
    );
  }

  Widget _scanButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
      ),
      child: IconButton(
        icon: Icon(icon, color: AppColors.primary),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildResults() {
    return ListView.builder(
      itemCount: _results.length,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemBuilder: (context, index) {
        final item = _results[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: CircleAvatar(
              backgroundColor: AppColors.primary.withOpacity(0.1),
              child: const Icon(Icons.restaurant, color: AppColors.primary),
            ),
            title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(item.nameLocal ?? item.region ?? ''),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("${item.caloriesPer100g.toInt()} kcal", style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
                const Text("per 100g", style: TextStyle(fontSize: 10, color: Colors.grey)),
              ],
            ),
            onTap: () {
              context.push('/food/detail', extra: {'item': item, 'mealType': widget.mealType});
            },
          ),
        );
      },
    );
  }

  Widget _buildShimmer() {
    return ListView.builder(
      itemCount: 5,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: ShimmerLoader(width: double.infinity, height: 80, borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.no_food_outlined, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          const Text("No matches found in our Indian database.", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text("Try a different spelling or local name.", style: TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}
