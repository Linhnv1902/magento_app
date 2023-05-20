class StoreConfigResponseModel {
  int? id;
  String? code;
  int? websiteId;
  String? locale;
  String? baseCurrencyCode;
  String? defaultDisplayCurrencyCode;
  String? timezone;
  String? weightUnit;
  String? baseUrl;
  String? baseLinkUrl;
  String? baseStaticUrl;
  String? baseMediaUrl;
  String? secureBaseUrl;
  String? secureBaseLinkUrl;
  String? secureBaseStaticUrl;
  String? secureBaseMediaUrl;

  StoreConfigResponseModel(
      {this.id,
        this.code,
        this.websiteId,
        this.locale,
        this.baseCurrencyCode,
        this.defaultDisplayCurrencyCode,
        this.timezone,
        this.weightUnit,
        this.baseUrl,
        this.baseLinkUrl,
        this.baseStaticUrl,
        this.baseMediaUrl,
        this.secureBaseUrl,
        this.secureBaseLinkUrl,
        this.secureBaseStaticUrl,
        this.secureBaseMediaUrl});

  StoreConfigResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    websiteId = json['website_id'];
    locale = json['locale'];
    baseCurrencyCode = json['base_currency_code'];
    defaultDisplayCurrencyCode = json['default_display_currency_code'];
    timezone = json['timezone'];
    weightUnit = json['weight_unit'];
    baseUrl = json['base_url'];
    baseLinkUrl = json['base_link_url'];
    baseStaticUrl = json['base_static_url'];
    baseMediaUrl = json['base_media_url'];
    secureBaseUrl = json['secure_base_url'];
    secureBaseLinkUrl = json['secure_base_link_url'];
    secureBaseStaticUrl = json['secure_base_static_url'];
    secureBaseMediaUrl = json['secure_base_media_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['website_id'] = websiteId;
    data['locale'] = locale;
    data['base_currency_code'] = baseCurrencyCode;
    data['default_display_currency_code'] = defaultDisplayCurrencyCode;
    data['timezone'] = timezone;
    data['weight_unit'] = weightUnit;
    data['base_url'] = baseUrl;
    data['base_link_url'] = baseLinkUrl;
    data['base_static_url'] = baseStaticUrl;
    data['base_media_url'] = baseMediaUrl;
    data['secure_base_url'] = secureBaseUrl;
    data['secure_base_link_url'] = secureBaseLinkUrl;
    data['secure_base_static_url'] = secureBaseStaticUrl;
    data['secure_base_media_url'] = secureBaseMediaUrl;
    return data;
  }
}
