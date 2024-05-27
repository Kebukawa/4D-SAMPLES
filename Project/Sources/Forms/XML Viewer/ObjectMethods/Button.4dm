

var $folder_last_selected : 4D:C1709.Folder
If (Form:C1466.folder_last_selected=Null:C1517)
	$folder_last_selected:=Folder:C1567(fk database folder:K87:14)
Else 
	$folder_last_selected:=Form:C1466.folder_last_selected
End if 



$name:=Select document:C905($folder_last_selected.platformPath; ""; "XMLファイルを指定してください"; Allow alias files:K24:10)

If (OK=1)
	Form:C1466.folder_last_selected:=File:C1566(Document; fk platform path:K87:2).parent
	
	$xml:=DOM Parse XML source:C719(Document; False:C215)
	DOM GET XML ELEMENT NAME:C730($xml; $elementName)
	
	DOM GET XML CHILD NODES:C1081($xml; $childTypesArr; $nodeRefsArr)
	
	DOM CLOSE XML:C722($xml)
	
	
End if 
