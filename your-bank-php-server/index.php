<?php
header('Access-Control-Allow-Origin: *');
// echo"Server Running";

const key = 'MySecretKeyForEncryptionAndDecry'; // 32 chars
// initialization vector/nonce
const iv = 'lionellobolionel'; // 16 chars
const method = 'aes-256-cbc';

/**
 * 
 * WE USE AN INTERNAL PHP FUNCTION openssl_<encrypt,decrypt> WHICH
 * TAKES IN ENCRYPTED OR DECRYPTED DATA AND USES PREDEFINED
 * KEY, IV AND METHOD
 * 
 */

function decrypTer($text){
  return openssl_decrypt($text, method, key, 0, iv);
}

function encrypTer($text){
  //   $text should be String
  return openssl_encrypt($text, method, key, 0, iv);
}

//initialize vars
$email = $_POST['email'];
$pass = $_POST['password'];

$email = decrypTer($email);
$pass = decrypTer($pass);

$response = array();
$response['status'] = false; 

if($email == 'test@email.com' && $pass =='password'){
  $response = array();
  $response['status'] = true;
  $response['key'] = encrypTer('lionel');
}

echo json_encode($response);

?>