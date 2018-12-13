import 'package:bloc_arch/model/item_model.dart';

class SearchModel {
  int total_count;
  bool incomplete_results;
  List<ItemModel> items;

  SearchModel({
    this.total_count,
    this.incomplete_results,
    this.items,
  });

  static SearchModel fromJson(Map<String, dynamic> json) {
    var list = json['items'] as List;

    List<ItemModel> itemModels =
        list.map((i) => ItemModel.fromJson(i)).toList();
    return SearchModel(
      total_count: json['total_count'],
      incomplete_results: json['incomplete_results'],
      items: itemModels,
    );
  }
}
