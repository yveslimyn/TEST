VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CCircuits"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Collection" ,"CCircuit"
Attribute VB_Ext_KEY = "Member0" ,"CCircuit"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Attribute VB_Ext_KEY = "RVB_UniqueId" ,"39A39A08012C"
Attribute VB_Ext_KEY = "RVB_ModelStereotype" ,"Class Module"
Option Explicit



'local variable to hold collection
'##ModelId=39A39A3B02F8
Private mCol As Collection
Attribute mCol.VB_VarDescription = "local variable to hold collection"



' Ajout d'un circuit dans la collection
'------------------------------------------------------------------------------
'##ModelId=39A39A3B0334
Public Sub Add(ByRef objNewMember As CCircuit, Optional sKey As String)
Attribute Add.VB_Description = " Ajout d'un circuit dans la collection\r\n------------------------------------------------------------------------------"
    If Len(sKey) = 0 Then
        mCol.Add objNewMember
    Else
        mCol.Add objNewMember, sKey
    End If
End Sub

' Acc�s � un des circuits de la collection
'------------------------------------------------------------------------------
'##ModelId=39A39A3B0367
Public Property Get Item(vntIndexKey As Variant) As CCircuit
Attribute Item.VB_Description = " Acc�s � un des circuits de la collection\r\n------------------------------------------------------------------------------"
Attribute Item.VB_UserMemId = 0
  Set Item = mCol(vntIndexKey)
End Property

' Nombre de circuits de la collection
'------------------------------------------------------------------------------
'##ModelId=39A39A3B03A6
Public Property Get Count() As Long
Attribute Count.VB_Description = " Nombre de circuits de la collection\r\n------------------------------------------------------------------------------"
    Count = mCol.Count
End Property

' Suppression d'un organisme
'------------------------------------------------------------------------------
'##ModelId=39A39A3B03D8
Public Sub Remove(vntIndexKey As Variant)
Attribute Remove.VB_Description = " Suppression d'un organisme\r\n------------------------------------------------------------------------------"
    mCol.Remove vntIndexKey
End Sub

' Enum�ration for Each
'------------------------------------------------------------------------------
'##ModelId=39A39A3C005A
Public Property Get NewEnum() As IUnknown
Attribute NewEnum.VB_Description = " Enum�ration for Each\r\n------------------------------------------------------------------------------"
Attribute NewEnum.VB_UserMemId = -4
Attribute NewEnum.VB_MemberFlags = "40"
    Set NewEnum = mCol.[_NewEnum]
End Property




'******************************************************************************



' Instanciation
'------------------------------------------------------------------------------
'##ModelId=39A39A3C005F
Private Sub Class_Initialize()
Attribute Class_Initialize.VB_Description = " Instanciation\r\n------------------------------------------------------------------------------"
    Set mCol = New Collection
End Sub

' D�sinstanciation
'------------------------------------------------------------------------------
'##ModelId=39A39A3C0096
Private Sub Class_Terminate()
Attribute Class_Terminate.VB_Description = " D�sinstanciation\r\n------------------------------------------------------------------------------"
    Set mCol = Nothing
End Sub


