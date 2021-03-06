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
   
   TpesSup() As String
   CposRef() As C_Composant
   CposSup() As C_Composant
   LvlMax As Long
   
End Type



'������������������������������ Donn�es membres �������������������������������

'------------------------------------------------------------------------------
' Entit�
'==============================================================================
Dim mEnt As T_Ent



'���������������������������������� Setter ������������������������������������



'���������������������������������� Getter ������������������������������������

'------------------------------------------------------------------------------
' Renvoie le niveau maximal des composants de l'entit�
'==============================================================================
Property Get LvlMax() As Integer

   ' Valorisation de la propri�t�
   LvlMax = mEnt.LvlMax
   
End Property

'------------------------------------------------------------------------------
' Renvoie le nombre de composant de l'entit�
'==============================================================================
Property Get CpoRefNbr() As Integer

   ' Valorisation de la propri�t�
   CpoRefNbr = UBound(mEnt.CposRef)
   
End Property

'------------------------------------------------------------------------------
' Renvoie un composant de l'entit�
'==============================================================================
Property Get CpoRef(numCpo As Integer) As C_Composant

   ' Valorisation de la r�f�rance de l'objet
   Set CpoRef = mEnt.CposRef(numCpo)

End Property

'------------------------------------------------------------------------------
' Renvoie le nombre de types support du type du composant principal
'==============================================================================
Property Get TpeSupNbr() As Integer

   ' Valorisation de la propri�t�
   TpeSupNbr = UBound(mEnt.TpesSup)
   
End Property

'------------------------------------------------------------------------------
' Renvoie un nom de type support du composant principal
'==============================================================================
Property Get TpeSupNom(numTpeSup As Integer) As String

   ' Valorisation de la r�f�rance de l'objet
   TpeSupNom = mEnt.TpesSup(numTpeSup)

End Property



'��������������������������������� Methodes �����������������������������������

'------------------------------------------------------------------------------
' Initialise l'entit� � partir du composant de base
'==============================================================================
Public Sub initialiser(firstCpoId As Long)

   ' Initialisation des tables des composants
   ReDim mEnt.CposRef(0)
   ReDim mEnt.CposSup(0)

   ' Initialisation des tables avec le composant principal de l'entit�
   Set mEnt.CposRef(0) = New C_Composant
   mEnt.CposRef(0).Id = firstCpoId
   Set mEnt.CposSup(0) = mEnt.CposRef(0)
   
   ' Cr�ation de la liste des composants de r�f�rance
   setRef mEnt
   
   ' Cr�ation de la liste des composant support
   setSup mEnt
   
   ' Cr�ation de laiste des noms des types supports
   setTpeSup mEnt
   
End Sub

'------------------------------------------------------------------------------
' D�sallocation des donn�es membres
'==============================================================================
Public Sub supprimer()
   Dim numCpo As Integer
   
   ' Parcourt de la table des composants
   For numCpo = 0 To UBound(mEnt.CposRef)
   
      ' D�sallocation des composants
      Set mEnt.CposRef(numCpo) = Nothing
   
   Next numCpo
   
End Sub



'���������������������������������� Outils �����������������������������������

'------------------------------------------------------------------------------
' Recherche les types qui peuvent �tre support du composant principal
'==============================================================================
Private Sub setTpeSup(ent As T_Ent)
   Dim rstSup As New ADODB.Recordset
   Dim numTpe As Integer
   
   ' initialisation de la table des nom des type supports
   ReDim ent.TpesSup(0)

   ' Cr�ation du rstSup
   Set rstSup = ModDtb.ExecCmdId("TpeSup", ent.CposSup(0).Id)
   
   ' Parcourt des composants supports
   While Not rstSup.EOF
   
      ' Ins�rtion des noms des types dans la liste
      numTpe = numTpe + 1
      ReDim Preserve ent.TpesSup(numTpe)
      ent.TpesSup(numTpe) = rstSup.Fields("TpeNom").Value
      
      ' Composant de r�f�rance suivant
      rstSup.MoveNext
      
   Wend

   ' D�sallocation
   rstSup.Close
   Set rstSup = Nothing
   
End Sub

'------------------------------------------------------------------------------
' Recherche les composants support d'un composant
'==============================================================================
Private Sub setSup(ent As T_Ent)
   Dim rstSup As New ADODB.Recordset
   Dim numSup As Integer
   
   ' Recherche du dernier composant de la table
   numSup = 0
   
   ' Ouverture du rst
   Set rstSup = ModDtb.ExecCmdId("CpoSup", ent.CposSup(0).Id)
   
   ' Parcourt des composants supports
   While Not rstSup.EOF
   
      ' Cr�ation d'une nouvelle instance du composant support
      numSup = numSup + 1
      ReDim Preserve ent.CposSup(numSup)
      Set ent.CposSup(numSup) = New C_Composant
      ent.CposSup(numSup).Id = rstSup.Fields("CpoId_").Value
      
      ' Composant de r�f�rance suivant
      rstSup.MoveNext
      
   Wend

' D�sallocation
   rstSup.Close
   Set rstSup = Nothing
   
End Sub

'------------------------------------------------------------------------------
' Recherche les composant de r�f�rance d'un composant
'==============================================================================
Private Sub setRef(ent As T_Ent)
   Dim rstRef As New ADODB.Recordset
   Dim numRef As Integer
   
   ' Recherche du dernier composant de la table
   numRef = UBound(ent.CposRef)
   
   ' Ouverture du rst
   Set rstRef = ModDtb.ExecCmdId("CpoRef", ent.CposRef(numRef).Id)
   
   ' Cr�ation du vecteur des niveau et recherche du niveau le plus �lev�
   While Not rstRef.EOF
   
      ' Cr�ation d'une nouvelle instance du composant de r�f�rance
      numRef = numRef + 1
      ReDim Preserve ent.CposRef(numRef)
      Set ent.CposRef(numRef) = New C_Composant
      ent.CposRef(numRef).Id = rstRef.Fields("CpoId_").Value
      
      ' Contr�le du niveau maximal de l'entit�
      If ent.LvlMax < ent.CposRef(numRef).Niveau Then
         ent.LvlMax = ent.CposRef(numRef).Niveau
      End If
      
      ' Recherche des r�f�rance du composant de r�f�rance
      setRef ent
      
      ' Composant de r�f�rance suivant
      rstRef.MoveNext
      
   Wend

' D�sallocation
   rstRef.Close
   Set rstRef = Nothing
End Sub


