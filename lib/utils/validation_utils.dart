class AppValidator {
  static String? userNameValidation(String? value) {
    if (value!.isEmpty) {
      return "Please enter user name";
    } else {
      return null;
    }
  }

  static String? passwordValidation(String? value) {
    if (value!.isEmpty) {
      return "Please enter password";
    } else {
      return null;
    }
  }

  static String? nameValidation(String? value) {
    if (value!.isEmpty) {
      return "Please enter name of task";
    } else {
      return null;
    }
  }

  static String? descriptionValidation(String? value) {
    if (value!.isEmpty) {
      return "Please enter description";
    } else {
      return null;
    }
  }

  static String? subTaskValidation(String? value) {
    if (value!.isEmpty) {
      return "Please enter sub task";
    } else {
      return null;
    }
  }
}
