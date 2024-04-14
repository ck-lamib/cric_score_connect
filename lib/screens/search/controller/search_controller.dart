import 'dart:async';

import 'package:cric_score_connect/core/core_controller.dart';
import 'package:cric_score_connect/datasource/friend/friends_repo.dart';
import 'package:cric_score_connect/datasource/search/search_friend_repo.dart';
import 'package:cric_score_connect/models/user.dart';
import 'package:cric_score_connect/utils/custom_snackbar.dart';
import 'package:cric_score_connect/utils/helpers/request_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreenController extends GetxController {
  TextEditingController searchTextController = TextEditingController();
  var isSearching = false.obs;

  RxList searchedUser = [].obs;
  Timer? _debounce;
  onSearchFriend(String value) {
    CoreController cc = Get.find<CoreController>();
    isSearching.value = true;
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(
      const Duration(seconds: 1),
      () {
        SearchFriendRepo.searchFriend(
          query: value,
          id: cc.currentUser.value!.id!.toString(),
          onSuccess: (users) {
            searchedUser.value = users;
            isSearching.value = false;
          },
          onError: (message) {
            CustomSnackBar.error(title: "Search friend", message: message);
            isSearching.value = false;
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  addFriend(User user) async {
    RequestLoader requestLoader = RequestLoader();
    CoreController cc = Get.find<CoreController>();
    int senderId = cc.currentUser.value!.id!;

    requestLoader.show();
    await FriendRepo.friendRequest(
      receiverId: user.id!,
      senderId: senderId,
      onSuccess: (message) async {
        searchedUser.removeWhere((element) => element.id == user.id);
        searchedUser.refresh();
        requestLoader.hide();
        CustomSnackBar.success(
            title: "Friend Request",
            message: "Friend request sent successfull");
      },
      onError: (message) {
        requestLoader.hide();
        CustomSnackBar.success(title: "Friend Request", message: message);
      },
    );
  }
}
