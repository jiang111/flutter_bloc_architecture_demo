class ItemModel {
  int id;
  String name;
  String full_name;
  bool private;
  String url;
  String description;
  int size;
  String language;
  int forks;
  int watchers;

  ItemModel(
      {this.id,
      this.name,
      this.full_name,
      this.private,
      this.url,
      this.description,
      this.size,
      this.language,
      this.forks,
      this.watchers});

  static ItemModel fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'],
      name: json['name'],
      full_name: json['full_name'],
      private: json['private'],
      url: json['url'],
      description: json['description'],
      size: json['size'],
      language: json['language'],
      forks: json['forks'],
      watchers: json['watchers'],
    );
  }
}
