VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CEdt"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "RVB_UniqueId" ,"3C88D8EB02B2"
Attribute VB_Ext_KEY = "RVB_ModelStereotype" ,"Class Module"
Option Explicit

'##ModelId=3C88D903001E
Implements CWndClass

'##ModelId=3C88DD460384
Private mCObjetObject As New CWndClass

'##ModelId=3C8937B201E0
Private Property Get CWndClass_Handel() As Long
    CWndClass_Handel = mCObjetObject.Handel
End Property

'##ModelId=3C8937B2024E
Private Property Let CWndClass_Handel(ByVal vNewValue As Long)
    mCObjetObject.Handel = vNewValue
End Property

'##ModelId=3C88DD49032A
Private Sub Class_Initialize()

End Sub

'##ModelId=3C88DD4A01D6
Private Sub Class_Terminate()

End Sub
