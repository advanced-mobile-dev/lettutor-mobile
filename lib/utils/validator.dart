String validateEmail(String email) {
  RegExp regExp = new RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (email.length == 0) {
    return "Email is required";
  }

  if (!regExp.hasMatch(email)) return "Email is invalid";
  return null;
}

String validatePassword(String password) {
  if (password.length == 0) return "Password is required";

  return null;
}
