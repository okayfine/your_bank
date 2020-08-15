import 'package:encrypt/encrypt.dart';

//32 chars of random character should be used
final key = Key.fromUtf8('MySecretKeyForEncryptionAndDecry'); 

//16 chars of random character should be used
final iv = IV.fromUtf8('lionellobolionel'); 

//   Flutter encryption
String encrypTer(String text) {
  final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
  final encrypted = encrypter.encrypt(text, iv: iv);
//   print('text : $text');
//   print('encrypted : ${encrypted.base64}');
  return encrypted.base64;
}

//Flutter decryption
String decrypTer(String text) {
  final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
  final decrypted = encrypter.decrypt64(text, iv: iv);
  return decrypted;
}