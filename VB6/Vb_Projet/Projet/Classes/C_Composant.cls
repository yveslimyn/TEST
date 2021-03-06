VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "C_Composant"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit



'������������������������� Types et Donn�es membres ���������������������������

'------------------------------------------------------------------------------
' Structure d'une Composant
'============================================================================
Private Type T_Cpo
   
   ' Donn�es
   CpoId As Long     ' Entr�e dans la table des Composants
   tpeId As Long     ' Entr�e dans la table des types
   AtrId As Long     ' Entr�e dans la table de d�scription du type
   Level As Long     ' Niveau du composant
   Descr As String   ' D�scriptif du composant utilis� dans les treeview et listeview
   IsRef As Boolean  ' Flag de composant de r�f�rance
   IsAsf As Boolean  ' Flag de composant associatif
   
   ' Listes
   Atrs() As String  ' Liste des attributs du composant
   Cprs() As Long    ' Liste des id des composants r�f�rance
   Cpss() As Long    ' Liste des id des composants Support
   Tpss() As Long    ' Liste des types qui peuvent �tre support du composant
   Tprs() As Long    ' Liste des types qui sont r�f�rance du composant
   
   ' Flags de validit� des donn�es
   CpoOk As Boolean  ' Flag de mise � jour des donn�es du composant
   AtrOk As Boolean  ' Flag de mise � jour des attributs
   CprOk As Boolean  ' Flag de mise � jour des r�f�rances
   CpsOk As Boolean  ' Flag de mise � jour des supports
   TpsOk As Boolean  ' Flag de mise � jour des types supports
   TprOk As Boolean  ' Flag de mise � jour des types r�f�rance
   DscOk As Boolean  ' Flag de mise � jour de la d�scription du composant
   
End Type
   
'------------------------------------------------------------------------------
' Composant de l'instance
'============================================================================
Dim mCpo As T_Cpo



'��������������������������� DONNEES DU COMPOSANT �����������������������������

'------------------------------------------------------------------------------
' Id du composant
'==============================================================================
Property Get CpoId() As Long

   ' Contr�le la validit� des donn�es du composant
   If Not mCpo.CpoOk Then setCpo mCpo
   
   ' Id du composant
   CpoId = mCpo.CpoId
   
End Property
Property Let CpoId(id As Long)
Attribute CpoId.VB_Description = "Id du composant"
   
   mCpo.CpoId = id
   
   ' Initialisation du Composant
   setCpo mCpo
   
End Property

'------------------------------------------------------------------------------
' D�scription du composant
'==============================================================================
Property Get CpoDsc() As String

   ' Contr�le la validit� des donn�es du composant
   If Not (mCpo.DscOk And mCpo.CpoOk And mCpo.CpsOk) Then
      If Not mCpo.CpoOk Then setCpo mCpo
      If Not mCpo.CpsOk Then setCps mCpo
      setDsc mCpo
   End If
   
   ' Valorisation de la propri�t�
   CpoDsc = mCpo.Descr
   
End Property

'------------------------------------------------------------------------------
' Type du composant
'==============================================================================
Property Get tpeId() As Long

   ' Contr�le la validit� des donn�es du composant
   If Not mCpo.CpoOk Then setCpo mCpo
   
   ' Id du type du composant
   tpeId = mCpo.tpeId
   
End Property
Property Get TpeNom() As String

   ' Contr�le la validit� des donn�es du composant
   If Not mCpo.CpoOk Then setCpo mCpo
   
   ' Nom du composant
   ModDtb.tblPosRcd ModDtb.tblTpe, "TpeId_", mCpo.tpeId
   TpeNom = ModDtb.tblTpe.Fields("TpeNom").Value
   
End Property

'------------------------------------------------------------------------------
' Niveau
'==============================================================================
Property Get TpeLvl() As Long

   ' Contr�le la validit� des donn�es du composant
   If Not mCpo.CpoOk Then setCpo mCpo
   
   ' Valeur du niveau du composant
   TpeLvl = mCpo.Level
   
End Property

