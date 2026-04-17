import '../models/insight_rule.dart';
import '../../../core/storage/drift_service.dart';
import '../../../core/config/remote_config.dart';

class DynamicServerRule extends InsightRule {
  final String _id;
  final int _priority;
  final String _message;

  DynamicServerRule(this._id, this._priority, this._message);

  @override
  String get id => _id;

  @override
  int get priority => _priority;

  @override
  Future<bool> condition(DriftService db, String userId) async {
    // Dynamic server rules are usually pre-evaluated or simple triggers
    return true;
  }

  @override
  Future<String> message(DriftService db, String userId) async {
    return _message;
  }
}

class ServerRuleFetcher {
  static List<InsightRule> getRules(RemoteConfigData config) {
    final List<dynamic>? serverRules = config.getJson('insight.server_rules');
    if (serverRules == null) return [];

    return serverRules.map((r) {
      return DynamicServerRule(
        r['id']?.toString() ?? 'server_${r.hashCode}',
        r['priority'] as int? ?? 10,
        r['message']?.toString() ?? '',
      );
    }).toList();
  }
}

