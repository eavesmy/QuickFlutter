bool isEmpty(dynamic obj) {
  if (obj == null) {
    return true;
  }
  if (obj is String) {
    return obj.isEmpty;
  } else if (obj is List) {
    return obj.isEmpty;
  } else if (obj is Map) {
    return obj.isEmpty;
  } else if (obj is Set) {
    return obj.isEmpty;
  } else {
    return obj.toString().isEmpty;
  }
}

bool isNotEmpty(dynamic obj) {
  return !isEmpty(obj);
}

bool isBlankOrEmpty(dynamic obj) {
  return obj == null || obj.toString().trim().isEmpty;
}

bool isNotBlankOrEmpty(dynamic obj) {
  return !isBlankOrEmpty(obj);
}
