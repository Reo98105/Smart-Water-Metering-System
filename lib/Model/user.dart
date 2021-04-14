class User {
  String username;
  int nric;
  var email, password, password1, password2, id;

  User.id(this.username, this.id);
  User.login(this.id, this.username, this.password);
  User.up(this.id, this.password);
  User.cre(this.username);

  User(this.username, this.nric, this.password, this.email);

  User.def() {
    username = '';
    nric = null;
    password = '';
    email = '';
  }
}
