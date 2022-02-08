import 'package:congoachat/src/models/post_model.dart';
import 'package:congoachat/src/services/shop_services.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';


class ShopBloc extends BlocBase {
  final ShopService _productService;

  ShopBloc(this._productService) {
    _loadVideos();
  }

  final BehaviorSubject<List<PostModel>> _listProduitsController =
  new BehaviorSubject<List<PostModel>>.seeded(List<PostModel>());

  Observable<List<PostModel>> get listProduitsFlux =>
      _listProduitsController.stream;

  Sink<List<PostModel>> get listProduitsEvent => _listProduitsController.sink;






  _loadVideos() async {
    listProduitsEvent.add(await _productService.getAllProduits());
  }

  @override
  void dispose() {
    _listProduitsController?.close();
    super.dispose();
  }
}