'------------------------------------------------------------------------------
' Icone
'==============================================================================
Property Get TpeIco() As String

   ' Contr�le la validit� des donn�es du composant
   If Not mCpo.CpoOk Then setCpo mCpo
   
   ' Valeur du niveau du composant
   ModDtb.tblPosRcd ModDtb.tblTpe, "TpeId_", mCpo.tpeId
   TpeIco = ModDtb.tblTpe.Fields("TpeIco").Value
   
End Property

Public Sub cpoAdd(tpeId As Long)

End Sub
Public Sub cpoDel(CpoId As Long)

End Sub


'������������������������������� ATTRIBUTS ������������������������������������

'------------------------------------------------------------------------------
' Nombre d'attribut
'==============================================================================
Property Get AtrNbr() As Integer

   ' Contr�le la validit� des attributs du composant
   If Not mCpo.AtrOk Then setAtr mCpo
   
   ' Nombre d'attributs
   AtrNbr = UBound(mCpo.Atrs)
   
End Property

'------------------------------------------------------------------------------
' Noms des attributs
'==============================================================================
Property Get AtrNom(numAtr As Integer) As String

   ' Contr�le la validit� des attributs du composant
   If Not mCpo.AtrOk Then setAtr mCpo
   
   ' Nom de l'attribut
   AtrNom = mCpo.Atrs(0, numAtr)
   
End Property

'------------------------------------------------------------------------------
' Valeurs des attributs
'==============================================================================
Property Get AtrVal(numAtr As Integer) As String

   ' Contr�le la validit� des attributs du composant
   If Not mCpo.AtrOk Then setAtr mCpo
   
   ' Valeur de l'attribut
   AtrVal = mCpo.Atrs(1, numAtr)
   
End Property
Property Let AtrVal(numAtr As Integer, valeur As String)
Attribute AtrVal.VB_Description = "Valeur d'un des attributs du composant"
   
   ' Modification de la table de d�scription du composant
   ModDtb.tblPosRcd ModDtb.tblsAtr(mCpo.tpeId), "atrId_", mCpo.AtrId
   ModDtb.atrUpd ModDtb.tblsAtr(mCpo.tpeId), mCpo.Atrs(0, numAtr), valeur
   
   ' Modification du nom du composant dans la table des composant
   If numAtr = 1 Then
      ModDtb.tblPosRcd ModDtb.tblCpo, "CpoId_", mCpo.CpoId
      ModDtb.atrUpd ModDtb.tblCpo, "CpoDsc", valeur
   End If
   
   ' Mise � jour de la valeur de l'attribut du composant
   mCpo.Atrs(1, numAtr) = valeur
      
End Property

'------------------------------------------------------------------------------
' Ajout d'un attributs
'==============================================================================
Public Sub atrAdd(nom As String, val As String)

   ModDtb.dscAdd
End Sub

'------------------------------------------------------------------------------
' Suppression d'un attributs
'==============================================================================
Public Sub AtrDel(numAtr As Integer)

End Sub



'������������������������� COMPOSANTS DE REFERANCES ���������������������������

'------------------------------------------------------------------------------
' Nombre de composants de r�f�rance
'==============================================================================
Property Get CprNbr() As Integer

   ' Contr�le la validit� des r�f�rance du composant
   If Not mCpo.CprOk Then setCpr mCpo
   
   ' Nombre de composant de r�f�rance
   CprNbr = UBound(mCpo.Cprs)
   
End Property

'------------------------------------------------------------------------------
' Id des composants de r�f�rance
'==============================================================================
Property Get cprId(numCpr As Integer) As Long
Attribute cprId.VB_Description = "Id d'un des composants de r�f�rance du composant"

   ' Contr�le la validit� des r�f�rance du composant
   If Not mCpo.CprOk Then setCpr mCpo
   
   ' Id du composant de r�f�rance
   cprId = mCpo.Cprs(numCpr)
   
End Property

