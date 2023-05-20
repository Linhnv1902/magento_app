class ReviewModel {
  int? id;
  String? title;
  String? detail;
  String? nickname;
  List<Ratings>? ratings;
  String? reviewEntity;
  int? reviewType;
  int? reviewStatus;
  String? createdAt;
  int? entityPkValue;
  int? storeId;
  List<int?>? stores;

  ReviewModel(
      {this.id,
      this.title,
      this.detail,
      this.nickname,
      this.ratings,
      this.reviewEntity,
      this.reviewType,
      this.reviewStatus,
      this.createdAt,
      this.entityPkValue,
      this.storeId,
      this.stores});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    detail = json['detail'];
    nickname = json['nickname'];
    if (json['ratings'] != null) {
      ratings = <Ratings>[];
      json['ratings'].forEach((v) {
        ratings!.add(Ratings.fromJson(v));
      });
    }
    reviewEntity = json['review_entity'];
    reviewType = json['review_type'];
    reviewStatus = json['review_status'];
    createdAt = json['created_at'];
    entityPkValue = json['entity_pk_value'];
    storeId = json['store_id'];
    stores = json['stores'].cast<int?>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['detail'] = detail;
    data['nickname'] = nickname;
    if (ratings != null) {
      data['ratings'] = ratings!.map((v) => v.toJson()).toList();
    }
    data['review_entity'] = reviewEntity;
    data['review_type'] = reviewType;
    data['review_status'] = reviewStatus;
    data['created_at'] = createdAt;
    data['entity_pk_value'] = entityPkValue;
    data['store_id'] = storeId;
    data['stores'] = stores;
    return data;
  }
}

class Ratings {
  int? voteId;
  int? ratingId;
  String? ratingName;
  int? percent;
  int? value;

  Ratings(
      {this.voteId, this.ratingId, this.ratingName, this.percent, this.value});

  Ratings.fromJson(Map<String, dynamic> json) {
    voteId = json['vote_id'];
    ratingId = json['rating_id'];
    ratingName = json['rating_name'];
    percent = json['percent'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vote_id'] = voteId;
    data['rating_id'] = ratingId;
    data['rating_name'] = ratingName;
    data['percent'] = percent;
    data['value'] = value;
    return data;
  }
}
