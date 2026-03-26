import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/theme/accessibility_provider.dart';

/// A wrapper widget that adds Semantics for screen reader support.
/// Automatically respects the user's accessibility settings.
class AccessibleWidget extends ConsumerWidget {
  final Widget child;
  final String? label;
  final String? hint;
  final bool? isButton;
  final bool? isImage;
  final bool? isTextField;
  final bool? isChecked;
  final bool? isSlider;

  const AccessibleWidget({
    super.key,
    required this.child,
    this.label,
    this.hint,
    this.isButton,
    this.isImage,
    this.isTextField,
    this.isChecked,
    this.isSlider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(accessibilityProvider);

    if (!settings.enableSemantics) {
      return child;
    }

    // Build semantic properties
    final Map<String, Object?> properties = {};

    if (label != null) {
      properties['label'] = label;
    }
    if (hint != null) {
      properties['hint'] = hint;
    }
    if (isButton == true) {
      properties['button'] = true;
    }
    if (isImage == true) {
      properties['image'] = true;
    }
    if (isTextField == true) {
      properties['textField'] = true;
    }
    if (isChecked != null) {
      properties['checked'] = isChecked;
    }
    if (isSlider == true) {
      properties['slider'] = true;
    }

    return Semantics(
      label: label,
      hint: hint,
      button: isButton,
      image: isImage,
      textField: isTextField,
      checked: isChecked,
      slider: isSlider,
      child: child,
    );
  }
}

/// A mixin that provides semantic labeling for interactive widgets.
/// Use this with existing widgets to add accessibility support.
mixin SemanticLabeling {
  /// Creates a semantic label for a given value
  static String createCountLabel(int count, String item) {
    return '$count $item${count == 1 ? '' : 's'}';
  }

  /// Creates a semantic label for a progress value
  static String createProgressLabel(double value, String unit) {
    final percentage = (value * 100).round();
    return '$percentage% $unit';
  }

  /// Creates a semantic label for a date range
  static String createDateRangeLabel(DateTime start, DateTime end) {
    return '${_formatDate(start)} to ${_formatDate(end)}';
  }

  static String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

/// Extension methods for adding semantics to common Flutter widgets
extension SemanticsExtensions on Widget {
  /// Wrap a widget with semantic labeling for screen readers
  Widget withAccessibility({
    required String label,
    String? hint,
    bool isButton = false,
    bool isImage = false,
    bool isTextField = false,
    bool? isChecked,
    bool isSlider = false,
  }) {
    return Semantics(
      label: label,
      hint: hint,
      button: isButton,
      image: isImage,
      textField: isTextField,
      checked: isChecked,
      slider: isSlider,
      child: this,
    );
  }
}

/// A semantic button that announces its tap action
class AccessibleButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final String? semanticLabel;
  final String? semanticHint;

  const AccessibleButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.semanticLabel,
    this.semanticHint,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticLabel,
      hint: semanticHint,
      enabled: onPressed != null,
      child: ElevatedButton(onPressed: onPressed, child: child),
    );
  }
}

/// A semantic icon button with proper labeling
class AccessibleIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String semanticLabel;
  final String? semanticHint;
  final Color? color;
  final double? size;

  const AccessibleIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.semanticLabel,
    this.semanticHint,
    this.color,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticLabel,
      hint: semanticHint,
      enabled: onPressed != null,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: color, size: size),
      ),
    );
  }
}

/// A semantic switch with proper labeling
class AccessibleSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String semanticLabel;
  final String? semanticHint;

  const AccessibleSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    required this.semanticLabel,
    this.semanticHint,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      hint: semanticHint,
      checked: value,
      toggled: true,
      child: Switch(value: value, onChanged: onChanged),
    );
  }
}

/// A semantic slider with proper labeling
class AccessibleSlider extends StatelessWidget {
  final double value;
  final double min;
  final double max;
  final int divisions;
  final ValueChanged<double> onChanged;
  final String semanticLabel;
  final String Function(double)? semanticValueLabel;

  const AccessibleSlider({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    required this.semanticLabel,
    this.divisions = 0,
    this.semanticValueLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      value: semanticValueLabel?.call(value) ?? value.toString(),
      slider: true,
      child: Slider(
        value: value,
        min: min,
        max: max,
        divisions: divisions,
        onChanged: onChanged,
      ),
    );
  }
}

/// A semantic checkbox with proper labeling
class AccessibleCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String semanticLabel;

  const AccessibleCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      checked: value,
      child: Checkbox(value: value, onChanged: onChanged),
    );
  }
}

/// A semantic image with proper labeling
class AccessibleImage extends StatelessWidget {
  final Image image;
  final String semanticLabel;
  final bool excludeFromSemantics;

  const AccessibleImage({
    super.key,
    required this.image,
    required this.semanticLabel,
    this.excludeFromSemantics = false,
  });

  @override
  Widget build(BuildContext context) {
    if (excludeFromSemantics) {
      return image;
    }
    return Semantics(image: true, label: semanticLabel, child: image);
  }
}
