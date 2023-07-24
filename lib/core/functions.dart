import 'dart:io';

checkInternet() async {
  try {
    var response = await InternetAddress.lookup('google.com');
    if (response.isNotEmpty)
      return true;
    else
      return false;
  } catch (_) {
    return false;
  }
}

String? token;
String adminToken='eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3dhc2hpbmctbGluZS5nb2ljc29mdHdhcmUuY29tL2FkbWluL3YxL2F1dGgvbG9naW4iLCJpYXQiOjE2ODM2Mzg1ODcsImV4cCI6MTY4NjIzMDU4NywibmJmIjoxNjgzNjM4NTg3LCJqdGkiOiJFc1VlSWhXSEc0dVFlU0hjIiwic3ViIjoiMSIsInBydiI6ImRmODgzZGI5N2JkMDVlZjhmZjg1MDgyZDY4NmM0NWU4MzJlNTkzYTkifQ.rG1caKJ7gzqiFF-8viCoQMRnE1S8G88hb8SSz6iTDqM';