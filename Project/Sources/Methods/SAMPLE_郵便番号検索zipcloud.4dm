//%attributes = {}
/*

フォームに頼らずに検索画面も表示する
つまり、このメソッドだけあれば検索画面で検索できる

]*/

Case of 
	: (FORM Event:C1606=Null:C1517)
		
		//mark: 表示するためのフォームを組み立てる
		$dynForm:=New object:C1471(\
			"rightMargin"; 10; "bottomMargin"; 10; \
			"windowTitle"; "郵便番号検索（zipcloud.ibsnet.co.jp）"; \
			"events"; New collection:C1472("onLoad"; "onClick"); \
			"method"; Current method name:C684\
			)
		$page:=New object:C1471("objects"; New object:C1471)
		$dynForm.pages:=New collection:C1472($page)
		
		//mark: 郵便番号検索用フォームオブジェクト
		$page.objects["Text"]:=New object:C1471("type"; "text"; "text"; "郵便番号："; "top"; 12; "left"; 10; "width"; 70; "height"; 16)
		$page.objects["Input 郵便番号"]:=New object:C1471("type"; "input"; "entryFilter"; "!0&9###-####"; "top"; 12; "left"; 75; "width"; 80; "height"; 16)
		$page.objects["Button 郵便番号検索"]:=New object:C1471("type"; "button"; "text"; "検索"; "top"; 9; "left"; 165; "width"; 80; "height"; 22; "events"; New collection:C1472("onClick"); "shortcutKey"; "[Enter]"; "focusable"; False:C215)
		
		//mark: 郵便番号リスト表示用リストボックス
		$columns:=New collection:C1472
		$page.objects["List Box"]:=New object:C1471(\
			"type"; "listbox"; \
			"left"; 10; "top"; 50; "width"; 460; "height"; 500; \
			"sizingX"; "grow"; \
			"sizingY"; "grow"; \
			"scrollbarHorizontal"; "hidden"; \
			"listboxType"; "collection"; \
			"dataSource"; "Form:C1466.list"; \
			"focusable"; False:C215; \
			"resizingMode"; "legacy"; \
			"events"; New collection:C1472("onClick"); \
			"columns"; $columns\
			)
		$columns.push(New object:C1471(\
			"header"; New object:C1471("name"; "Header1"; "text"; "郵便番号"); \
			"dataSource"; "This:C1470.zipcode"; \
			"textFormat"; "###-####"; \
			"width"; 80))
		$columns.push(New object:C1471(\
			"header"; New object:C1471("name"; "Header2"; "text"; "都道府県"); \
			"dataSource"; "This:C1470.address1"; \
			"width"; 80))
		$columns.push(New object:C1471(\
			"header"; New object:C1471("name"; "Header3"; "text"; "住所"); \
			"dataSource"; "This:C1470.address2+This:C1470.address3"; \
			"width"; 300))
		
		//mark: ダイアログを表示する
		$window:=Open form window:C675($dynForm)
		DIALOG:C40($dynForm)
		CLOSE WINDOW:C154($window)
		
		
	: (FORM Event:C1606.code=On Load:K2:1)
		
		//mark: フォーム初期化
		//OBJECT SET VALUE("Input 郵便番号"; "0790177")  //テスト用
		GOTO OBJECT:C206(*; "Input 郵便番号")
		
	: (FORM Event:C1606.objectName="Button 郵便番号検索")
		
		//mark: ボタンが押されたとき
		$url:="https://zipcloud.ibsnet.co.jp/api/search?zipcode="+OBJECT Get value:C1743("Input 郵便番号")
		var $contents; $resopnce : Object
		$status:=HTTP Request:C1158(HTTP GET method:K71:1; $url; $contents; $resopnce)
		Case of 
			: ($status=200) & ($resopnce.message#Null:C1517)
				Form:C1466.list:=New collection:C1472(New object:C1471("zipcode"; $resopnce.message))
			: ($status=200) & ($resopnce.results=Null:C1517)
				Form:C1466.list:=New collection:C1472(New object:C1471("zipcode"; "該当なし"))
			: ($status=200)
				Form:C1466.list:=$resopnce.results
			Else 
				Form:C1466.list:=New collection:C1472(New object:C1471("zipcode"; "エラー"))
		End case 
		
End case 