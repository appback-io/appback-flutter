class Toggle {
  String _key;
  dynamic _value;

  Toggle(this._key, this._value);

  String get key => _key;

  dynamic get value => getValueType();

  dynamic getValueType() {
    print(_value);
    final parsedNumber = num.tryParse(_value);
    if (parsedNumber != null) {
      return parsedNumber;
    } else if (_value.equalsIgnoreCase("false")) {
      return false;
    } else if (_value.equalsIgnoreCase("true")) {
      return true;
    } else {
      return value.toString();
    }
  }
}
