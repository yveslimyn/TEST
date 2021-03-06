VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "C_LstCpo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit



'������������������������������ TYPES MEMBRES ��������������������������������

Enum T_TpeLstCpo
   TPECPO = 1  ' Liste de composants par type de composant
   CPOSUP = 2  ' Liste de composants par composant support
End Enum

'------------------------------------------------------------------------------
' Structure de donn�e d'une liste de composant
'==============================================================================
Private Type T_LstCpo
   IdFtr As Long     ' Id de filtre des composants de la liste
   Cpos() As Long    ' Liste des Id des composant
   LstOk As Boolean  ' Flag de validit� des donn�es de la liste
   LstTpe As T_TpeLstCpo
End Type



'������������������������������ DONNEES MEMBRES �������������������������������

Private mLstCpo As T_LstCpo



'�������������������� PROPRIETES ET METHODES  ��������������������

'------------------------------------------------------------------------------
' Liste de composant de m�me type
'==============================================================================
Property Get LstTpeId() As Long
   
   LstTpeId = mLstCpo.IdFtr
   
End Property
Property Let LstTpeId(id As Long)

   With mLstCpo
   
      ' Valorisation de l'id de filtre
      .IdFtr = id
   
      ' Valorisation du type de liste
      .LstTpe = TPECPO
   
      ' Flag de non validit� de donn�es
      .LstOk = False
   
   End With
   
End Property



'����������������� PROPRIETES ET METHODES LISTE PAR CONTENU �������������������

'------------------------------------------------------------------------------
' Composant dans le quel sont contenus les composants de la liste
'==============================================================================
Property Get LstCpcId() As Long

   LstCpcId = mLstCpo.IdFtr
   
End Property
Property Let LstCpcId(id As Long)

   With mLstCpo
   
      ' Valorisationde l'id du composant support des composants de la liste
      .IdFtr = id
   
      ' Valorisation du type de liste
      .LstTpe = CPOSUP
      
      ' Flag de non validit� des donn�es
      .LstOk = False
   
   End With
   
End Property



'������������� PROPRIETES ET METHODES DES COMPOSANT DE LA LISTE ���������������

'------------------------------------------------------------------------------
' Nombre de composant dans la liste
'==============================================================================
Property Get CpoNbr() As Integer

   With mLstCpo
   
      ' Contr�le de la validit� des donn�es
      If Not .LstOk Then setLstCpo
   
      ' Valorisation de la propri�t�
      CpoNbr = UBound(.Cpos)
   
   End With
   
End Property

'------------------------------------------------------------------------------
' Un des composants de la liste
'==============================================================================
Property Get CpoNum(numCpo As Integer) As C_Composant
   Dim cpo As New C_Composant
   
   With mLstCpo
   
      ' Contr�le de la validit� des donn�es
      If Not .LstOk Then setLstCpo
   
      ' Initialisation du composant
      cpo.cpoId = .Cpos(numCpo)
   
      ' Valorisation de la propri�t�
      Set CpoNum = cpo
      
   End With
   
   ' D�sallocation
   Set cpo = Nothing
   
End Property



'���������������������������������� OUTILS ������������������������������������

'------------------------------------------------------------------------------
' Initialisation de la liste en fonction du type de liste
'==============================================================================
Private Sub setLstCpo()
   
   With mLstCpo
   
      ' Initialisation de la liste de composant en fonction du type de liste
      If .LstTpe = TPECPO Then
         setLstTpe
      Else
         setLstCpc
      End If
      
   End With
      
End Sub

'------------------------------------------------------------------------------
' Cr�ation de la liste avec les composants qui ont um m�me composant support
'==============================================================================
Private Sub setLstCpc()
   Dim qryCpc As ADODB.Recordset
   Dim numCpo As Integer
   
   With mLstCpo
   
      ' Initialisation de la liste des cpo
      ReDim .Cpos(0)
   
      ' Recherche des composants contenus
      Set qryCpc = ModDtb.PrcRun("QryCpc", .IdFtr)
   
      ' Ins�rtion des Id des Composants
      While Not qryCpc.EOF
         
         ' Ajout de l'Id dans la liste
         numCpo = numCpo + 1
         ReDim Preserve .Cpos(numCpo)
         .Cpos(numCpo) = qryCpc.Fields("Id").Value
      
         ' Composant suivant
         qryCpc.MoveNext
      
      Wend
   
      ' Mise � jour du flag
      .LstOk = True
   
   End With
      
   ' D�sallocation
   qryCpc.Close
   Set qryCpc = Nothing

End Sub

'------------------------------------------------------------------------------
' Cr�ation de la liste avec les composant de m�me type
'==============================================================================
Private Sub setLstTpe()
   Dim qryTpe As ADODB.Recordset
   Dim numCpo As Integer
   
   With mLstCpo
   
      ' Initialisation de la liste des cpo
      ReDim .Cpos(0)
   
      ' Recherche des entit�s du type
      Set qryTpe = ModDtb.PrcRun("QryTpe", .IdFtr)
   
      ' Ins�rtion des Id des Composants
      While Not qryTpe.EOF
         
         ' Ajout de l'Id dans la liste
         numCpo = numCpo + 1
         ReDim Preserve .Cpos(numCpo)
         .Cpos(numCpo) = qryTpe.Fields("Id").Value
      
         ' Composant suivant
         qryTpe.MoveNext
      
      Wend
   
      ' Mise � jour du flag
      .LstOk = True
   
   End With
   
   ' D�sallocation
   qryTpe.Close
   Set qryTpe = Nothing
   
End Sub
