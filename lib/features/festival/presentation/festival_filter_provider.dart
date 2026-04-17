import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'festival_filter_provider.g.dart';

@riverpod
class FestivalRegionFilter extends _$FestivalRegionFilter {
  @override
  String build() => 'All';

  void setFilter(String filter) => state = filter;
}