'------------------------------------------------------------------------------
' Ajout d'un lien de r�f�rance sur un composant
'==============================================================================
Public Sub cprAdd(cprId As Long)
   Dim newCpr As T_Cpo
   Dim numCpr As Integer
   
   ' Contr�le de la validit� des donn�es des composants de r�f�rances
   If Not mCpo.CprOk Then setCpr mCpo
   
   ' Valorisation des donn�es du nouveau composant de r�f�rance
   newCpr.CpoId = cprId: setCpo newCpr
   
   ' Suppression des �ventuels composants de r�f�rance du m�me type
   For numCpr = 1 To UBound(mCpo.Cprs)
      If fndCpoTpeId(mCpo.Cprs(numCpr)) = newCpr.tpeId Then
         cprDel (mCpo.Cprs(numCpr))
      End If
   Next numCpr
   
   ' Ajout du lien dans la table
   ModDtb.lnkAdd LNKCPR, mCpo.CpoId, cprId
      
   ' Flag de non validit� des donn�es
   mCpo.CprOk = False
   
End Sub

'------------------------------------------------------------------------------
' Suppression d'un lien de r�f�rance sur un composant
'==============================================================================
Public Sub cprDel(CpoId As Long)

   ' Suppression du lien du composant
   ModDtb.lnkDel LNKCPR, mCpo.CpoId, CpoId
   
   ' Flag de non validit� des donn�es
   mCpo.CprOk = False
   
End Sub

'------------------------------------------------------------------------------
' Id du type du composants de r�f�rance
'==============================================================================
Property Get cprTpeId(numCpr As Integer) As Long

   ' Contr�le la validit� des r�f�rance du composant
   If Not mCpo.CprOk Then setCpr mCpo
   
   ' Id du type du composant de r�f�rance
   ModDtb.tblPosRcd ModDtb.tblCpo, "CpoId_", mCpo.Cprs(numCpr)
   cprTpeId = ModDtb.tblCpo.Fields("CpoTpeId_").Value
   
End Property



'���������������������������� COMPOSANTS SUPPORTS �����������������������������

'------------------------------------------------------------------------------
' Nombre des composants supports
'==============================================================================
Property Get CpsNbr() As Integer

   ' Contr�le la validit� des supports du composant
   If Not mCpo.CpsOk Then setCps mCpo
   
   ' Nombre de composant support
   CpsNbr = UBound(mCpo.Cpss)
   
End Property

'------------------------------------------------------------------------------
' Id des composants supports
'==============================================================================
Property Get cpsId(numLNKCPS As Integer) As Long

   ' Contr�le la validit� des supports du composant
   If Not mCpo.CpsOk Then setCps mCpo
   
   ' Id du composant support
   cpsId = mCpo.Cpss(numLNKCPS)
   
End Property

'------------------------------------------------------------------------------
' Id du type du composants support
'==============================================================================
Property Get CpsTpeId(numCps As Integer) As Long

   ' Contr�le la validit� de la liste des composants supports
   If Not mCpo.CpsOk Then setCps mCpo
   
   ' Id du type du composant support
   ModDtb.tblPosRcd ModDtb.tblCpo, "CpoId_", mCpo.Cpss(numCps)
   CpsTpeId = ModDtb.tblCpo.Fields("CpoTpeId_").Value
   
End Property

'------------------------------------------------------------------------------
' Ajout d'un composants supports
'==============================================================================
Public Sub CpsAdd(cpsId As Long)
   Dim newCps As T_Cpo
   
   ' Contr�le de la validit� des donn�es des composants de r�f�rances
   If Not mCpo.CpsOk Then setCps mCpo
   
   ' Valorisation des donn�es du nouveau composant support
   newCps.CpoId = cpsId
   setCpo newCps
   
   ' Cotr�l l'existance du lien
   If ModDtb.lnkFndId(LNKCPS, mCpo.CpoId, newCps.CpoId) = 0 Then
   
      ' Ajout du lien dans la table des composant support
      ModDtb.lnkAdd LNKCPS, mCpo.CpoId, newCps.CpoId
      
   End If
      
   ' Flag de non validit� des donn�es
   mCpo.CpsOk = False
   
End Sub

