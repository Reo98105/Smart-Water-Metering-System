class Account {
  String accNumber, accNickname, password, address, district, city;
  var userid;
  int postCode;

  Account();

  Account.add(this.userid, this.accNumber, this.accNickname, this.password);
  Account.retrieve(this.userid);

  Account.def();
}
