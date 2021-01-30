class User{
  String username;
  int nric;
  var email, password;

  User(this.username,this.nric, this.password, this.email );

  User.def(){
    username = '';
    nric = null;
    password = '';
    email = '';
  }
}