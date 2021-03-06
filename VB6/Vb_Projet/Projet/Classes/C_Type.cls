VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "C_Type"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'��������������������������� STRUCTURE D 'UN TYPE �����������������������������

Private Type T_Tpe
   
   ' Donn�es
   TpeId As Long     ' Entr�e dans la table des types
   TpeLvl As Long    ' Niveau du type
   TpeNom As String  ' Nom du type
   TpeIco As String  ' Nom du fichier icone
   IsRef As Boolean  ' Si type de r�f�rance = 1
   IsAsf As Boolean  ' Si type ascociatif = 1
   
   ' Listes
   Tpss() As Long    ' Liste des types support
   Tprs() As Long    ' Liste des types de r�f�rance
   
   ' Flags de validit� des donn�es
   TpeOk As Boolean  ' Flag de mise � jour des donn�es du type
   TpsOk As Boolean  ' Flag de mise � jour des types supports
   TprOk As Boolean  ' Flag de mise � jour des types r�f�rance
   
End Type

Private mTpe As T_Tpe



'����������������������� PROPRIETES & METHODE DU TYPE �������������������������

'------------------------------------------------------------------------------
' Id du type
'==============================================================================
Property Get TpeId() As Long

   ' Contr�le la validit� des donn�es du type
   If Not mTpe.TpeOk Then setTpe mTpe
   
   ' Id du type
   TpeId = mTpe.TpeId
   
End Property
Property Let TpeId(id As Long)
   
   ' Valorisation de la propri�t�
   mTpe.TpeId = id
   
   ' Initialisation du type
   setTpe mTpe
   
End Property

'------------------------------------------------------------------------------
' Nom du type
'==============================================================================
Property Get TpeNom() As String

   ' Contr�le la validit� des donn�es du type
   If Not mTpe.TpeOk Then setTpe mTpe
   
   ' Valorisation de la propri�t�
   TpeNom = mTpe.TpeNom
   
End Property

'------------------------------------------------------------------------------
' Niveau
'==============================================================================
Property Get TpeLvl() As Long

   ' Contr�le la validit� des donn�es du type
   If Not mTpe.TpeOk Then setTpe mTpe
   
   ' Valeur du niveau du type
   TpeLvl = mTpe.TpeLvl
   
End Property

'------------------------------------------------------------------------------
' Icone
'==============================================================================
Property Get TpeIco() As String

   ' Contr�le la validit� des donn�es du type
   If Not mTpe.TpeOk Then setTpe mTpe
   
   ' Valeur du niveau du type
  TpeIco = mTpe.TpeIco
   
End Property

Public Sub TpeAdd(TpeId As Long)

End Sub
Public Sub TpeDel(TpeId As Long)

End Sub



'����������������� PROPRIETES & METHODE DES TYPES REFERANCE �������������������

'------------------------------------------------------------------------------
' Nombre des types r�f�rance du type
'==============================================================================
Property Get TprNbr() As Integer

   ' Contr�le la validit� des donn�es
   If Not mTpe.TprOk Then setTpr mTpe
   
   ' Nombre de Types de r�f�rance
   TprNbr = UBound(mTpe.Tprs)
   
End Property

'------------------------------------------------------------------------------
' Id des types de r�f�rance du type
'==============================================================================
Property Get TprId(numTpr As Integer) As Long

   ' Contr�le la validit� des donn�es
   If Not mTpe.TprOk Then setTpr mTpe
   
   ' Id du type de r�f�rance
   TprId = mTpe.Tprs(numTpr)
   
End Property

'------------------------------------------------------------------------------
' Nom du type de r�f�rance
'==============================================================================
Property Get TprNom(numTpr As Integer) As String

   ' Contr�le la validit� des donn�es
   If Not mTpe.TprOk Then setTpr mTpe
   
   ' Id du type de r�f�rance
   ModDtb.tblPosRcd ModDtb.tblTpe, "TpeId_", mTpe.Tprs(numTpr)
   TprNom = ModDtb.tblTpe.Fields("TpeNom").Value
    
   
End Property

'------------------------------------------------------------------------------
' Ajout d'un type de r�f�rance
'==============================================================================
Public Sub TprAdd(TprId As Long)

End Sub

'------------------------------------------------------------------------------
' Suppression d'un type de r�f�rance
'==============================================================================
Public Sub TprDel(TprId As Long)

End Sub



'������������������ PROPRIETES & METHODE DES TYPES SUPPORT ��������������������

'------------------------------------------------------------------------------
' Nombre des types supports du type
'==============================================================================
Property Get TpsNbr() As Integer

   ' Contr�le la validit� des donn�es
   If Not mTpe.TpsOk Then setTps mTpe
   
   ' Nombre de Types support
   TpsNbr = UBound(mTpe.Tpss)
   
