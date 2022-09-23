class LanguageModel {
  bool? result;
  String? message;
  List<Languages>? languages;

  LanguageModel({this.result, this.message, this.languages});

  LanguageModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    if (json['languages'] != null) {
      languages = <Languages>[];
      json['languages'].forEach((v) {
        languages!.add(Languages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['message'] = message;
    if (languages != null) {
      data['languages'] = languages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Languages {
  int? id;
  String? language;
  String? shortcode;
  String? createdAt;
  // void? updatedAt;

  Languages({
    this.id,
    this.language,
    this.shortcode,
    this.createdAt,
  });

  Languages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    language = json['language'];
    shortcode = json['shortcode'];
    createdAt = json['created_at'];
    // updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['language'] = language;
    data['shortcode'] = shortcode;
    data['created_at'] = createdAt;
    // data['updated_at'] = updatedAt;
    return data;
  }
}
