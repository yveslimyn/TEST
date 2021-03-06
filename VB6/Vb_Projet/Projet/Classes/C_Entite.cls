VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "C_Entite"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit



'������������������������������� Types membres ��������������������������������

'------------------------------------------------------------------------------
' Structure de donn�e d'une entit�
'==============================================================================
Private Type T_Ent
   
   LstCpos() As C_Composant   ' Liste des composants de l'entit�
   LstAtrs() As Integer       ' Liste des attributs des composants par nivaux
   nbrAtr As Integer          ' Nombre d'attributs
   IsSet As Boolean           ' Flag d'initialisation de l'entit�
   
End Type



'������������������������������ DONNEES MEMBRES �������������������������������

'------------------------------------------------------------------------------
' Entit�
'==============================================================================
Dim mEnt As T_Ent



'��������������������������� PROPRIETE ET METHODE �����������������������������

'------------------------------------------------------------------------------
' D�finis l'Id du composant principal et initialise l'entit�
'==============================================================================
Property Get EntId() As Long

   If mEnt.IsSet Then
      
      ' Valorisation de la propri�t�
      EntId = mEnt.LstCpos(0).CpoId
      
   Else
   
      ' Si la propriete m'est pas initialis�e
      EntId = 0
      
   End If
      
End Property
Property Let EntId(id As Long)
   
   If id > 0 Then
   
      ' Initialisation de l'entit� avec les valeurs des composants
      setEnt mEnt, id
      
   Else
   
      ' Reset de l'entit�
      delEnt mEnt
   
   End If
   
End Property



'��������������������������������� ATTRIBUTS ����������������������������������

'------------------------------------------------------------------------------
' Nombre d'attributs
'==============================================================================
Property Get AtrNbr() As Integer

   AtrNbr = mEnt.nbrAtr

End Property

'------------------------------------------------------------------------------
' Nom d'un attributs
'==============================================================================
Property Get AtrNom(numAtr As Integer) As String
   
   AtrNom = mEnt.LstCpos(mEnt.LstAtrs(0, numAtr)).AtrNom(mEnt.LstAtrs(1, numAtr))

End Property

'------------------------------------------------------------------------------
' Valeur d'un attributs
'==============================================================================
Property Get AtrVal(numAtr As Integer) As String
   
   AtrVal = mEnt.LstCpos(mEnt.LstAtrs(0, numAtr)).AtrVal(mEnt.LstAtrs(1, numAtr))

End Property
Property Let AtrVal(numAtr As Integer, valeur As String)
   
   ' Mise � jour du composant et de la table de d�scription du composant
   mEnt.LstCpos(mEnt.LstAtrs(0, numAtr)).AtrVal(mEnt.LstAtrs(1, numAtr)) = valeur

End Property



'������������������������������ TYPES SUPPORTS ��������������������������������

'------------------------------------------------------------------------------
' Nombre de types supports
'==============================================================================
Property Get TpsNbr() As Integer

   ' Nombre de types support dans la liste
   TpsNbr = mEnt.LstCpos(0).TpsNbr

End Property

'------------------------------------------------------------------------------
' Id d'un des types supports
'==============================================================================
Property Get TpsId(numTps As Integer) As Long

   ' Id d'un des types support en fonction de son num�ro dans la liste
   TpsId = mEnt.LstCpos(0).TpsId(numTps)

End Property

'------------------------------------------------------------------------------
' Nom d'un des types supports
'==============================================================================
Property Get TpsNom(numTps As Integer) As String
   
   ' Nom d'un des type support en fonction de son num�ro dans la liste
   ModDtb.rstSetPos ModDtb.rstTpe, "TpeId_", mEnt.LstCpos(0).TpsId(numTps)
   TpsNom = ModDtb.rstTpe.Fields("TpeNom").Value

End Property




'��������������������������������� Methodes �����������������������������������

'------------------------------------------------------------------------------
' Affiche les attributs de l'entit� dans un jeux de testbox et labels
'==============================================================================
Public Sub atrAffiche(ByRef lbl As Variant, ByRef txt As Variant)
   Dim atr As Integer
      
   ' Initialisation des lables et txtbox
   ModLbl.AtrIni lbl, txt, mEnt.nbrAtr
   
   ' Parcourt des attributs
   For atr = 1 To mEnt.nbrAtr
            
      ' Ins�rtion des noms et des valeurs des attributs de chaque composant de l'entit�
      lbl(atr).Caption = mEnt.LstCpos(mEnt.LstAtrs(0, atr)).AtrNom(mEnt.LstAtrs(1, atr)) & "  :     "
      txt(atr).Text = mEnt.LstCpos(mEnt.LstAtrs(0, atr)).AtrVal(mEnt.LstAtrs(1, atr))
            
   Next atr
   
