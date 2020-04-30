import 'package:wanandroidflutter/entity/base_entity.dart';
import 'package:wanandroidflutter/entity/home_index_article_list_entity.dart';
import 'package:wanandroidflutter/net/wan_android_api.dart';
import 'package:wanandroidflutter/widget/provider/base_page_widget.dart';

class HomeIndexPageListModel extends BaseProviderPageModel {
  HomeIndexPageListModel() : super(state: ProviderWidgetState.LOADING);

  int currentPage = 0;

  bool noMoreData = false;

  List<HomeIndexArticleListData> datas = [];

  Future<void> getArticleListData({bool first}) async {
    BaseEntity<HomeIndexArticleListEntity> entity = await WanAndroidApi.get<HomeIndexArticleListEntity>('article/list/$currentPage/json');
    currentPage = entity.data.curPage;
    noMoreData = entity.data.curPage >= entity.data.pageCount && entity.data.over;
    datas = entity.data.datas;
    if(first==true){
      showContent();
    }else{
      notifyListeners();
    }
  }

  Future<void> loadMore() async {
    currentPage++;
    BaseEntity<HomeIndexArticleListEntity> entity = await WanAndroidApi.get<HomeIndexArticleListEntity>('article/list/$currentPage/json');
    currentPage = entity.data.curPage;
    noMoreData = entity.data.curPage >= entity.data.pageCount && entity.data.over;
    datas.addAll(entity.data.datas);
    notifyListeners();
    return;
  }

  Future<void> refresh() async {
    currentPage=0;
    await getArticleListData(first: false);
    return;
  }
}
