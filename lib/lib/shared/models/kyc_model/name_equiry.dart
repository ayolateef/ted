class NameEquiryModel {
  bool? requestSuccessful;
  String? responseData;
  String? message;
  String? responseCode;

  NameEquiryModel(
      {this.requestSuccessful,
        this.responseData,
        this.message,
        this.responseCode});

  NameEquiryModel.fromJson(Map<String, dynamic> json) {
    requestSuccessful = json['requestSuccessful'];
    responseData = json['responseData'];
    message = json['message'];
    responseCode = json['responseCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['requestSuccessful'] = requestSuccessful;
    data['responseData'] = responseData;
    data['message'] = message;
    data['responseCode'] = responseCode;
    return data;
  }
}