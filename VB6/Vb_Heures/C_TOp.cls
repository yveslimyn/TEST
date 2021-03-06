VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "C_TOp"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Dim mId As String

'------------------------------------------------------------------------------
'  Instanciation, d�sinstanciation de l'objet
'==============================================================================
Private Sub Class_Initialize()

   ' Instanciation des membres
   
   ' Initialisation des membres
   mId = 0
   
End Sub
'------------------------------------------------------------------------------
Private Sub Class_Terminate()
   
   ' D�sinstanciation des membres
   
End Sub

'------------------------------------------------------------------------------
'  Positionnement sur une des tables en fonction de la valeur de la clef principale
'==============================================================================
Private Sub fndTOp()

   ' Check de la validit� de l'Id
   If mId > 0 Then
   
      ' Positionnement dans la table
      With dtaHeures.rstblTOp
         If .EOF Then .MoveFirst
         If Not .Fields("Id").Value = mId Then
            If Not .BOF Then .MoveFirst
            .Find "Id=" & CStr(mId)
         End If
      End With
      
   End If
   
End Sub



'******************************************************************************

'------------------------------------------------------------------------------
'  Id du type d'op�ration
'==============================================================================
Public Property Get Id() As Long

   ' Valorisation de la propri�t�
   Id = mId
   
End Property
'------------------------------------------------------------------------------
Public Property Let Id(ByVal val As Long)

   ' Valorisation de la donn�e membre
   mId = val
   
End Property

'------------------------------------------------------------------------------
'  Nom du type d'op�ration
'==============================================================================
Public Property Get Nom() As String
   With dtaHeures.rstblTOp
   
      ' Recherhche l'id dans la table
      fndTOp
       
      ' Contr�le de la validit� de la recherche et valorisation de la propri�t�
      If dtaHeures.rstblTOp.Fields("ID").Value = mId Then
         Nom = .Fields("Nom").Value
      Else
         Nom = "?"
      End If
      
   End With
End Property
'------------------------------------------------------------------------------
Public Property Let Nom(ByVal str As String)
   With dtaHeures.rstblTOp
   
      ' Positionnement sur la table
      fndTOp

      ' contr�le de la recherche et Modification de la valeur du champs
      If .Fields("Id").Value = mId Then .Fields("Nom").Value = str
   
   End With
End Property

'------------------------------------------------------------------------------
'  Suppression de l'enregistrement
'==============================================================================
Public Sub Add()

   ' Recherche du d�rnier id de la table
   With dtaHeures.rsidMaxTOp
      mId = .Fields("Id").Value + 1
   End With
   
   ' Ajout d'un enregistrement dans la table
   With dtaHeures.rstblTOp
      .AddNew
      !Id = mId
      .Update
   End With
   
End Sub
'------------------------------------------------------------------------------
Public Sub Del()
   With dtaHeures.rstblTOp
   
      ' Positionnement sur la table
      fndTOp
      
      ' Suppression de l'enregistrement
      If .Fields("Id").Value = mId Then
         .Delete
         mId = 0
         .Update
      End If
      
   End With
End Sub


