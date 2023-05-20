class SearchCriteria {
  List<FilterGroups>? filterGroups;
  List<SortOrders>? sortOrders;
  int? pageSize;
  int? currentPage;

  SearchCriteria({this.filterGroups, this.pageSize, this.currentPage});

  SearchCriteria.fromJson(Map<String, dynamic> json) {
    if (json['filter_groups'] != null) {
      filterGroups = <FilterGroups>[];
      json['filter_groups'].forEach((v) {
        filterGroups!.add(FilterGroups.fromJson(v));
      });
    }
    if (json['sort_orders'] != null) {
      sortOrders = <SortOrders>[];
      json['sort_orders'].forEach((v) {
        sortOrders!.add(SortOrders.fromJson(v));
      });
    }
    pageSize = json['page_size'];
    currentPage = json['current_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (filterGroups != null) {
      data['filter_groups'] = filterGroups!.map((v) => v.toJson()).toList();
    }
    if (sortOrders != null) {
      data['sort_orders'] = sortOrders!.map((v) => v.toJson()).toList();
    }
    data['page_size'] = pageSize;
    data['current_page'] = currentPage;
    return data;
  }
}

class FilterGroups {
  List<Filters>? filters;

  FilterGroups({this.filters});

  FilterGroups.fromJson(Map<String, dynamic> json) {
    if (json['filters'] != null) {
      filters = <Filters>[];
      json['filters'].forEach((v) {
        filters!.add(Filters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (filters != null) {
      data['filters'] = filters!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Filters {
  String? field;
  String? value;
  String? conditionType;

  Filters({this.field, this.value, this.conditionType});

  Filters.fromJson(Map<String, dynamic> json) {
    field = json['field'];
    value = json['value'];
    conditionType = json['condition_type'];
  }

  Map<String, dynamic> toJson({int index1 = 0, int index2 = 0}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['searchCriteria[filter_groups][$index1][filters][$index2][field]'] =
        field;
    data['searchCriteria[filter_groups][$index1][filters][$index2][value]'] =
        value;
    data['searchCriteria[filter_groups][$index1][filters][$index2][condition_type]'] =
        conditionType;
    return data;
  }
}

class SortOrders {
  String? field;
  String? direction;

  SortOrders({this.field, this.direction});

  SortOrders.fromJson(Map<String, dynamic> json) {
    field = json['field'];
    direction = json['direction'];
  }

  Map<String, dynamic> toJson({int index = 0}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['searchCriteria[sortOrders][$index][field]'] = field;
    data['searchCriteria[sortOrders][$index][direction]'] = direction;
    return data;
  }
}
