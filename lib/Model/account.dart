class Account {
  String accNumber, accNickname, password;
  var userid;
  List accList;

  Account();

  Account.add(this.userid, this.accNumber, this.accNickname, this.password);
  Account.retrieve(this.userid);
  Account.list(this.accList);

  Account.def();
}
