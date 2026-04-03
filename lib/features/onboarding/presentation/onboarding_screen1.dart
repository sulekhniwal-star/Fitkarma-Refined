import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkarma/features/onboarding/data/onboarding_state.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';
import 'package:fitkarma/shared/theme/app_text_styles.dart';

class OnboardingScreen1 extends ConsumerStatefulWidget {
  const OnboardingScreen1({super.key});

  @override
  ConsumerState<OnboardingScreen1> createState() => _OnboardingScreen1State();
}

class _OnboardingScreen1State extends ConsumerState<OnboardingScreen1> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String? _selectedGender;
  DateTime? _dateOfBirth;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final onboardingState = ref.watch(onboardingStateProvider);
    final isHindi = onboardingState.language == 'hi';

    return Scaffold(
      appBar: AppBar(
        title: Text(isHindi ? 'आपका परिचय' : 'Tell us about yourself'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isHindi ? 'नाम' : 'Your Name',
                  style: AppTextStyles.labelLarge,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _nameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    hintText: isHindi ? 'अपना नाम दर्ज करें' : 'Enter your name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.person_outline),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                  ],
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return isHindi ? 'नाम आवश्यक है' : 'Name is required';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    ref.read(onboardingStateProvider.notifier).updateName(value.trim());
                  },
                ),
                const SizedBox(height: 24),
                Text(
                  isHindi ? 'लिंग' : 'Gender',
                  style: AppTextStyles.labelLarge,
                ),
                const SizedBox(height: 8),
                _buildGenderSelector(isHindi),
                const SizedBox(height: 24),
                Text(
                  isHindi ? 'जन्म तिथि' : 'Date of Birth',
                  style: AppTextStyles.labelLarge,
                ),
                const SizedBox(height: 8),
                _buildDatePicker(isHindi),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _canProceed() ? () => context.go('/onboarding/2') : null,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      isHindi ? 'आगे बढ़ें' : 'Continue',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGenderSelector(bool isHindi) {
    final genders = isHindi
        ? [('male', 'पुरुष', '👨'), ('female', 'महिला', '👩'), ('other', 'अन्य', '🧑')]
        : [('male', 'Male', '👨'), ('female', 'Female', '👩'), ('other', 'Other', '🧑')];

    return Row(
      children: genders.map((g) {
        final isSelected = _selectedGender == g.$1;
        return Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() => _selectedGender = g.$1);
              ref.read(onboardingStateProvider.notifier).updateGender(g.$1);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? AppColors.primary : Colors.grey.shade300,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    g.$3,
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    g.$2,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDatePicker(bool isHindi) {
    return InkWell(
      onTap: () async {
        final now = DateTime.now();
        final picked = await showDatePicker(
          context: context,
          initialDate: _dateOfBirth ?? now.subtract(const Duration(days: 365 * 25)),
          firstDate: DateTime(1920),
          lastDate: now.subtract(const Duration(days: 365 * 13)),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: AppColors.primary,
                ),
              ),
              child: child!,
            );
          },
        );
        if (picked != null) {
          setState(() => _dateOfBirth = picked);
          ref.read(onboardingStateProvider.notifier).updateDateOfBirth(picked);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              Icons.calendar_today,
              color: _dateOfBirth != null ? AppColors.primary : Colors.grey,
            ),
            const SizedBox(width: 12),
            Text(
              _dateOfBirth != null
                  ? '${_dateOfBirth!.day}/${_dateOfBirth!.month}/${_dateOfBirth!.year}'
                  : (isHindi ? 'तारीख चुनें' : 'Select date'),
              style: TextStyle(
                fontSize: 16,
                color: _dateOfBirth != null ? Colors.black87 : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _canProceed() {
    return _nameController.text.trim().isNotEmpty &&
        _selectedGender != null &&
        _dateOfBirth != null;
  }
}