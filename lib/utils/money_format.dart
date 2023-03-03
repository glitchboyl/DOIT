String moneyFormat(double money) {
  List<String> expansion = (money * 100).toInt().toString().split('');
  String moneyText = expansion.removeLast();
  moneyText = expansion.removeLast() + moneyText;
  moneyText = "." + moneyText;
  while (expansion.length > 3) {
    moneyText = expansion.removeLast() + moneyText;
    moneyText = expansion.removeLast() + moneyText;
    moneyText = expansion.removeLast() + moneyText;
    moneyText = ',' + moneyText;
  }
  if (expansion.length > 0) {
    moneyText = expansion.join('') + moneyText;
  }
  return moneyText;
}
