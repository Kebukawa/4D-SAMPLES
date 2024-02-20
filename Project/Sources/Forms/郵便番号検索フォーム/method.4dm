
Case of 
	: (FORM Event:C1606.code=On Load:K2:1)
		
		OBJECT SET VALUE:C1742("Input 郵便番号"; "0790177")  //テスト用
		
	: (FORM Event:C1606.objectName="Button 郵便番号検索")
		
		$url:="https://zipcloud.ibsnet.co.jp/api/search?zipcode="+OBJECT Get value:C1743("Input 郵便番号")
		
		var $contents; $resopnce : Object
		$url:="https://zipcloud.ibsnet.co.jp/api/search?zipcode=0790177"
		$status:=HTTP Request:C1158(HTTP GET method:K71:1; $url; $contents; $resopnce)
		If ($status=200)
			Form:C1466.list:=$resopnce.results
		End if 
		
End case 
