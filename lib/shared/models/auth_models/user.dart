

class User {
  String? sId;
  String? name;
  String? email;
  String? password;
  bool? isKYCVerified;
  bool? onboardingComplete;
  OnBoardingSteps? onboardingStep;
  String? createdAt;
  String? updatedAt;
  int? iV;

  User({
    this.sId,
    this.name,
    this.email,
    this.password,
    this.isKYCVerified,
    this.onboardingComplete,
    this.onboardingStep,
    this.createdAt,
    this.updatedAt,
    this.iV

  });

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    isKYCVerified = json['isKYCVerified'];
    onboardingComplete = json['onboardingComplete'];
    onboardingStep = OnBoardingSteps.values.firstWhere((element) =>
  element.onBoarding == json['onboardingStep'],
  orElse: () => OnBoardingSteps.createPin
  );
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['isKYCVerified'] = isKYCVerified;
    data['onboardingComplete'] = onboardingComplete;
    data['onboardingStep'] = onboardingStep;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;

    return data;
  }

}

enum OnBoardingSteps{
  createPin,username,dashboard
}
extension OnBoardingStepsExt on OnBoardingSteps {
  int get onBoarding {
    switch (this) {
      case OnBoardingSteps.createPin:
        return 1;
      case OnBoardingSteps.username:
        return 2;
      case OnBoardingSteps.dashboard:
        return 3;
      default:
        return -1;
    }
  }

  static OnBoardingSteps fromJson(int value) {
    switch (value) {
      case 1:
        return OnBoardingSteps.createPin;
      case 2:
        return OnBoardingSteps.username;
      case 3:
        return OnBoardingSteps.dashboard;
      default:
        throw Exception('Invalid value');
    }
  }
}






class UserTemp {
  String? pin;
  String? username;

  UserTemp({this.pin, this.username});
}
