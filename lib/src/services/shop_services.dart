import 'package:congoachat/src/models/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ShopService {

  static final String _baseUrl = 'ads';
  final CollectionReference _db;
  DateTime toDay;

  ShopService() : _db = Firestore.instance.collection(_baseUrl);

  Future<List<PostModel>> getProduitsByCategory(String category) async {
    final CollectionReference _dbs = Firestore.instance.collection(_baseUrl);
    QuerySnapshot query =
    await _dbs
        .where("category", isEqualTo: category)
        .where("isApproved", isEqualTo: true)
        .where("isAvailable", isEqualTo: true)
        .orderBy("adTime", descending: true)
    //.orderBy("Title", descending: true)
        .limit(150).getDocuments();

    List<PostModel> products = query.documents
        .map((doc) => PostModel.fromSnapshotJson(doc))
        .toList();
    return products;
  }

  Future<List<PostModel>> getAllProduits() async {
    final CollectionReference _dbs = Firestore.instance.collection(_baseUrl);
    await Future.delayed(Duration(milliseconds: 500));
    QuerySnapshot query =
    await _dbs

        .where("isApproved", isEqualTo: true)
        .where("isAvailable", isEqualTo: true)
        .orderBy("adTime", descending: true)
        .limit(150)
        .getDocuments();

    List<PostModel> products = query.documents
        .map((doc) => PostModel.fromSnapshotJson(doc))
        .toList();
    return products;
  }





}