'------------------------------------------------------------------------------
' Suppression d'un composants supports
'==============================================================================
Public Sub CpsDel(cpsId As Long)

   ' Suppression du lien du composant
   ModDtb.lnkDel LNKCPS, mCpo.CpoId, cpsId
   
   ' Flag de non validit� des donn�es
   mCpo.CpsOk = False
   

End Sub



'������������������������������ TYPES REFERANCE �������������������������������

'------------------------------------------------------------------------------
' Nombre des types r�f�rance du composant
'==============================================================================
Property Get TprNbr() As Integer

   ' Contr�le la validit� des types supports du composant
   If Not mCpo.TprOk Then setTpr mCpo
   
   ' Nombre de Types support
   TprNbr = UBound(mCpo.Tprs)
   
End Property

'------------------------------------------------------------------------------
' Id des types de r�f�rance du composant
'==============================================================================
Property Get tprId(numTpr As Integer) As Long

   ' Contr�le la validit� des types de r�f�rance du composant
   If Not mCpo.TprOk Then setTpr mCpo
   
   ' Id du composant support
   tprId = mCpo.Tprs(numTpr)
   
End Property

'------------------------------------------------------------------------------
' Nom du type de r�f�rance
'==============================================================================
Property Get TprNom(numTpr As Integer) As String

   ' Contr�le la validit� des types de r�f�rance du composant
   If Not mCpo.TprOk Then setTpr mCpo
   
   ' Id du composant support
   ModDtb.tblPosRcd ModDtb.tblTpe, "TpeId_", mCpo.Tprs(numTpr)
   TprNom = ModDtb.tblTpe.Fields("TpeNom").Value
    
   
End Property

'------------------------------------------------------------------------------
' ajout d'un type de r�f�rance
'==============================================================================
Public Sub TprAdd(tprId As Long)

End Sub

'------------------------------------------------------------------------------
' Suppression d'un type de r�f�rance
'==============================================================================
Public Sub TprDel(tprId As Long)

End Sub



'������������������������������ TYPES SUPPORTS ��������������������������������

'------------------------------------------------------------------------------
' Nombre des types supports du composant
'==============================================================================
Property Get TpsNbr() As Integer

   ' Contr�le la validit� des types supports du composant
   If Not mCpo.TpsOk Then setTps mCpo
   
   ' Nombre de Types support
   TpsNbr = UBound(mCpo.Tpss)
   
End Property

'------------------------------------------------------------------------------
' Id d'un des types supports en fonction de sa position dans la liste
'==============================================================================
Property Get TpsId(numTps As Integer) As Long

   ' Contr�le la validit� des types supports du composant
   If Not mCpo.TpsOk Then setTps mCpo
   
   ' Id du type support
   If numTps > UBound(mCpo.Tpss) Then
      TpsId = 0
   Else
      TpsId = mCpo.Tpss(numTps)
   End If
   
End Property

'------------------------------------------------------------------------------
' Nom du type support
'==============================================================================
Property Get TpsNom(numTps As Integer) As String

   ' Contr�le la validit� des types de r�f�rance du composant
   If Not mCpo.TpsOk Then setTps mCpo
   
   ' Id du composant support
   ModDtb.tblPosRcd ModDtb.tblTpe, "TpeId_", mCpo.Tpss(numTps)
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
' Valorise la d�scription du composant
'==============================================================================
Private Sub setDsc(ByRef cpo As T_Cpo)
   Dim cpsId As Long
   
   ' Recherche de la d�scription du support
   ModDtb.tblPosRcd ModDtb.tblCpo, "CpoId_", cpo.CpoId
   cpo.Descr = ModDtb.tblCpo.Fields("CpoDsc").Value
   
   ' Contr�le si le composant est sur un seul support
   If cpo.IsAsf And UBound(cpo.Cpss) = 1 Then
   
      ' Ajout de la desription du composant support
      ModDtb.tblPosRcd ModDtb.tblCpo, "CpoId_", cpo.Cpss(1)
      cpo.Descr = ModDtb.tblCpo.Fields("CpoDsc").Value & " : " & cpo.Descr
      
   End If
      
   ' Mise � jour du flag
   cpo.DscOk = True
   
