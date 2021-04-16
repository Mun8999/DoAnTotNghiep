class Validation {
  static String validateUsername(String username) {
    if (username.isEmpty || username.length < 6)
      return "Tên đăng nhập không hợp lệ (tối thiểu 6 ký tự)";
    else
      return null;
  }

  static String validatePassword(String pass) {
    if (pass.isEmpty || pass.length < 6)
      return "Mật khẩu tối thiểu 6 ký tự";
    else
      return null;
  }
}
