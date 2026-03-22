
/// ABHA Profile model representing the user's national health ID profile
/// This data is fetched from the NHA (National Health Authority) API
class ABHAProfile {
  final String healthId;
  final String? healthIdNumber;
  final String? name;
  final String? gender;
  final DateTime? dateOfBirth;
  final String? email;
  final String? phone;
  final String? address;
  final String? state;
  final String? district;
  final String? pincode;
  final bool isVerified;
  final DateTime? lastSyncedAt;

  const ABHAProfile({
    required this.healthId,
    this.healthIdNumber,
    this.name,
    this.gender,
    this.dateOfBirth,
    this.email,
    this.phone,
    this.address,
    this.state,
    this.district,
    this.pincode,
    this.isVerified = false,
    this.lastSyncedAt,
  });

  /// Create from NHA API response
  factory ABHAProfile.fromJson(Map<String, dynamic> json) {
    return ABHAProfile(
      healthId:
          json['healthId'] as String? ?? json['healthId'] as String? ?? '',
      healthIdNumber: json['healthIdNumber'] as String?,
      name: json['name'] as String?,
      gender: json['gender'] as String?,
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.tryParse(json['dateOfBirth'] as String)
          : null,
      email: json['email'] as String?,
      phone: json['mobile'] as String? ?? json['phone'] as String?,
      address: json['address'] as String?,
      state: json['state'] as String?,
      district: json['district'] as String?,
      pincode: json['pincode'] as String?,
      isVerified:
          json['verified'] as bool? ?? json['isVerified'] as bool? ?? false,
      lastSyncedAt: DateTime.now(),
    );
  }

  /// Convert to JSON for local storage (excluding sensitive data)
  Map<String, dynamic> toJson() => {
    'healthId': healthId,
    'healthIdNumber': healthIdNumber,
    'name': name,
    'gender': gender,
    'dateOfBirth': dateOfBirth?.toIso8601String(),
    'email': email,
    'phone': phone,
    'address': address,
    'state': state,
    'district': district,
    'pincode': pincode,
    'isVerified': isVerified,
    'lastSyncedAt': lastSyncedAt?.toIso8601String(),
  };

  /// Create a copy with updated fields
  ABHAProfile copyWith({
    String? healthId,
    String? healthIdNumber,
    String? name,
    String? gender,
    DateTime? dateOfBirth,
    String? email,
    String? phone,
    String? address,
    String? state,
    String? district,
    String? pincode,
    bool? isVerified,
    DateTime? lastSyncedAt,
  }) {
    return ABHAProfile(
      healthId: healthId ?? this.healthId,
      healthIdNumber: healthIdNumber ?? this.healthIdNumber,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      state: state ?? this.state,
      district: district ?? this.district,
      pincode: pincode ?? this.pincode,
      isVerified: isVerified ?? this.isVerified,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
    );
  }

  /// Get masked ABHA number for display
  String get maskedHealthId {
    if (healthIdNumber == null || healthIdNumber!.length < 4) return healthId;
    final last4 = healthIdNumber!.substring(healthIdNumber!.length - 4);
    return 'XXXX-XXXX-$last4';
  }

  /// Get display name
  String get displayName => name ?? healthId;

  @override
  String toString() =>
      'ABHAProfile(healthId: $healthId, name: $name, isVerified: $isVerified)';
}

/// ABHA OAuth token response
class ABHATokenResponse {
  final String accessToken;
  final String? refreshToken;
  final DateTime expiresAt;
  final String? tokenType;
  final String? patientId;

  const ABHATokenResponse({
    required this.accessToken,
    this.refreshToken,
    required this.expiresAt,
    this.tokenType = 'Bearer',
    this.patientId,
  });

  factory ABHATokenResponse.fromJson(Map<String, dynamic> json) {
    final expiresIn = json['expires_in'] as int? ?? 3600;
    return ABHATokenResponse(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String?,
      expiresAt: DateTime.now().add(Duration(seconds: expiresIn)),
      tokenType: json['token_type'] as String? ?? 'Bearer',
      patientId: json['patientId'] as String?,
    );
  }

  bool get isExpired => DateTime.now().isAfter(expiresAt);

  Map<String, dynamic> toJson() => {
    'access_token': accessToken,
    'refresh_token': refreshToken,
    'expires_in': expiresAt.difference(DateTime.now()).inSeconds,
    'token_type': tokenType,
    'patientId': patientId,
  };
}
