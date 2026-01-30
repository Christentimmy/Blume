class UserModel {
  final String? id;
  final String? fullName;
  final String? email;
  final String? phoneNumber;
  final String? avatar;
  final String? education;
  String? bio;
  final Basics? basics;

  final bool? showGender;
  final String? gender;
  final String? interestedIn;
  final String? dateOfBirth;
  final String? location;
  final List<String>? photos;
  final Preference? preference;
  final Subscription? subscription;
  final String? plan;
  final Boost? boost;
  final bool? isVerified;
  final String? oneSignalId;

  UserModel({
    this.id,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.avatar,
    this.education,
    this.bio,
    this.basics,
    this.showGender,
    this.gender,
    this.interestedIn,
    this.dateOfBirth,
    this.location,
    this.photos,
    this.preference,
    this.subscription,
    this.plan,
    this.boost,
    this.isVerified,
    this.oneSignalId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? "",
      fullName: json['full_name'] ?? "",
      email: json['email'] ?? "",
      phoneNumber: json['phone_number'] ?? "",
      avatar: json['avatar'] ?? "",
      education: json['education'] ?? "",
      bio: json['bio'] ?? "",
      basics: Basics.fromJson(json['basics'] ?? {}),
      showGender: json['showGender'] ?? false,
      gender: json['gender'] ?? "",
      interestedIn: json['relationship_preference'] ?? "",
      dateOfBirth: json['date_of_birth'] ?? "",
      location: json['location']?["address"] ?? "",
      photos: json['photos'] != null
          ? (json["photos"] as List).map((e) => e.toString()).toList()
          : [],
      preference: json["preferences"] != null
          ? Preference.fromJson(json['preferences'])
          : Preference(),
      subscription: Subscription.fromJson(json['subscription'] ?? {}),
      plan: json['plan'] ?? "",
      boost: json['boost'] != null ? Boost.fromMap(json['boost']) : Boost(),
      isVerified: json['isVerified'] ?? "",
      oneSignalId:  json['one_signal_id'] ?? "",
    );
  }
}

class Basics {
  final String? smoking;
  final String? drinking;
  final String? workout;
  final String? religion;
  final String? education;
  final String? height;
  final String? sexOrientation;
  final List<String>? languages;

  final List<String>? lifestyleAndValues;
  final List<String>? hobbies;
  final List<String>? artsAndCreativity;
  final List<String>? sportsAndFitness;
  final List<String>? travelAndAdventure;
  final List<String>? entertainment;
  final List<String>? music;
  final List<String>? foodAndDrink;

  Basics({
    this.smoking,
    this.drinking,
    this.workout,
    this.religion,
    this.education,
    this.height,
    this.sexOrientation,
    this.languages,
    this.lifestyleAndValues,
    this.hobbies,
    this.artsAndCreativity,
    this.sportsAndFitness,
    this.travelAndAdventure,
    this.entertainment,
    this.music,
    this.foodAndDrink,
  });

  factory Basics.fromJson(Map<String, dynamic> json) {
    return Basics(
      smoking: json['smoking'] ?? "",
      drinking: json['drinking'] ?? "",
      workout: json['workout'] ?? "",
      religion: json['religion'] ?? "",
      education: json['education'] ?? "",
      height: json['height'] ?? "",
      sexOrientation: json['sexOrientation'] ?? "",
      languages: json['languages'] != null
          ? (json['languages'] as List).map((e) => e.toString()).toList()
          : [],
      lifestyleAndValues: json['lifestyleAndValues'] != null
          ? (json['lifestyleAndValues'] as List)
                .map((e) => e.toString())
                .toList()
          : [],
      hobbies: json['hobbies'] != null
          ? (json['hobbies'] as List).map((e) => e.toString()).toList()
          : [],
      artsAndCreativity: json['artsAndCreativity'] != null
          ? (json['artsAndCreativity'] as List)
                .map((e) => e.toString())
                .toList()
          : [],
      sportsAndFitness: json['sportsAndFitness'] != null
          ? (json['sportsAndFitness'] as List).map((e) => e.toString()).toList()
          : [],
      travelAndAdventure: json['travelAndAdventure'] != null
          ? (json['travelAndAdventure'] as List)
                .map((e) => e.toString())
                .toList()
          : [],
      entertainment: json['entertainment'] != null
          ? (json['entertainment'] as List).map((e) => e.toString()).toList()
          : [],
      music: json['music'] != null
          ? (json['music'] as List).map((e) => e.toString()).toList()
          : [],
      foodAndDrink: json['foodAndDrink'] != null
          ? (json['foodAndDrink'] as List).map((e) => e.toString()).toList()
          : [],
    );
  }
}

class Preference {
  final num? minAge;
  final num? maxAge;
  final num? maxDistance;

  Preference({this.minAge, this.maxAge, this.maxDistance});

  factory Preference.fromJson(Map<String, dynamic> json) {
    return Preference(
      minAge: num.tryParse(json['ageRange'][0].toString()) ?? 0,
      maxAge: num.tryParse(json['ageRange'][1].toString()) ?? 0,
      maxDistance: num.tryParse(json['maxDistance'].toString()) ?? 0.0,
    );
  }
}

class Subscription {
  final String? planId;
  final String? status;
  final DateTime? currentPeriodEnd;
  final bool? cancelAtPeriodEnd;

  Subscription({
    this.planId,
    this.status,
    this.currentPeriodEnd,
    this.cancelAtPeriodEnd,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      planId: json['planId'] ?? "",
      status: json['status'] ?? "",
      currentPeriodEnd:
          DateTime.tryParse(json['currentPeriodEnd'].toString()) ??
          DateTime.now(),
      cancelAtPeriodEnd: json['cancelAtPeriodEnd'] ?? false,
    );
  }
}

class Boost {
  final bool? isActive;
  final DateTime? expiresAt;
  final String? boostType;
  final num? boostMultiplier;

  Boost({this.isActive, this.expiresAt, this.boostType, this.boostMultiplier});

  factory Boost.fromMap(Map<String, dynamic> json){
    return Boost(
      isActive: json['isActive'] ?? false,
      expiresAt: DateTime.tryParse(json['expiresAt'].toString()) ?? DateTime.now(),
      boostType: json['boostType'] ?? "",
      boostMultiplier: num.tryParse(json['boostMultiplier'].toString()) ?? 0,
    );
  }
}
