class DlvyBusinessOverviewData {
  String? status;
  DriverHomeData? data;

  DlvyBusinessOverviewData({this.status, this.data});

  DlvyBusinessOverviewData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data =
        json['data'] != null ? new DriverHomeData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DriverHomeData {
  Revenue? revenue;
  int? acceptedCount;
  int? completedCount;
  int? cancelledCount;
  int? all;

  DriverHomeData(
      {this.revenue,
      this.acceptedCount,
      this.completedCount,
      this.cancelledCount,
      this.all});

  DriverHomeData.fromJson(Map<String, dynamic> json) {
    revenue =
        json['revenue'] != null ? new Revenue.fromJson(json['revenue']) : null;
    acceptedCount = json['accepted_count'];
    completedCount = json['completed_count'];
    cancelledCount = json['cancelled_count'];
    all = json['all'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.revenue != null) {
      data['revenue'] = this.revenue!.toJson();
    }
    data['accepted_count'] = this.acceptedCount;
    data['completed_count'] = this.completedCount;
    data['cancelled_count'] = this.cancelledCount;
    data['all'] = this.all;
    return data;
  }
}

class Revenue {
  int? amount;
  String? currency;

  Revenue({this.amount, this.currency});

  Revenue.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    return data;
  }
}
