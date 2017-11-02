import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_sample/models.dart';
import 'package:redux_sample/actions.dart';

class FilterSelectorViewModel {
  final Function(VisibilityFilter) onFilterSelected;
  final VisibilityFilter activeFilter;

  FilterSelectorViewModel({
    @required this.onFilterSelected,
    @required this.activeFilter,
  });

  static FilterSelectorViewModel fromStore(Store<AppState> store) {
    return new FilterSelectorViewModel(
      onFilterSelected: (filter) {
        store.dispatch(new UpdateFilterAction(filter));
      },
      activeFilter: store.state.activeFilter,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is FilterSelectorViewModel &&
              runtimeType == other.runtimeType &&
              activeFilter == other.activeFilter;

  @override
  int get hashCode => activeFilter.hashCode;
}

class FilterSelector extends StatelessWidget {
  final ViewModelBuilder<FilterSelectorViewModel> builder;

  FilterSelector({Key key, @required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, FilterSelectorViewModel>(
      distinct: true,
      converter: FilterSelectorViewModel.fromStore,
      builder: builder,
    );
  }
}