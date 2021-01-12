String enumValue(dynamic enumObj) {
  var str = enumObj.toString();
  return str.substring(str.indexOf('.') + 1);
}

String enumValueLower(dynamic enumObj) {
  return enumValue(enumObj).toLowerCase();
}
