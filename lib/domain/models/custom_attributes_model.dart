class CustomAttributes {
  String? attributeCode;
  dynamic? value;

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
