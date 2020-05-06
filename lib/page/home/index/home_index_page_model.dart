import 'package:wanandroidflutter/entity/base_entity.dart';
import 'package:wanandroidflutter/entity/home_index_article_list_entity.dart';
import 'package:wanandroidflutter/net/wan_android_api.dart';
import 'package:wanandroidflutter/widget/provider/provider_state_widget.dart';

class HomeIndexPageListModel extends ProviderStatePageModel {
  HomeIndexPageListModel() : super(state: ProviderWidgetState.LOADING);

  int currentPage = 0;

  bool noMoreData = false;

  List<HomeIndexArticleListData> articleList = [];

  Future<void> getArticleListData({bool first}) async {
    articleList.clear();
    await _getTopArticlList();
    BaseEntity<HomeIndexArticleListEntity> entity =
    await WanAndroidApi.get<HomeIndexArticleListEntity>('article/list/$currentPage/json');
    currentPage = entity.data.curPage;
    noMoreData =
        entity.data.curPage >= entity.data.pageCount && entity.data.over;
    articleList.addAll(entity.data.datas);
    if (first == true) {
      showContent();
    } else {
      notifyListeners();
    }
  }

  Future<void> loadMore() async {
    currentPage++;
    BaseEntity<HomeIndexArticleListEntity> entity =
    await WanAndroidApi.get<HomeIndexArticleListEntity>('article/list/$currentPage/json');
    currentPage = entity.data.curPage;
    noMoreData = entity.data.curPage >= entity.data.pageCount && entity.data.over;
    articleList.addAll(entity.data.datas);
    notifyListeners();
    return;
  }

  Future<void> refresh() async {
    currentPage = 0;
    articleList.clear();
    await _getTopArticlList();
    await getArticleListData(first: false);
    return;
  }

  Future<void> _getTopArticlList() async {
    BaseEntity<List<HomeIndexArticleListData>> entity = await WanAndroidApi.get<List<HomeIndexArticleListData>>('article/top/json');
    var data = entity.data.map((data) {
      data.top = true;
      return data;
    });
    articleList.addAll(data);
  }
}
