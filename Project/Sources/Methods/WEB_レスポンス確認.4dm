//%attributes = {"invisible":true}
/*

送られてきたリスエストがどのような内容であったかをレスポンスする

*/

ARRAY TEXT:C222($headerField; 0)
ARRAY TEXT:C222($headerValue; 0)

WEB GET HTTP HEADER:C697($headerField; $headerValue)

var $resopnce : Object

var $header : Collection
$header:=New collection:C1472

ARRAY TO COLLECTION:C1563($header; $headerField; "Filed"; $headerValue; "Value")

$resopnce:=New object:C1471
$resopnce.header:=$header

WEB SEND TEXT:C677(JSON Stringify:C1217($resopnce; *); "application/json")
