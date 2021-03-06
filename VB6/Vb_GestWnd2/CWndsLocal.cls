VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CWndsLocal"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False




'------------------------------------------------------------------------------
' Liste des fen�tre au premier plan
'==============================================================================
Public Function EnmWndTop(ByVal hWnd As Long, ByVal lParam As Long) As Long
    Dim nbrWnd As Integer
    
    ' nombre de fen�tres actuelles
    nbrWnd = UBound(lstHdlWndTop)
    
    ' Ajout de la fen�tre dans la liste
    nbrWnd = nbrWnd + 1
    ReDim Preserve lstHdlWndTop(nbrWnd)
    lstHdlWndTop(nbrWnd) = hWnd
    
    ' return value of 1 means continue enumeration
    EnmWndTop = 1
  
End Function
'------------------------------------------------------------------------------
Public Sub setHdlWndTop()
    Dim retval As Long  ' return value
    
    ' Initialisation de la liste des fen�tres premier plan
    ReDim lstHdlWndTop(0)
    
    ' Mise � jour de la liste des fen�tre au top
    retval = EnumWindows(AddressOf EnmWndTop, 0)
    
End Sub
