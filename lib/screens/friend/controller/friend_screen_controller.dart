import 'dart:async';

import 'package:cric_score_connect/core/core_controller.dart';
import 'package:cric_score_connect/datasource/friend/friends_repo.dart';
import 'package:cric_score_connect/models/friend_request_user.dart';
import 'package:cric_score_connect/models/user.dart';
import 'package:cric_score_connect/utils/custom_snackbar.dart';
import 'package:cric_score_connect/utils/helpers/request_loader.dart';
import 'package:get/get.dart';

class FriendScreenController extends GetxController {
  @override
  onInit() {
    getAllAcceptedFriend();
    getFriendRequest();
    super.onInit();
  }

  RxList<FriendRequestUser> pendingFriendRequestUser = RxList();
  RxList<FriendRequestUser> finalPendingFriendRequestUser = RxList();

  var isPendingFriendLoading = false.obs;
  getFriendRequest() async {
    CoreController cc = Get.find<CoreController>();
    int receiverId = cc.currentUser.value!.id!;
    isPendingFriendLoading.value = true;

    await FriendRepo.getAllFriendRequestUser(
      receiverId: receiverId,
      onSuccess: (users) async {
        isPendingFriendLoading.value = false;
        pendingFriendRequestUser.value = users;
        finalPendingFriendRequestUser.value = users;
      },
      onError: (message) {
        CustomSnackBar.error(title: "Search friend", message: message);
        isPendingFriendLoading.value = false;
      },
    );
  }

  Timer? _debounce;
  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  searchPendingFriends(String query) {
    isPendingFriendLoading.value = true;
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(
      const Duration(seconds: 1),
      () {
        List<FriendRequestUser> friendList = [];
        if (query.isNotEmpty) {
          for (var item in pendingFriendRequestUser) {
            var containsItem = item.senderUsername
                ?.toLowerCase()
                .contains(query.toLowerCase());
            if (containsItem ?? false) {
              friendList.add(item);
            }
          }
          finalPendingFriendRequestUser.value = friendList;
          isPendingFriendLoading.value = false;
        } else {
          finalPendingFriendRequestUser.value = pendingFriendRequestUser.value;
          isPendingFriendLoading.value = false;
        }
      },
    );
  }

  rejectFriendRequest(int id) async {
    RequestLoader requestLoader = RequestLoader();
    requestLoader.show();
    await FriendRepo.rejectRequest(
      requestId: id,
      onSuccess: (message) async {
        CustomSnackBar.success(title: "Reject request", message: message);
        pendingFriendRequestUser.removeWhere((element) => element.id == id);
        finalPendingFriendRequestUser
            .removeWhere((element) => element.id == id);
        pendingFriendRequestUser.refresh();
        finalPendingFriendRequestUser.refresh();
        requestLoader.hide();
      },
      onError: (message) {
        CustomSnackBar.error(title: "Reject request", message: message);
        requestLoader.hide();
      },
    );
  }

  confirmFriendRequest(int id) async {
    RequestLoader requestLoader = RequestLoader();
    requestLoader.show();
    await FriendRepo.rejectRequest(
      requestId: id,
      onSuccess: (message) async {
        CustomSnackBar.success(title: "Confirm request", message: message);
        pendingFriendRequestUser.removeWhere((element) => element.id == id);
        finalPendingFriendRequestUser
            .removeWhere((element) => element.id == id);
        pendingFriendRequestUser.refresh();
        finalPendingFriendRequestUser.refresh();
        requestLoader.hide();
      },
      onError: (message) {
        CustomSnackBar.error(title: "Reject request", message: message);
        requestLoader.hide();
      },
    );
  }

  var isGetAllFriendLoading = false.obs;
  RxList<User> friendList = RxList();
  getAllAcceptedFriend() async {
    isGetAllFriendLoading.value = true;
    CoreController cc = Get.find<CoreController>();
    int userId = cc.currentUser.value!.id!;

    await FriendRepo.getAllFriend(
      userId: userId,
      onSuccess: (users) async {
        friendList.value = users;
        isGetAllFriendLoading.value = false;
      },
      onError: (message) {
        CustomSnackBar.error(title: "Get Friends", message: message);
        isGetAllFriendLoading.value = false;
      },
    );
  }
}
