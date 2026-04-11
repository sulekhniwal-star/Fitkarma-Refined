import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../data/health_repository.dart';
import '../../../shared/theme/app_colors.dart';

class LabReportScanScreen extends ConsumerStatefulWidget {
  const LabReportScanScreen({super.key});

  @override
  ConsumerState<LabReportScanScreen> createState() => _LabReportScanScreenState();
}

class _LabReportScanScreenState extends ConsumerState<LabReportScanScreen> {
  File? _image;
  bool _isProcessing = false;
  final List<Map<String, String>> _extractedMetrics = [];

  final TextRecognizer _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  @override
  void dispose() {
    _textRecognizer.close();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _isProcessing = true;
        _extractedMetrics.clear();
      });
      _processImage();
    }
  }

  Future<void> _processImage() async {
    if (_image == null) return;

    final inputImage = InputImage.fromFile(_image!);
    final recognizedText = await _textRecognizer.processImage(inputImage);

    final text = recognizedText.text;
    _extractBasicMetrics(text);
    
    // Call advanced AI extractor
    try {
      final repo = ref.read(healthRepositoryProvider);
      final aiMetrics = await repo.extractMetricsFromLabReport(text);
      if (aiMetrics.isNotEmpty) {
        setState(() {
          for (final entry in aiMetrics.entries) {
            // Avoid duplicates from regex
            if (!_extractedMetrics.any((m) => m['key'] == entry.key)) {
              _extractedMetrics.add({
                'key': entry.key,
                'value': entry.value,
                'unit': '', // AI usually provides units in the value or separately, here we assume it's in the value or handled by the map
              });
            }
          }
        });
      }
    } catch (e) {
      // Fallback to basic metrics only
    }

    setState(() {
      _isProcessing = false;
    });
  }

  void _extractBasicMetrics(String text) {
    final glucosePattern = RegExp(r'(Glucose|Blood Sugar|Sugar)\s*[:\-]?\s*(\d+(\.\d+)?)', caseSensitive: false);
    final hemoglobinPattern = RegExp(r'(Hemoglobin|Hb)\s*[:\-]?\s*(\d+(\.\d+)?)', caseSensitive: false);
    final cholesterolPattern = RegExp(r'(Total Cholesterol|Cholesterol)\s*[:\-]?\s*(\d+(\.\d+)?)', caseSensitive: false);

    final glucoseMatch = glucosePattern.firstMatch(text);
    if (glucoseMatch != null) {
      _extractedMetrics.add({'key': 'Blood Glucose', 'value': glucoseMatch.group(2)!, 'unit': 'mg/dL'});
    }

    final hbMatch = hemoglobinPattern.firstMatch(text);
    if (hbMatch != null) {
      _extractedMetrics.add({'key': 'Hemoglobin', 'value': hbMatch.group(2)!, 'unit': 'g/dL'});
    }

    final chalMatch = cholesterolPattern.firstMatch(text);
    if (chalMatch != null) {
      _extractedMetrics.add({'key': 'Total Cholesterol', 'value': chalMatch.group(2)!, 'unit': 'mg/dL'});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Scan Lab Report · लैब रिपोर्ट स्कैन', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.indigo[800],
        foregroundColor: Colors.white,
      ),
      body: _image == null ? _buildInitialState() : _buildResultState(),
    );
  }

  Widget _buildInitialState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.description_outlined, size: 80, color: Colors.indigo[100]),
          const SizedBox(height: 24),
          const Text(
            'Upload your Lab Report',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 8),
            child: Text(
              'Our AI will extract health metrics like Glucose, HbA1c, and Cholesterol automatically.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 40),
          _buildSourceButton(
            icon: Icons.camera_alt,
            label: 'Take Photo',
            onTap: () => _pickImage(ImageSource.camera),
          ),
          const SizedBox(height: 16),
          _buildSourceButton(
            icon: Icons.photo_library,
            label: 'Select from Gallery',
            onTap: () => _pickImage(ImageSource.gallery),
          ),
        ],
      ),
    );
  }

  Widget _buildSourceButton({required IconData icon, required String label, required VoidCallback onTap}) {
    return SizedBox(
      width: 260,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.indigo[800],
          minimumSize: const Size.fromHeight(56),
          side: BorderSide(color: Colors.indigo[100]!),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }

  Widget _buildResultState() {
    if (_isProcessing) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Processing report...'),
            Text('एआई स्कैन कर रहा है...', style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(image: FileImage(_image!), fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 24),
          const Text('Extracted Metrics · एक्सट्रैक्टेड मेट्रिक्स', 
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          if (_extractedMetrics.isEmpty)
             _buildNoMetricsFound()
          else
            ..._extractedMetrics.asMap().entries.map((entry) {
            final idx = entry.key;
            final m = entry.value;
            return _MetricConfirmationTile(
              metric: m['key']!,
              value: m['value']!,
              unit: m['unit']!,
              onChanged: (newVal) {
                setState(() {
                  _extractedMetrics[idx]['value'] = newVal;
                });
              },
            );
          }),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(top: 8, bottom: 24),
            child: Text(
              '⚠️ Please verify the extracted values against your physical report before saving.',
              style: TextStyle(fontSize: 12, color: Colors.orange, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                final repo = ref.read(healthRepositoryProvider);
                final metricsMap = {for (var m in _extractedMetrics) m['key']!: m['value']!};
                
                await repo.saveLabReport(
                  title: 'Lab Report - ${DateFormat('dd MMM yyyy').format(DateTime.now())}',
                  date: DateTime.now(),
                  metrics: metricsMap,
                );

                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Lab report saved and metrics updated!')),
                  );
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo[800],
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text('CONFIRM & SAVE · सेव करें', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          TextButton(
            onPressed: () => setState(() => _image = null),
            child: const Center(child: Text('Clear and try again')),
          ),
        ],
      ),
    );
  }

  Widget _buildNoMetricsFound() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.withOpacity(0.3)),
      ),
      child: const Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: Colors.orange),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'No common metrics could be automatically identified. You might need to enter them manually.',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricConfirmationTile extends StatefulWidget {
  final String metric;
  final String value;
  final String unit;
  final ValueChanged<String> onChanged;

  const _MetricConfirmationTile({
    required this.metric,
    required this.value,
    required this.unit,
    required this.onChanged,
  });

  @override
  State<_MetricConfirmationTile> createState() => _MetricConfirmationTileState();
}

class _MetricConfirmationTileState extends State<_MetricConfirmationTile> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 4)],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.metric, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 4),
                Text(widget.unit, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          SizedBox(
            width: 80,
            child: TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              onChanged: widget.onChanged,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 8),
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.check_circle, color: Colors.green, size: 20),
        ],
      ),
    );
  }
}