End Sub
         
'------------------------------------------------------------------------------
' Valorise les donn�es d'un Composant
'==============================================================================
Private Sub setCpo(ByRef cpo As T_Cpo)
      
   ' Positionnement du tblCpo
   ModDtb.tblPosRcd tblCpo, "CpoId_", CStr(cpo.CpoId)
   
   ' Valorisation des ids du composant
   cpo.tpeId = ModDtb.tblCpo.Fields("CpoTpeId_").Value
   cpo.AtrId = ModDtb.tblCpo.Fields("CpoatrId_").Value
   
   ' Positionnement du tblTpe
   ModDtb.tblPosRcd tblTpe, "TpeId_", CStr(cpo.tpeId)
   
   ' Valorisation du Niveau du composant
   cpo.Level = ModDtb.tblTpe.Fields("TpeLvl_").Value
   
   ' Flag du type de r�f�rance
   If ModDtb.tblTpe.Fields("TpeRef_").Value Then
      mCpo.IsRef = True
   Else
      mCpo.IsRef = False
   End If
   
   ' Flag du type associatif
   If ModDtb.tblTpe.Fields("TpeAsf_").Value Then
      mCpo.IsAsf = True
   Else
      mCpo.IsAsf = False
   End If
   
   
   ' Initialisation des listes
   ReDim cpo.Atrs(0): cpo.AtrOk = False
   ReDim cpo.Cprs(0): cpo.CprOk = False
   ReDim cpo.Cpss(0): cpo.CpsOk = False
   ReDim cpo.Tpss(0): cpo.TpsOk = False
   ReDim cpo.Tprs(0): cpo.TprOk = False
   
   ' Mise � jour du flag
   cpo.CpoOk = True
   
End Sub

'------------------------------------------------------------------------------
' Valorise les attributs d'un composant
'==============================================================================
Private Sub setAtr(ByRef cpo As T_Cpo)
   Dim fld As Integer
   Dim atr As Integer
      
   ' Positionnement du rstDsc
   ModDtb.tblPosRcd ModDtb.tblsAtr(cpo.tpeId), "AtrId_", cpo.AtrId
  
   ' Initialisation de la table des attributs
   ReDim cpo.Atrs(1, 0)

   ' Parcourt des champs
   For fld = 0 To ModDtb.tblsAtr(cpo.tpeId).Fields.Count - 1
      
      ' Contr�le si champs est une clef
      If Not Right(ModDtb.tblsAtr(cpo.tpeId).Fields.Item(fld).Name, 1) = "_" Then
         
         ' Ajout des noms et des valeurs dans la table des attributs
         atr = atr + 1
         ReDim Preserve cpo.Atrs(1, atr)
         cpo.Atrs(0, atr) = ModDtb.tblsAtr(cpo.tpeId).Fields(fld).Name
         On Error Resume Next
         cpo.Atrs(1, atr) = CStr(ModDtb.tblsAtr(cpo.tpeId).Fields(fld).Value)
         
      End If
      
   Next fld
   
   ' Mise � jour du flag
   cpo.AtrOk = True
   
End Sub

'------------------------------------------------------------------------------
' Recherche les Id des composant de r�f�rance d'un composant
'==============================================================================
Private Sub setCpr(cpo As T_Cpo)
   Dim rstRef As New ADODB.Recordset
   Dim numRef As Integer
   
   ' Initialisation de la liste des composant de r�f�rance
   ReDim cpo.Cprs(0)
   
   ' Ouverture du rst
   Set rstRef = ModDtb.PrcRun("QryCpr", cpo.CpoId)
   
   ' Ajout des id dans la liste des composant de r�f�rance
   While Not rstRef.EOF
   
      numRef = numRef + 1
      ReDim Preserve cpo.Cprs(numRef)
      cpo.Cprs(numRef) = rstRef.Fields("Id").Value
      
      ' Composant de r�f�rance suivant
      rstRef.MoveNext
      
   Wend

   ' D�sallocation
   rstRef.Close
   Set rstRef = Nothing
   
   ' Mise � jour du flag
   cpo.CprOk = True
   
