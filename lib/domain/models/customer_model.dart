class CustomerModel {
  int? id;
  int? groupId;
  String? defaultBilling;
  String? defaultShipping;
  String? confirmation;
  String? createdAt;
  String? updatedAt;
  String? createdIn;
  String? dob;
  String? email;
  String? firstname;
  String? lastname;
  String? middlename;
  String? prefix;
  String? suffix;
  int? gender;
  int? storeId;
  String? taxvat;
  int? websiteId;
  List<Addresses>? addresses;
  int? disableAutoGroupChange;
  ExtensionAttributes? extensionAttributes;
  List<CustomAttributes>? customAttributes;

  CustomerModel({
    this.id,
    this.groupId,
    this.defaultBilling,
    this.defaultShipping,
    this.confirmation,
    this.createdAt,
    this.updatedAt,
    this.createdIn,
    this.dob,
    this.email,
    this.firstname,
    this.lastname,
    this.middlename,
    this.prefix,
    this.suffix,
    this.gender,
    this.storeId,
    this.taxvat,
    this.websiteId,
    this.addresses,
    this.disableAutoGroupChange,
    this.extensionAttributes,
    this.customAttributes,
  });

  CustomerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupId = json['group_id'];
    defaultBilling = json['default_billing'];
    defaultShipping = json['default_shipping'];
    confirmation = json['confirmation'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdIn = json['created_in'];
    dob = json['dob'];
    email = json['email'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    middlename = json['middlename'];
    prefix = json['prefix'];
    suffix = json['suffix'];
    gender = json['gender'];
    storeId = json['store_id'];
    taxvat = json['taxvat'];
    websiteId = json['website_id'];
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses!.add(Addresses.fromJson(v));
      });
    }
    disableAutoGroupChange = json['disable_auto_group_change'];
    extensionAttributes = json['extension_attributes'] != null
        ? ExtensionAttributes.fromJson(json['extension_attributes'])
        : null;
    if (json['custom_attributes'] != null) {
      customAttributes = <CustomAttributes>[];
      json['custom_attributes'].forEach((v) {
        customAttributes!.add(CustomAttributes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['group_id'] = groupId;
    data['default_billing'] = defaultBilling;
    data['default_shipping'] = defaultShipping;
    data['confirmation'] = confirmation;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['created_in'] = createdIn;
    data['dob'] = dob;
    data['email'] = email;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['middlename'] = middlename;
    data['prefix'] = prefix;
    data['suffix'] = suffix;
    data['gender'] = gender;
    data['store_id'] = storeId;
    data['taxvat'] = taxvat;
    data['website_id'] = websiteId;
    if (addresses != null) {
      data['addresses'] = addresses!.map((v) => v.toJson()).toList();
    }
    data['disable_auto_group_change'] = disableAutoGroupChange;
    if (extensionAttributes != null) {
      data['extension_attributes'] = extensionAttributes!.toJson();
    }
    if (customAttributes != null) {
      data['custom_attributes'] =
          customAttributes!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Map<String, dynamic> toUpdateCustomer() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['dob'] = dob;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['gender'] = gender;
    if (addresses != null) {
      data['addresses'] = addresses!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Map<String, dynamic> toUpdateAddress() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (addresses != null) {
      data['addresses'] = addresses!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  CustomerModel copyWith({
    int? groupId,
    String? defaultBilling,
    String? defaultShipping,
    String? confirmation,
    String? dob,
    String? email,
    String? firstname,
    String? lastname,
    String? prefix,
    String? suffix,
    int? gender,
    int? storeId,
    String? taxvat,
    List<Addresses>? addresses,
  }) =>
      CustomerModel(
          id: this.id,
          groupId: groupId ?? this.groupId,
          taxvat: taxvat ?? this.taxvat,
          defaultBilling: defaultBilling ?? this.defaultBilling,
          defaultShipping: defaultShipping ?? this.defaultShipping,
          confirmation: confirmation ?? this.confirmation,
          dob: dob ?? this.dob,
          email: email ?? this.email,
          firstname: firstname ?? this.firstname,
          lastname: lastname ?? this.lastname,
          middlename: this.middlename,
          prefix: this.prefix,
          suffix: this.suffix,
          gender: gender ?? this.gender,
          storeId: this.storeId,
          websiteId: this.websiteId,
          addresses: addresses ?? this.addresses,
          disableAutoGroupChange: this.disableAutoGroupChange,
          extensionAttributes: this.extensionAttributes,
          customAttributes: this.customAttributes);
}

class Addresses {
  int? id;
  int? customerId;
  Region? region;
  int? regionId;
  String? countryId;
  List<String>? street;
  String? company;
  String? telephone;
  String? fax;
  String? postcode;
  String? city;
  String? firstname;
  String? lastname;
  String? middlename;
  String? prefix;
  String? suffix;
  String? vatId;
  bool? defaultShipping;
  bool? defaultBilling;
  ExtensionAttributes? extensionAttributes;
  List<CustomAttributes>? customAttributes;

  Addresses(
      {this.id,
      this.customerId,
      this.region,
      this.regionId,
      this.countryId,
      this.street,
      this.company,
      this.telephone,
      this.fax,
      this.postcode,
      this.city,
      this.firstname,
      this.lastname,
      this.middlename,
      this.prefix,
      this.suffix,
      this.vatId,
      this.defaultShipping,
      this.defaultBilling,
      this.extensionAttributes,
      this.customAttributes});

  Addresses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    region = json['region'] != null ? Region.fromJson(json['region']) : null;
    regionId = json['region_id'];
    countryId = json['country_id'];
    street = json['street'].cast<String>();
    company = json['company'];
    telephone = json['telephone'];
    fax = json['fax'];
    postcode = json['postcode'];
    city = json['city'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    middlename = json['middlename'];
    prefix = json['prefix'];
    suffix = json['suffix'];
    vatId = json['vat_id'];
    defaultShipping = json['default_shipping'];
    defaultBilling = json['default_billing'];
    extensionAttributes = json['extension_attributes'] != null
        ? ExtensionAttributes.fromJson(json['extension_attributes'])
        : null;
    if (json['custom_attributes'] != null) {
      customAttributes = <CustomAttributes>[];
      json['custom_attributes'].forEach((v) {
        customAttributes!.add(CustomAttributes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customer_id'] = customerId;
    if (region != null) {
      data['region'] = region!.toJson();
    }
    data['region_id'] = regionId;
    data['country_id'] = countryId;
    data['street'] = street;
    data['company'] = company;
    data['telephone'] = telephone;
    data['fax'] = fax;
    data['postcode'] = postcode;
    data['city'] = city;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['middlename'] = middlename;
    data['prefix'] = prefix;
    data['suffix'] = suffix;
    data['vat_id'] = vatId;
    data['default_shipping'] = defaultShipping;
    data['default_billing'] = defaultBilling;
    if (extensionAttributes != null) {
      data['extension_attributes'] = extensionAttributes!.toJson();
    }
    if (customAttributes != null) {
      data['custom_attributes'] =
          customAttributes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Region {
  String? regionCode;
  String? region;
  int? regionId;
  ExtensionAttributes? extensionAttributes;

  Region(
      {this.regionCode, this.region, this.regionId, this.extensionAttributes});

  Region.fromJson(Map<String, dynamic> json) {
    regionCode = json['region_code'];
    region = json['region'];
    regionId = json['region_id'];
    extensionAttributes = json['extension_attributes'] != null
        ? ExtensionAttributes.fromJson(json['extension_attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['region_code'] = regionCode;
    data['region'] = region;
    data['region_id'] = regionId;
    if (extensionAttributes != null) {
      data['extension_attributes'] = extensionAttributes!.toJson();
    }
    return data;
  }
}

class CustomAttributes {
  String? attributeCode;
  String? value;

  CustomAttributes({this.attributeCode, this.value});

  CustomAttributes.fromJson(Map<String, dynamic> json) {
    attributeCode = json['attribute_code'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attribute_code'] = attributeCode;
    data['value'] = value;
    return data;
  }
}

class ExtensionAttributes {
  CompanyAttributes? companyAttributes;
  int? assistanceAllowed;
  bool? isSubscribed;

  ExtensionAttributes(
      {this.companyAttributes, this.assistanceAllowed, this.isSubscribed});

  ExtensionAttributes.fromJson(Map<String, dynamic> json) {
    companyAttributes = json['company_attributes'] != null
        ? CompanyAttributes.fromJson(json['company_attributes'])
        : null;
    assistanceAllowed = json['assistance_allowed'];
    isSubscribed = json['is_subscribed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (companyAttributes != null) {
      data['company_attributes'] = companyAttributes!.toJson();
    }
    data['assistance_allowed'] = assistanceAllowed;
    data['is_subscribed'] = isSubscribed;
    return data;
  }
}

class CompanyAttributes {
  int? customerId;
  int? companyId;
  String? jobTitle;
  int? status;
  String? telephone;
  ExtensionAttributes? extensionAttributes;

  CompanyAttributes(
      {this.customerId,
      this.companyId,
      this.jobTitle,
      this.status,
      this.telephone,
      this.extensionAttributes});

  CompanyAttributes.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    companyId = json['company_id'];
    jobTitle = json['job_title'];
    status = json['status'];
    telephone = json['telephone'];
    extensionAttributes = json['extension_attributes'] != null
        ? ExtensionAttributes.fromJson(json['extension_attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customer_id'] = customerId;
    data['company_id'] = companyId;
    data['job_title'] = jobTitle;
    data['status'] = status;
    data['telephone'] = telephone;
    if (extensionAttributes != null) {
      data['extension_attributes'] = extensionAttributes!.toJson();
    }
    return data;
  }
}
