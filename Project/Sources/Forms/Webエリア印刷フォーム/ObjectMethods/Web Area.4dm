

Case of 
	: (FORM Event:C1606.code=On Load:K2:1)
		
		$path:=Folder:C1567("/RESOURCES/PDF/").files(fk ignore invisible:K87:22)[0].platformPath
		$path:=Convert path system to POSIX:C1106($path)
		
		WA OPEN URL:C1020(*; "Web Area"; "file://"+$path)
		
End case 
