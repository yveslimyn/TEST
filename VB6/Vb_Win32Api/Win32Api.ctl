VERSION 5.00
Begin VB.UserControl Win32Api 
   ClientHeight    =   3600
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4800
   InvisibleAtRuntime=   -1  'True
   ScaleHeight     =   3600
   ScaleWidth      =   4800
End
Attribute VB_Name = "Win32Api"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True




'같같같같같 API 같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같�



Private Declare Sub ApiSleep Lib "Kernel32.dll" (ByVal dwMillisenconds As Long)



'같같같같같 INTERFACE 같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같�



'
'______________________________________________________________________________________________________________________
Public Sub Sleep(ByVal nMillisenconds As Long)
    ApiSleep nMillisenconds
End Sub




'같같같같같 RIVATE 같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같




'같같같같같 EVENTS HANDLERS 같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같같�



