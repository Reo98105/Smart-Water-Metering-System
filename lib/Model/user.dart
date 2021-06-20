class User {
  String username, status;
  int nric, id;
  var email, password, password1, password2;

  User.id(this.username, this.id);
  User.login(this.id, this.username, this.password);
  User.up(this.id, this.password);
  User.cre(this.username);
  User.status(this.status, this.id);

  User(this.username, this.nric, this.password, this.email);

  User.def() {
    username = '';
    nric = null;
    password = '';
    email = '';
  }
}
