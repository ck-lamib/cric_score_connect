class AccessToken {
  String? accessToken;

  AccessToken({this.accessToken});

  AccessToken.fromJson(Map<String, dynamic> json) {
    accessToken = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = accessToken;
    return data;
  }

  @override
  String toString() {
    return "$accessToken";
  }
}
