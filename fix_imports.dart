import 'dart:io';

void main() {
  final dir = Directory('f:/Fitkarma/fitkarma/lib');
  final files = dir.listSync(recursive: true).whereType<File>().where((f) => f.path.endsWith('.dart'));
  
  for (var file in files) {
    var content = file.readAsStringSync();
    var newContent = content.replaceAll(RegExp(r"'[^']*shared/theme/app_colors\.dart'"), "'package:fitkarma/core/theme/app_colors.dart'");
    newContent = newContent.replaceAll(RegExp(r"'[^']*shared/theme/app_text_styles\.dart'"), "'package:fitkarma/core/theme/app_text_styles.dart'");
    newContent = newContent.replaceAll(RegExp(r"'[^']*shared/theme/app_gradients\.dart'"), "'package:fitkarma/core/theme/app_gradients.dart'");
    newContent = newContent.replaceAll(RegExp(r"'[^']*shared/theme/app_theme\.dart'"), "'package:fitkarma/core/theme/app_theme.dart'");
    
    if (content != newContent) {
      file.writeAsStringSync(newContent);
      print('Updated ${file.path}');
    }
  }
}
