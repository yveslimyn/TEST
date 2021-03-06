VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "C_Npas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'------------------------------------------------------------------------------
'   Structure de la table des NPA
'==============================================================================
Private Const FLDID = "NpaId"   ' Champs de l'id du NPA
Private Const FLDVAL = "NpaVal" ' Champs de la valeur du NPA

'------------------------------------------------------------------------------
'   Construction destruction de l'instance
'==============================================================================
Private Sub Class_Initialize()
End Sub
'------------------------------------------------------------------------------
Private Sub Class_Terminate()
End Sub

'------------------------------------------------------------------------------
'  Recherche d'un type dans la table
'==============================================================================
Private Sub fndNpa(npaId As Long)

   With M_DbPrs.dtaEnv.tblNpa
      
      If .EOF Then .MoveFirst
      
      ' Recherche du type dans la table
      If Not (.Fields(FLDID).Value = npaId) Then
         If Not .BOF Then .MoveFirst
         .Find FLDID & "=" & CStr(npaId)
      End If
      
   End With
   
End Sub



'******************************************************************************

'------------------------------------------------------------------------------
'   Nombre de NPA dans la table
'==============================================================================
Public Property Get Nombre() As Long

   ' Valorisation de la propri�t�
   Nombre = M_DbPrs.dtaEnv.tblNpa.Fields.Count
   
End Property
'------------------------------------------------------------------------------
'Public Property Let Nombre(ByVal vNewValue As Variant)
'End Property

'------------------------------------------------------------------------------
'   Propriet� Val
'==============================================================================
Public Property Get Val(npaId As Long) As String
   
   ' Positionnemnt sur la table
   fndNpa (npaId)
   
   ' Valorisation de la propri�t�
   With M_DbPrs.dtaEnv.tblNpa
      If .Fields(FLDID).Value = npaId Then
         Val = .Fields(FLDVAL).Value
      Else
         Val = "Id hors table"
      End If
   End With
   
End Property
'------------------------------------------------------------------------------
Public Property Let Val(npaId As Long, ByVal str As String)

   ' Positionnemnt sur la table
   fndNpa (npaId)
   
   ' Modification de la db
   With M_DbPrs.dtaEnv.tblNpa
      If .Fields(FLDID).Value = npaId Then .Fields(FLDVAL).Value = str
   End With
   
End Property

'------------------------------------------------------------------------------
'  Ajout d'un NPA dans la table
'==============================================================================
Public Sub Ajouter(npaVal As String)

   With M_DbPrs.dtaEnv.tblNpa
      .AddNew
      .Fields(FLDID).Value = .Fields.Count + 1
      .Fields(FLDVAL).Value = npaVal
      .Update
   End With
   
End Sub

'------------------------------------------------------------------------------
'  Suppression d'un NPA dans la table
'=============================================================================
Public Sub Supprimer(npaId As Long)

   ' Positionnement su la table
   fndCtn npaId
   
   ' Suppression du canton
   With M_DbPrs.dtaEnv.tblNpa
      If .Fields(FLDID).Value = npaId Then .Delete
      .Update
   End With
   
End Sub

