import 'package:wanandroidflutter/widget/provider/provider_state_widget.dart';

class HomeProjectPageModel extends ProviderStatePageModel {
  HomeProjectPageModel() : super(state: ProviderWidgetState.LOADING);

  Future<void> loadProjectList() async {
    await Future.delayed(Duration(seconds: 5));
    showContent();
  }
}