End Sub

Public Sub EntVide()

   ' D�salocation des composants de l'entit�
   delEnt mEnt
   
End Sub



'���������������������������������� Outils �����������������������������������

'------------------------------------------------------------------------------
' Cr�ation de la table des attribut en ind�xant chaque attribut de tous les
' composants de l'entit� par ordre de niveau (lvl)
'==============================================================================
Private Sub setAtr(ByRef ent As T_Ent)
   Dim lvl As Long
   Dim cpo As Integer
   Dim atrCpo As Integer
   Dim atrEnt As Integer
   
   ' Initialisation de la liste des attributs (groupement des attributs des composants)
   ReDim ent.LstAtrs(1, 0)
   ent.nbrAtr = 0
   
   ' Recherche du niveau maximum des composants
   For cpo = 0 To UBound(ent.LstCpos)
      If ent.LstCpos(cpo).TpeLvl > lvl Then
         lvl = ent.LstCpos(cpo).TpeLvl
      End If
   Next cpo
   
   ' Parcourt des niveaux
   While lvl > 0
      
      ' Parcourt de liste des composants
      For cpo = 0 To UBound(ent.LstCpos)
         
         ' Contr�le du niveau
         If ent.LstCpos(cpo).TpeLvl = lvl Then
                  
            ' Ind�xation des attribut du composant
            For atrCpo = 1 To ent.LstCpos(cpo).AtrNbr
            
               ' Redimentionnement de la liste des index des attributs
               atrEnt = atrEnt + 1
               ReDim Preserve ent.LstAtrs(1, atrEnt)
               
               ' Ajout de l'index du composant et de l'index de l'attribut
               ent.LstAtrs(0, atrEnt) = cpo
               ent.LstAtrs(1, atrEnt) = atrCpo
               ent.nbrAtr = ent.nbrAtr + 1
               
            Next atrCpo
            
         End If
         
      Next cpo
      
      lvl = lvl - 1
      
   Wend

End Sub

'------------------------------------------------------------------------------
' Ajout des composant de r�f�rance du coposant principal
'==============================================================================
Private Sub setRef(ByRef ent As T_Ent)
   Dim numCpo As Integer
   Dim lstIdRef() As Long
   Dim numLNKCPR As Integer
   
   ' Recherche du d�rnier composant de la liste
   numCpo = UBound(ent.LstCpos)
   
   ' Cr�ation de la liste des id des composants de r�f�rance
   ReDim lstIdRef(0)
   For numLNKCPR = 1 To ent.LstCpos(numCpo).CprNbr
      ReDim Preserve lstIdRef(numLNKCPR)
      lstIdRef(numLNKCPR) = ent.LstCpos(numCpo).cprId(numLNKCPR)
   Next numLNKCPR
   
   ' Ins�rtion des composants de r�f�rance dans la liste
   While numLNKCPR > 1
   
      numCpo = numCpo + 1
      ReDim Preserve ent.LstCpos(numCpo)
      Set ent.LstCpos(numCpo) = New C_Composant
      ent.LstCpos(numCpo).CpoId = lstIdRef(numLNKCPR - 1)
      
      ' Ajout des composants de r�f�rance du composant de r�f�rance
      ' setRef ent
      
      ' Composant de r�f�rance suivant
      numLNKCPR = numLNKCPR - 1
   
   Wend
   
End Sub

'------------------------------------------------------------------------------
' Initialise l'entit� � partir de l'id du composant de base
'==============================================================================
Private Sub setEnt(ent As T_Ent, id As Long)

   ' Initialisation de l'entite
   delEnt ent
   
   ' Initialisation de la liste des composants avec le composant principal de l'entit�
   Set ent.LstCpos(0) = New C_Composant
   ent.LstCpos(0).CpoId = id
   
   ' Cr�ation de la liste des composants de r�f�rance
   setRef ent
   
   ' Cr�ation de la liste des attributs
   setAtr ent
   
   ' Mise � jour du flag
   ent.IsSet = True
 
End Sub

'------------------------------------------------------------------------------
' D�sallocation des donn�es membres
'==============================================================================
Private Sub delEnt(ent As T_Ent)
   Dim numCpo As Integer
   
   If ent.IsSet Then
   
      ' D�sallocation des composants
      For numCpo = 0 To UBound(ent.LstCpos)
         Set ent.LstCpos(numCpo) = Nothing
      Next numCpo
   
   End If
   
   ' Redimentionnement de laliste des composants
   ReDim ent.LstCpos(0)
   
   ' Initialisation de la liste des attributs
   ReDim ent.LstAtrs(0)
   
   ' Initialisation du nombre d'attributs
   ent.nbrAtr = 0
   
   ' Mise � jour du flag
   ent.IsSet = False
   
End Sub


