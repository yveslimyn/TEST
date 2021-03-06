VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CWndsClass"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "RVB_UniqueId" ,"3C88DAE40316"
Attribute VB_Ext_KEY = "RVB_ModelStereotype" ,"Collection"
Option Explicit

'============================================================================='
'                      Collection des windowsClass on top                     '
'-----------------------------------------------------------------------------'
' Cr�ation                                                                    '
' Date         : 05.03.02                                                     '
' Hauteur      : Y.Delay                                                      '
' Documentation: http://www.vbapi.com                                         '
'-----------------------------------------------------------------------------'
'                                                                             '
'============================================================================='



'�������������������������������� R�ferances ����������������������������������

' Liste des fen�tres au top
Declare Function EnumWindows Lib "user32.dll" (ByVal lpEnumFunc As Long, ByVal lParam As Long) As Long



'����������������������������������� Membres ����������������������������������

Private mWndTop As Collection   ' Collection des fen�tre au top



'���������������������������� Gestion de l'instance ���������������������������

Private Sub Class_Initialize()

    ' Cr�ation de la collection
    Set mWndTop = New Collection
    
    ' Mise � jour de la liste des fen�tre au top
    setWndTop
    
End Sub

Private Sub Class_Terminate()

    ' Supression des fen�tre
    For Each wnd In mWndTop
        Set wnd = Nothing
    Next wnd
    Set mWndTop = Nothing
    
End Sub



'���������������������������������� Propri�t�s ��������������������������������

'------------------------------------------------------------------------------
' Nombre de fen�tre au top
'==============================================================================
Public Property Get Count() As Long
    Count = mWndTop.Count
End Property

'------------------------------------------------------------------------------
' Renvoi d'une windows
'==============================================================================
Public Property Get Item(Index As Variant) As CWndClass
Attribute Item.VB_UserMemId = 0
    Set Item = mWndTop(Index)
End Property



'������������������������������������� Outils ���������������������������������

'------------------------------------------------------------------------------
' Fonction de callback de EnumWindows
'==============================================================================
Private Function EnmWndTop(ByVal hWnd As Long, ByVal lParam As Long) As Long
    Dim wnd As CWndClass
    Dim isIn As Boolean
    
    ' Contr�le si le hdl est d�ja dans la collecion
    For Each wnd In allWnd
        If wnd.Handel = hwdn Then isIn = True
    Next wnd
    
    ' si la fen�tre n'est pas r�f�ranc�e, ajout
    If Not isIn Then
    
        ' Cr�ation de la nouvelle windows
        Set wnd = New CWndClass
        win.Handel = hWnd
        
        ' Ajout dans la collextion
        allWnd.Add win, CStr(hWnd)
        
    End If
  
End Function

'------------------------------------------------------------------------------
' Mise � jour de la liste des fen�tres du bureau
'==============================================================================
Private Sub setWndTop()
    Dim retval As Long  ' return value
    
    ' Mise � jour de la liste des fen�tre au top
    retval = EnumWindows(AddressOf EnmWndTop, 0)
    
End Sub

