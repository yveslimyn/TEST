VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "C_LstTpe"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit



'������������������������������ TYPES MEMBRES ��������������������������������

'------------------------------------------------------------------------------
' Structure de donn�e d'une liste de type
'==============================================================================
Private Type T_LstTpe
   TpesId() As Long  ' Liste des Id des types
   LstOk As Boolean  ' Flag de validit� des donn�es de la liste
End Type



'������������������������������ DONNEES MEMBRES �������������������������������

Private mLstTpe As T_LstTpe



'������������������������� PROPRIETES ET METHODES �����������������������������

'------------------------------------------------------------------------------
' Nombre de composant dans la liste
'==============================================================================
Property Get TpeNbr() As Integer

   ' Contr�le de la validit� des donn�es
   If Not mLstTpe.LstOk Then setLstTpe mLstTpe
   
   ' Valorisation de la propri�t�
   TpeNbr = UBound(mLstTpe.TpesId)
   
End Property

'------------------------------------------------------------------------------
' Id d'un des composant de la liste
'==============================================================================
Property Get TpeId(numTpe As Integer) As Long

   ' Contr�le de la validit� des donn�es
   If Not mLstTpe.LstOk Then setLstTpe mLstTpe
   
   ' Valorisation de la propri�t�
   TpeId = mLstTpe.TpesId(numTpe)
   
End Property

'------------------------------------------------------------------------------
' Un des composant de la liste
'==============================================================================
Property Get TpeTpe(numTpe As Integer) As C_Composant
   Dim cpo As New C_Composant
   
   ' Contr�le de la validit� des donn�es
   If Not mLstTpe.LstOk Then setLstTpe mLstTpe
   
   ' Valorisation du composant
   cpo.TpeId = mLstTpe.TpesId(numTpe)
   
   ' Valorisation de la propri�t�
   TpeTpe = cpo
   
   ' D�sallocation
   Set cpo = Nothing
   
End Property



'���������������������������������� OUTILS ������������������������������������

'------------------------------------------------------------------------------
' Initalisation de la liste des composant en fonction du type
'==============================================================================
Private Sub setLstTpe(lstCpo As T_LstTpe)
   Dim Cpos As ADODB.Recordset
   Dim numTpe As Integer
   
   ' Initialisation de la liste des cpo
   ReDim lstCpo.TpesId(0)
   
   ' Recherche des entit�s du type
   Set Cpos = ModDtb.PrcRun("QryTpe", lstCpo.TpeId)
   
   ' Ins�rtion des Id des Composants
   While Not Cpos.EOF
         
      ' Ajout de l'Id dans la liste
      numTpe = numTpe + 1
      ReDim Preserve lstCpo.TpesId(numTpe)
      lstCpo.TpesId(numTpe) = Cpos.Fields("Id").Value
      
      ' Composant suivant
      Cpos.MoveNext
      
   Wend
   
   ' Mise � jour du flag
   lstCpo.LstOk = True
   
   ' D�sallocation
   Cpos.Close
   Set Cpos = Nothing
   
End Sub

