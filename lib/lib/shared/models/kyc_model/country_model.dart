class SetCountryModel {
  String? userId;
  String? isKYCVerified;
  String? countryOfDocument;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  SetCountryModel(
      {this.userId,
        this.isKYCVerified,
        this.countryOfDocument,
        this.sId,
        this.createdAt,
        this.updatedAt,
        this.iV});

  SetCountryModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    isKYCVerified = json['isKYCVerified'];
    countryOfDocument = json['countryOfDocument'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['isKYCVerified'] = isKYCVerified;
    data['countryOfDocument'] = countryOfDocument;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}


class CountryListModel {
  String? id;
  String? image;
  String? name;
  String? nativeName;
  int? population;
  String? region;
  String? subregion;
  String? capital;
  List<String>? topLevelDomain;
  List<Currencies>? currencies;
  List<Languages>? languages;
  // List<String>? borders;

  CountryListModel(
      {this.id,
        this.image,
        this.name,
        this.nativeName,
        this.population,
        this.region,
        this.subregion,
        this.capital,
        this.topLevelDomain,
        this.currencies,
        this.languages,
        // this.borders
      });

  CountryListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    nativeName = json['nativeName'];
    population = json['population'];
    region = json['region'];
    subregion = json['subregion'];
    capital = json['capital'];
    topLevelDomain = json['topLevelDomain'].cast<String>();
    if (json['currencies'] != null) {
      currencies = <Currencies>[];
      json['currencies'].forEach((v) {
        currencies!.add(Currencies.fromJson(v));
      });
    }
    if (json['languages'] != null) {
      languages = <Languages>[];
      json['languages'].forEach((v) {
        languages!.add(Languages.fromJson(v));
      });
    }
    // borders = json['borders'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['name'] = name;
    data['nativeName'] = nativeName;
    data['population'] = population;
    data['region'] = region;
    data['subregion'] = subregion;
    data['capital'] = capital;
    data['topLevelDomain'] = topLevelDomain;
    if (currencies != null) {
      data['currencies'] = currencies!.map((v) => v.toJson()).toList();
    }
    if (languages != null) {
      data['languages'] = languages!.map((v) => v.toJson()).toList();
    }
    // data['borders'] = borders;
    return data;
  }
}
class Currencies {
  String? code;
  String? name;
  String? symbol;

  Currencies({this.code, this.name, this.symbol});

  Currencies.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    symbol = json['symbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['name'] = name;
    data['symbol'] = symbol;
    return data;
  }
}

class Languages {
  String? iso6391;
  String? iso6392;
  String? name;
  String? nativeName;

  Languages({this.iso6391, this.iso6392, this.name, this.nativeName});

  Languages.fromJson(Map<String, dynamic> json) {
    iso6391 = json['iso639_1'];
    iso6392 = json['iso639_2'];
    name = json['name'];
    nativeName = json['nativeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['iso639_1'] = iso6391;
    data['iso639_2'] = iso6392;
    data['name'] = name;
    data['nativeName'] = nativeName;
    return data;
  }
}