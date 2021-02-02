class User {
  String username;
  int nric;
  var email, password, password1, password2;

  User.login(this.username, this.password);
  User.cre(this.username);
  User.update(this.username, this.password, this.password1, this.password2);

  User(this.username, this.nric, this.password, this.email);

  User.def() {
    username = '';
    nric = null;
    password = '';
    email = '';
  }
}
