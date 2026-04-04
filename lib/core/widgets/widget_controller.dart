import 'package:home_widget/home_widget.dart';
import 'package:fitkarma/core/router/app_router.dart';

class WidgetController {
  static Future<void> initialize() async {
    HomeWidget.setAppGroupId('group.fitkarma.app');
    
    // Listen for deep links from widgets
    HomeWidget.widgetClicked.listen((Uri? uri) {
      if (uri != null) {
        _handleWidgetClick(uri);
      }
    });

    // Check if app was started from a widget
    final initialUri = await HomeWidget.initiallyLaunchedFromHomeWidget();
    if (initialUri != null) {
      _handleWidgetClick(initialUri);
    }
  }

  static void _handleWidgetClick(Uri uri) {
    if (uri.host == 'emergency' || uri.path == '/emergency') {
      appRouter.push('/emergency');
    }
  }

  static Future<void> updateEmergencyWidget({
    required String bloodGroup,
    required String contact,
  }) async {
    await HomeWidget.saveWidgetData<String>('blood_group', bloodGroup);
    await HomeWidget.saveWidgetData<String>('emergency_contact', contact);
    await HomeWidget.updateWidget(
      name: 'EmergencyWidgetProvider',
      androidName: 'EmergencyWidgetProvider',
      iOSName: 'EmergencyWidget',
    );
  }
}
