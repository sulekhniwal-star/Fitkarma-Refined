import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_text_styles.dart';
import '../../../shared/widgets/async_value_widget.dart';
import '../../../shared/widgets/food_item_card.dart';
import '../../../shared/widgets/shimmer_loader.dart';
import '../domain/food_providers.dart';
import '../../../shared/widgets/meal_tab_bar.dart';

class FoodLogScreen extends ConsumerStatefulWidget {
  final String mealType;

  const FoodLogScreen({super.key, required this.mealType});

  @override
  ConsumerState<FoodLogScreen> createState() => _FoodLogScreenState();
}

class _FoodLogScreenState extends ConsumerState<FoodLogScreen> {
  final _searchController = TextEditingController();
  final stt.SpeechToText _speech = stt.SpeechToText();
  Timer? _debounce;
  String _query = '';
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    await _speech.initialize();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() => _query = query);
    });
  }

  void _startListening() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(onResult: (val) {
          setState(() {
            _searchController.text = val.recognizedWords;
            _query = val.recognizedWords;
          });
        });
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final searchResults = ref.watch(foodSearchProvider(_query));

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.mealType[0].toUpperCase()}${widget.mealType.substring(1)} Log'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Search Bar
            _buildSearchBar(isDark),
            const SizedBox(height: 24),

            if (_query.isNotEmpty) ...[
              Text('Search Results', style: AppTextStyles.h3(isDark)),
              AsyncValueWidget<List<Map<String, dynamic>>>(
                value: searchResults,
                data: (items) => ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return FoodItemCard(
                      name: item['name'],
                      portionInfo: '${item['calories']} kcal',
                      emoji: item['emoji'] ?? '🍽',
                      onAdd: () => _showPortionSelector(item),
                    );
                  },
                ),
              ),
            ] else ...[
              // 2. Quick Actions
              _buildQuickActions(context, isDark),
              const SizedBox(height: 32),

              // 3. Frequent Indian Portions
              Text('Common Indian Portions', style: AppTextStyles.h3(isDark)),
              const SizedBox(height: 12),
              _buildFrequentGrid(ref, isDark),
              const SizedBox(height: 32),

              // 4. Recent Logs
              Text('Recently Logged', style: AppTextStyles.h3(isDark)),
              const SizedBox(height: 12),
              _buildRecentLogs(isDark),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColorsDark.surface : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10),
        ],
      ),
      child: TextField(
        controller: _searchController,
        onChanged: _onSearchChanged,
        decoration: InputDecoration(
          hintText: 'Search food or "2 chapatis"...',
          hintStyle: TextStyle(color: isDark ? Colors.white54 : Colors.black54),
          prefixIcon: const Icon(Icons.search),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(_isListening ? Icons.mic : Icons.mic_none, color: _isListening ? Colors.red : null),
                onPressed: _startListening,
              ),
              IconButton(
                icon: const Icon(Icons.barcode_reader),
                onPressed: () => context.push('/home/food/scan'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context, bool isDark) {
    final actions = [
      {'label': 'Scan Label', 'icon': Icons.qr_code_scanner, 'route': '/home/food/scan'},
      {'label': 'Photo Log', 'icon': Icons.camera_alt_outlined, 'route': '/home/food/photo'},
      {'label': 'Lab/Rx Scan', 'icon': Icons.document_scanner_outlined, 'route': '/home/food/lab-scan'},
      {'label': 'Manual', 'icon': Icons.edit_note, 'route': null},
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: actions.map((a) {
        return ActionChip(
          avatar: Icon(a['icon'] as IconData, size: 16, color: AppColors.primary),
          label: Text(a['label'] as String),
          onPressed: () {
            if (a['route'] != null) context.push(a['route'] as String);
          },
          backgroundColor: isDark ? AppColorsDark.surface : AppColors.surface,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        );
      }).toList(),
    );
  }

  Widget _buildFrequentGrid(WidgetRef ref, bool isDark) {
    final frequent = ref.watch(indianFrequentFoodsProvider);

    return AsyncValueWidget<List<Map<String, dynamic>>>(
      value: frequent,
      data: (items) => GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 2.5,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return InkWell(
            onTap: () => _showPortionSelector(item),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isDark ? AppColorsDark.surface : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.divider.withValues(alpha: 0.5)),
              ),
              child: Row(
                children: [
                  Text(item['emoji'], style: const TextStyle(fontSize: 20)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(item['name'], style: AppTextStyles.labelMedium(isDark), maxLines: 1),
                        Text(item['portion'], style: AppTextStyles.caption(isDark)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRecentLogs(bool isDark) {
    return Column(
      children: [
        FoodItemCard(
          name: 'Dal Makhani',
          nameHi: 'दाल मखनी',
          portionInfo: '1 bowl · 310 kcal',
          emoji: '🥣',
          onAdd: () {},
        ),
      ],
    );
  }

  void _showPortionSelector(Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => _PortionSelectorSheet(item: item),
    );
  }
}

class _PortionSelectorSheet extends StatefulWidget {
  final Map<String, dynamic> item;
  const _PortionSelectorSheet({required this.item});

  @override
  State<_PortionSelectorSheet> createState() => _PortionSelectorSheetState();
}

class _PortionSelectorSheetState extends State<_PortionSelectorSheet> {
  double _quantity = 1.0;
  String _unit = 'katori';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.fromLTRB(24, 24, 24, 24 + MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(widget.item['emoji'], style: const TextStyle(fontSize: 40)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.item['name'], style: AppTextStyles.h2(isDark)),
                    Text('Approx. ${widget.item['calories']} kcal per unit',
                        style: AppTextStyles.caption(isDark)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Text('Select Portion', style: AppTextStyles.labelLarge(isDark)),
          const SizedBox(height: 16),
          Row(
            children: [
              Text('${_quantity.toStringAsFixed(1)} ', style: AppTextStyles.h1(isDark)),
              const SizedBox(width: 8),
              DropdownButton<String>(
                value: _unit,
                items: ['katori', 'piece', 'glass', 'gram', 'bowl']
                    .map((u) => DropdownMenuItem(value: u, child: Text(u)))
                    .toList(),
                onChanged: (val) => setState(() => _unit = val!),
              ),
            ],
          ),
          Slider(
            value: _quantity,
            min: 0.5,
            max: 5.0,
            divisions: 9,
            activeColor: AppColors.primary,
            onChanged: (val) => setState(() => _quantity = val),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // TODO: Call repo.logFood()
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Logged ${widget.item['name']}!')),
                );
              },
              child: const Text('Confirm & Log'),
            ),
          ),
        ],
      ),
    );
  }
}
