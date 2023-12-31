abstract class IMessageService {
  void showSuccessSnackBar(String? title, String? message);

  void showErrorSnackBar(String? title, String? message);

  Future<dynamic>? showDecisionAlertDialog<T>({
    String? title,
    required String message,
    required String confirm,
    required String cancel,
    required Function() onConfirm,
    required Function() onCancel,
  });
}
