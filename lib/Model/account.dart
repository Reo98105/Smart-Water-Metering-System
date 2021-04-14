class Account {
  String accNumber, accNickname, password;
  var userid;

  Account();

  Account.add(this.userid, this.accNumber, this.accNickname, this.password);
  Account.retrieve(this.userid);

  Account.def();
}
