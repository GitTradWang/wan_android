import 'package:wanandroidflutter/entity/home_index_article_list_entity.dart';
import 'package:wanandroidflutter/net/wan_android_api.dart';
import 'package:wanandroidflutter/widget/provider/provider_state_widget.dart';

class HomeProjectPageModel extends ProviderStatePageModel {
  int _currentPage = 0;

  bool _noMoreData = false;

  List<HomeIndexArticleListData> _list = [];

  HomeProjectPageModel() : super(state: ProviderWidgetState.LOADING);

  List<HomeIndexArticleListData> get list => _list;

  bool get noMoreData => _noMoreData;

  Future<void> loadProjectList({bool first = false}) async {
    _list.clear();

    var entity = await WanAndroidApi.get<HomeIndexArticleListEntity>('article/listproject/$_currentPage/json');

    _currentPage = entity.data.curPage;
    _noMoreData = entity.data.curPage >= entity.data.pageCount && entity.data.over;

    _list.addAll(entity.data.datas);
    if (first) {
      showContent();
    } else {
      notifyListeners();
    }
  }

  Future<void> loadMore() async {
    var entity = await WanAndroidApi.get<HomeIndexArticleListEntity>('article/listproject/$_currentPage/json');

    _currentPage = entity.data.curPage;
    _noMoreData = entity.data.curPage >= entity.data.pageCount && entity.data.over;
    _list.addAll(entity.data.datas);
    notifyListeners();
  }

  Future<void> refresh() async {
    _currentPage = 0;
    await loadProjectList(first: false);
  }
}
