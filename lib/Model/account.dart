class Account {
  String accNumber, accNickname, password, address, district, city;
  var userid;
  int postCode;

  Account();

  Account.add(this.userid, this.accNumber, this.accNickname, this.password);
  Account.update(this.userid, this.accNickname, this.password, this.accNumber);
  Account.retrieve(this.userid);

  Account.def();
}
