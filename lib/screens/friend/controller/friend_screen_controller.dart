import 'package:cric_score_connect/core/core_controller.dart';
import 'package:cric_score_connect/datasource/friend/friends_repo.dart';
import 'package:cric_score_connect/models/friend_request_user.dart';
import 'package:cric_score_connect/utils/custom_snackbar.dart';
import 'package:get/get.dart';

class FriendScreenController extends GetxController {
  @override
  onInit() {
    //
    getFriendRequest();
    super.onInit();
  }

  RxList<FriendRequestUser> friendRequestUser = RxList();

  var isPendingFriendLoading = false.obs;
  getFriendRequest() async {
    CoreController cc = Get.find<CoreController>();
    int receiverId = cc.currentUser.value!.id!;
    isPendingFriendLoading.value = true;

    await FriendRepo.getAllFriendRequestUser(
      receiverId: receiverId,
      onSuccess: (users) async {
        isPendingFriendLoading.value = false;
        friendRequestUser.value = users;
      },
      onError: (message) {
        CustomSnackBar.error(title: "Search friend", message: message);
        isPendingFriendLoading.value = false;
      },
    );
  }
}
