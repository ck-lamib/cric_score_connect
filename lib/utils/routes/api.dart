class Api {
  static const baseUrl = "https://khatri-bibek.com.np/api";
  // static const baseUrl = "https://5029-45-64-163-50.ngrok-free.app/api";

  static const loginUrl = "$baseUrl/login";
  static const signupUrl = "$baseUrl/register";
  static const forgetPasswordUrl = "$baseUrl/forgotPassword";

  static const searchUrl = "$baseUrl/users/search";

  static getUserStatUrl(int userId) => "$baseUrl/user/stats/$userId";

  static editProfileUrl(int id) => "$baseUrl/users/$id/edit";
  static const friendRequestUrl = "$baseUrl/friend-requests";
  static const pendingRequestUrl = "$baseUrl/friend-requests/pending";
  static rejectFriendRequestUrl(int id) =>
      "$baseUrl/friend-requests/$id/reject";
  static confirmFriendRequestUrl(int id) =>
      "$baseUrl/friend-requests/$id/confirm";

  static getAllFriendUrl(int id) => "$baseUrl/users/$id/friends";

  static const storeMatchUrl = "$baseUrl/match/store";
  static const fetchLiveMatchUrl = "$baseUrl/join-live-games";
  static const updateGameDataUrl = "$baseUrl/update-game-data";
  static const payementStoreUrl = "$baseUrl/payment-store";
  static const getPaidMatchHistoryUrl = "$baseUrl/send-all-paid-matches-data";
  static const getUnPaidMatchHistoryUrl = "$baseUrl/send-all-user-matches-data";
  static const getMatchHistoryDetail = "$baseUrl/games-data";
  // static const getMatchHistoryUrl = "$baseUrl/payment-store";
  static getUserMatchSummary(int userId) => "$baseUrl/user/$userId/summary";
}
