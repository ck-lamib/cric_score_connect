import 'dart:async';
import 'dart:collection';

import 'package:cric_score_connect/datasource/search/search_friend_repo.dart';
import 'package:cric_score_connect/models/user.dart';
import 'package:cric_score_connect/utils/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreenController extends GetxController {
  TextEditingController searchTextController = TextEditingController();
  var isSearching = false.obs;

  List<User> searchedUser = [];
  Timer? _debounce;
  onSearchFriend(String value) {
    isSearching.value = true;
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(
      const Duration(seconds: 1),
      () {
        SearchFriendRepo.searchFriend(
          query: value,
          onSuccess: (users) {
            searchedUser = users;
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
}
