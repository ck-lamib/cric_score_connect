class Api {
  static const baseUrl = "https://khatri-bibek.com.np/api";
  // static const baseUrl = "https://5029-45-64-163-50.ngrok-free.app/api";

  static const loginUrl = "$baseUrl/login";
  static const signupUrl = "$baseUrl/register";
  static const forgetPasswordUrl = "$baseUrl/forgotPassword";

  static const searchUrl = "$baseUrl/users/search";

  static getUserStatUrl(String userId) => "$baseUrl/user/$userId/stats";

  static editProfileUrl(int id) => "$baseUrl/users/$id";
  static const friendRequestUrl = "$baseUrl/friend-requests";
  static const pendingRequestUrl = "$baseUrl/friend-requests/pending";
  static rejectFriendRequestUrl(int id) =>
      "$baseUrl/friend-requests/$id/reject";
  static confirmFriendRequestUrl(int id) =>
      "$baseUrl/friend-requests/$id/confirm";

  static getAllFriendUrl(int id) => "$baseUrl/users/$id/friends";
}
