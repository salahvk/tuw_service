class CountriesModel {
  bool? result;
  String? message;
  List<Countries>? countries;

  CountriesModel({this.result, this.message, this.countries});

  CountriesModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    if (json['countries'] != null) {
      countries = <Countries>[];
      json['countries'].forEach((v) {
        countries!.add(Countries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['message'] = message;
    if (countries != null) {
      data['countries'] = countries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Countries {
  int? countryId;
  String? countryName;
  int? phonecode;
  String? countryflag;

  Countries(
      {this.countryId, this.countryName, this.phonecode, this.countryflag});

  Countries.fromJson(Map<String, dynamic> json) {
    countryId = json['country_id'];
    countryName = json['country_name'];
    phonecode = json['phonecode'];
    countryflag = json['countryflag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country_id'] = countryId;
    data['country_name'] = countryName;
    data['phonecode'] = phonecode;
    data['countryflag'] = countryflag;
    return data;
  }
}
