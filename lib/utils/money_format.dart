String moneyFormat(double money) {
  if (money == 0) return '0.00';
  List<String> expansion = (money * 100).toStringAsFixed(0).split('');
  while (expansion.length < 3) {
    expansion.insert(0, '0');
  }
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