End Sub

'------------------------------------------------------------------------------
' Recherche des Id des composants support d'un composant
'==============================================================================
Private Sub setCps(cpo As T_Cpo)
   Dim rstSup As New ADODB.Recordset
   Dim numSup As Integer
   
   ' Initialisation de la liste des composant Support
   ReDim cpo.Cpss(0)
   
   ' contr^loe si le composant est un composant de r�f�rance
   If cpo.IsRef Then
   
      ' Recherche des coposants qui font r�f�rance au composant
      Set rstSup = ModDtb.PrcRun("QryCpl", cpo.CpoId)
      
   Else
        
      ' Recherche des composants supports
      Set rstSup = ModDtb.PrcRun("QryCps", cpo.CpoId)
      
   End If
   
   ' Parcourt des composants supports
   While Not rstSup.EOF
   
      ' Ajout du nouveau support dans la liste
      numSup = numSup + 1
      ReDim Preserve cpo.Cpss(numSup)
      cpo.Cpss(numSup) = rstSup.Fields("Id").Value
      
      ' Composant support suivant
      rstSup.MoveNext
      
   Wend

   ' D�sallocation
   rstSup.Close
   Set rstSup = Nothing
   
   ' Mise � jour du flag
   cpo.CpsOk = True
   
End Sub

'------------------------------------------------------------------------------
' Recherche des Id des types qui peuvent �tre supports du composant
'==============================================================================
Private Sub setTps(cpo As T_Cpo)
   Dim tblTpeSup As New ADODB.Recordset
   Dim numCpoSup As Integer
   
   ' Initialisation de la liste des types support du composant
   ReDim cpo.Tpss(0)
   
   ' Ouverture du rst
   Set tblTpeSup = ModDtb.PrcRun("QryTps", cpo.tpeId)
   
   ' Parcourt des types supports
   While Not tblTpeSup.EOF
   
      ' Ajout du nouveau type dans la liste
      numCpoSup = numCpoSup + 1
      ReDim Preserve cpo.Tpss(numCpoSup)
      cpo.Tpss(numCpoSup) = tblTpeSup.Fields("Id").Value
      
      ' Type support suivant
      tblTpeSup.MoveNext
      
   Wend

   ' D�sallocation
   tblTpeSup.Close
   Set tblTpeSup = Nothing
   
   ' Mise � jour du flag
   cpo.TpsOk = True
   
End Sub

'------------------------------------------------------------------------------
' Recherche des Id des types des de r�f�rance
'==============================================================================
Private Sub setTpr(cpo As T_Cpo)
   Dim lstTpr As New ADODB.Recordset
   Dim numTpr As Integer
   
   ' Initialisation de la liste des types support du composant
   ReDim cpo.Tprs(0)
   
   ' Ouverture du rst
   Set lstTpr = ModDtb.PrcRun("QryTpr", cpo.tpeId)
   
   ' Parcourt des types de r�f�rance
   While Not lstTpr.EOF
   
      ' Ajout du nouveau type dans la liste
      numTpr = numTpr + 1
      ReDim Preserve cpo.Tprs(numTpr)
      cpo.Tprs(numTpr) = lstTpr.Fields("Id").Value
      
      ' Type support suivant
      lstTpr.MoveNext
      
   Wend

   ' D�sallocation
   lstTpr.Close
   Set lstTpr = Nothing
   
   ' Mise � jour du flag
   cpo.TprOk = True
   
End Sub

'------------------------------------------------------------------------------
' Recherche l'Id du type d'un composant
'==============================================================================
Private Function fndCpoTpeId(CpoId As Long)

   ' Positionnement dans la table des composants
   ModDtb.tblPosRcd ModDtb.tblCpo, "CpoId_", CpoId
   
   ' Recherche de la valeur du champs
   fndCpoTpeId = ModDtb.tblCpo.Fields("CpoTpeId_").Value
   
End Function
