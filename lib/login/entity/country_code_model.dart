// To parse this JSON data, do
//
//     final countryCodeModel = countryCodeModelFromJson(jsonString);

import 'dart:convert';

CountryCodeModel countryCodeModelFromJson(String str) =>
    CountryCodeModel.fromJson(json.decode(str));

String countryCodeModelToJson(CountryCodeModel data) =>
    json.encode(data.toJson());

class CountryCodeModel {
  City? city;
  Continent? continent;
  Country? country;
  Location? location;
  List<Subdivision>? subdivisions;
  State? state;
  List<Datasource>? datasource;
  String? ip;

  CountryCodeModel({
    this.city,
    this.continent,
    this.country,
    this.location,
    this.subdivisions,
    this.state,
    this.datasource,
    this.ip,
  });

  factory CountryCodeModel.fromJson(Map<String, dynamic> json) =>
      CountryCodeModel(
        city: json["city"] == null ? null : City.fromJson(json["city"]),
        continent: json["continent"] == null
            ? null
            : Continent.fromJson(json["continent"]),
        country:
        json["country"] == null ? null : Country.fromJson(json["country"]),
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        subdivisions: json["subdivisions"] == null
            ? []
            : List<Subdivision>.from(
            json["subdivisions"]!.map((x) => Subdivision.fromJson(x))),
        state: json["state"] == null ? null : State.fromJson(json["state"]),
        datasource: json["datasource"] == null
            ? []
            : List<Datasource>.from(
            json["datasource"]!.map((x) => Datasource.fromJson(x))),
        ip: json["ip"],
      );

  Map<String, dynamic> toJson() => {
    "city": city?.toJson(),
    "continent": continent?.toJson(),
    "country": country?.toJson(),
    "location": location?.toJson(),
    "subdivisions": subdivisions == null
        ? []
        : List<dynamic>.from(subdivisions!.map((x) => x.toJson())),
    "state": state?.toJson(),
    "datasource": datasource == null
        ? []
        : List<dynamic>.from(datasource!.map((x) => x.toJson())),
    "ip": ip,
  };
}

class City {
  String? name;
  CityNames? names;

  City({
    this.name,
    this.names,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
    name: json["name"],
    names: json["names"] == null ? null : CityNames.fromJson(json["names"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "names": names?.toJson(),
  };
}

class CityNames {
  String? en;

  CityNames({
    this.en,
  });

  factory CityNames.fromJson(Map<String, dynamic> json) => CityNames(
    en: json["en"],
  );

  Map<String, dynamic> toJson() => {
    "en": en,
  };
}

class Continent {
  String? code;
  int? geonameId;
  ContinentNames? names;
  String? name;

  Continent({
    this.code,
    this.geonameId,
    this.names,
    this.name,
  });

  factory Continent.fromJson(Map<String, dynamic> json) => Continent(
    code: json["code"],
    geonameId: json["geoname_id"],
    names: json["names"] == null
        ? null
        : ContinentNames.fromJson(json["names"]),
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "geoname_id": geonameId,
    "names": names?.toJson(),
    "name": name,
  };
}

class ContinentNames {
  String? de;
  String? en;
  String? es;
  String? fa;
  String? fr;
  String? ja;
  String? ko;
  String? ptBr;
  String? ru;
  String? zhCn;

  ContinentNames({
    this.de,
    this.en,
    this.es,
    this.fa,
    this.fr,
    this.ja,
    this.ko,
    this.ptBr,
    this.ru,
    this.zhCn,
  });

  factory ContinentNames.fromJson(Map<String, dynamic> json) => ContinentNames(
    de: json["de"],
    en: json["en"],
    es: json["es"],
    fa: json["fa"],
    fr: json["fr"],
    ja: json["ja"],
    ko: json["ko"],
    ptBr: json["pt-BR"],
    ru: json["ru"],
    zhCn: json["zh-CN"],
  );

  Map<String, dynamic> toJson() => {
    "de": de,
    "en": en,
    "es": es,
    "fa": fa,
    "fr": fr,
    "ja": ja,
    "ko": ko,
    "pt-BR": ptBr,
    "ru": ru,
    "zh-CN": zhCn,
  };
}

class Country {
  int? geonameId;
  String? isoCode;
  ContinentNames? names;
  String? name;
  String? nameNative;
  String? phoneCode;
  String? capital;
  String? currency;
  String? flag;
  List<Language>? languages;

  Country({
    this.geonameId,
    this.isoCode,
    this.names,
    this.name,
    this.nameNative,
    this.phoneCode,
    this.capital,
    this.currency,
    this.flag,
    this.languages,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    geonameId: json["geoname_id"],
    isoCode: json["iso_code"],
    names: json["names"] == null
        ? null
        : ContinentNames.fromJson(json["names"]),
    name: json["name"],
    nameNative: json["name_native"],
    phoneCode: json["phone_code"],
    capital: json["capital"],
    currency: json["currency"],
    flag: json["flag"],
    languages: json["languages"] == null
        ? []
        : List<Language>.from(
        json["languages"]!.map((x) => Language.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "geoname_id": geonameId,
    "iso_code": isoCode,
    "names": names?.toJson(),
    "name": name,
    "name_native": nameNative,
    "phone_code": phoneCode,
    "capital": capital,
    "currency": currency,
    "flag": flag,
    "languages": languages == null
        ? []
        : List<dynamic>.from(languages!.map((x) => x.toJson())),
  };
}

class Language {
  String? isoCode;
  String? name;
  String? nameNative;

  Language({
    this.isoCode,
    this.name,
    this.nameNative,
  });

  factory Language.fromJson(Map<String, dynamic> json) => Language(
    isoCode: json["iso_code"],
    name: json["name"],
    nameNative: json["name_native"],
  );

  Map<String, dynamic> toJson() => {
    "iso_code": isoCode,
    "name": name,
    "name_native": nameNative,
  };
}

class Datasource {
  String? name;
  String? attribution;
  String? license;

  Datasource({
    this.name,
    this.attribution,
    this.license,
  });

  factory Datasource.fromJson(Map<String, dynamic> json) => Datasource(
    name: json["name"],
    attribution: json["attribution"],
    license: json["license"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "attribution": attribution,
    "license": license,
  };
}

class Location {
  double? latitude;
  double? longitude;

  Location({
    this.latitude,
    this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
  };
}

class State {
  String? name;

  State({
    this.name,
  });

  factory State.fromJson(Map<String, dynamic> json) => State(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}

class Subdivision {
  CityNames? names;

  Subdivision({
    this.names,
  });

  factory Subdivision.fromJson(Map<String, dynamic> json) => Subdivision(
    names: json["names"] == null ? null : CityNames.fromJson(json["names"]),
  );

  Map<String, dynamic> toJson() => {
    "names": names?.toJson(),
  };
}
