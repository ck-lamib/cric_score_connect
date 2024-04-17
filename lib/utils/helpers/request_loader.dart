import 'package:cric_score_connect/utils/constants/colors.dart';
import 'package:get/get.dart';

import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class RequestLoader {
  late SimpleFontelicoProgressDialog loading;
  RequestLoader() {
    loading = SimpleFontelicoProgressDialog(
      context: Get.context!,
      barrierDimisable: false,
    );
  }

  show({
    String message = "Please wait ...",
  }) {
    return loading.show(
      message: message,
      type: SimpleFontelicoProgressDialogType.multiHurricane,
      horizontal: true,
      width: 200.0,
      height: 100.0,
      hideText: false,
      indicatorColor: AppColors.backGroundColor,
      elevation: 10,
    );
  }

  hide() {
    return loading.hide();
  }
}
