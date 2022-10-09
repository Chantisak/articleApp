
import 'dart:convert';

List<ArticleModel> articleModelFromJson(String str) => List<ArticleModel>.from(json.decode(str).map((x) => ArticleModel.fromJson(x)));

String articleModelToJson(List<ArticleModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ArticleModel {
    ArticleModel({
        this.id,
        this.title,
        this.description,
        this.context,
        this.imaeUrl,
        this.isHit,
    });

    String? id;
    String? title;
    String? description;
    String? context;
    String? imaeUrl;
    String? isHit;

    factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        context: json["context"],
        imaeUrl: json["imae_url"],
        isHit: json["is_hit"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "context": context,
        "imae_url": imaeUrl,
        "is_hit": isHit,
    };
}