End Property

'------------------------------------------------------------------------------
' Id d'un des types supports
'==============================================================================
Property Get TpsId(numTps As Integer) As Long

   ' Contr�le la validit� des donn�es
   If Not mTpe.TpsOk Then setTps mTpe
   
   ' Id du type support
   TpsId = mTpe.Tpss(numTps)
   
End Property

'------------------------------------------------------------------------------
' Nom du type support
'==============================================================================
Property Get TpsNom(numTps As Integer) As String

   ' Contr�le la validit� des donn�es
   If Not mTpe.TpsOk Then setTps mTpe
   
   ' Id du type support
   ModDtb.tblPosRcd ModDtb.tblTpe, "TpeId_", mTpe.Tpss(numTps)
   TpsNom = ModDtb.tblTpe.Fields("TpeNom").Value
    
End Property

'------------------------------------------------------------------------------
' ajout d'un type support
'==============================================================================
Public Sub TpsAdd(TpsId As Long)

End Sub

'------------------------------------------------------------------------------
' Suppression d'un type support
'==============================================================================
Public Sub TpsDel(TpsId As Long)

End Sub



'���������������������������������� Outils �����������������������������������
         
'------------------------------------------------------------------------------
' Valorise les donn�es d'un type
'==============================================================================
Private Sub setTpe(ByRef tpe As T_Tpe)
      
   ' Positionnement du tblCpo
   ModDtb.tblPosRcd tblTpe, "TpeId_", CStr(tpe.TpeId)
   
   ' Valirisation du type
   tpe.TpeNom = ModDtb.tblCpo.Fields("CpoTpeId_").Value
   tpe.TpeLvl = ModDtb.tblCpo.Fields("CpoTpeId_").Value
   tpe.TpeIco = ModDtb.tblCpo.Fields("CpoTpeId_").Value
   
   ' flags de type de r�f�rance
   If ModDtb.tblCpo.Fields("TpeRef_").Value Then
      tpe.IsRef = True
   Else
      tpe.IsRef = False
   End If
   
   ' flag de type associatif
   If ModDtb.tblCpo.Fields("TpeAsf_").Value Then
      tpe.IsAsf = True
   Else
      tpe.IsAsf = False
   End If
   
   ' Initialisation des listes
   ReDim tpe.Tpss(0): tpe.TpsOk = False
   ReDim tpe.Tprs(0): tpe.TprOk = False
   
   ' Mise � jour du flag
   tpe.TpeOk = True
   
End Sub

'------------------------------------------------------------------------------
' Recherche des Id des types qui peuvent �tre supports du type
'==============================================================================
Private Sub setTps(tpe As T_Tpe)
   Dim tblTpeSup As New ADODB.Recordset
   Dim numTpeSup As Integer
   
   ' Initialisation de la liste des types support du type
   ReDim tpe.Tpss(0)
   
   ' Ouverture du rst
   Set tblTpeSup = ModDtb.PrcRun("QryTps", tpe.TpeId)
   
   ' Parcourt des types supports
   While Not tblTpeSup.EOF
   
      ' Ajout du nouveau type dans la liste
      numTpeSup = numTpeSup + 1
      ReDim Preserve tpe.Tpss(numTpeSup)
      tpe.Tpss(numTpeSup) = tblTpeSup.Fields("Id").Value
      
      ' Type support suivant
      tblTpeSup.MoveNext
      
   Wend

   ' D�sallocation
   tblTpeSup.Close
   Set tblTpeSup = Nothing
   
   ' Mise � jour du flag
   tpe.TpsOk = True
   
End Sub

'------------------------------------------------------------------------------
' Recherche des Id des types des de r�f�rance
'==============================================================================
Private Sub setTpr(tpe As T_Tpe)
   Dim lstTpr As New ADODB.Recordset
   Dim numTpr As Integer
   
   ' Initialisation de la liste des types support du type
   ReDim tpe.Tprs(0)
   
   ' Ouverture du rst
   Set lstTpr = ModDtb.PrcRun("QryTpr", tpe.TpeId)
   
   ' Parcourt des types de r�f�rance
   While Not lstTpr.EOF
   
      ' Ajout du nouveau type dans la liste
      numTpr = numTpr + 1
      ReDim Preserve tpe.Tprs(numTpr)
      tpe.Tprs(numTpr) = lstTpr.Fields("Id").Value
      
      ' Type support suivant
      lstTpr.MoveNext
      
   Wend

   ' D�sallocation
   lstTpr.Close
   Set lstTpr = Nothing
   
   ' Mise � jour du flag
   tpe.TprOk = True
   
End Sub



