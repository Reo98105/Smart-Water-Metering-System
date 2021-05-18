class Analytics {
  var price, waterUsage, dateTime;

  Analytics();

  Analytics.usage(this.waterUsage, this.dateTime);
  Analytics.price(this.price, this.dateTime);

  Analytics.def();
}