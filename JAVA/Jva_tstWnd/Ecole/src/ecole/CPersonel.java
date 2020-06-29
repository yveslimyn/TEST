package ecole;

/**
 * Title:        Ex2
 * Description:  Main
 * Copyright:    Copyright (c) 2002
 * Company:
 * @author :     Yves Delay
 * @version 1.0
 */

public abstract class CPersonel extends CPersonne
  {

  public CPersonel()
    { super(); setDepartement(""); setSalaire(0); }
  public CPersonel(String nom, int anDebut, String departement, int salaire)
    { super(nom, anDebut); setDepartement(departement); setSalaire(salaire); }

  public void setDepartement(String departement)  { Dpt = departement ;   }
  public void setSalaire(int salaire)             { Sal = salaire ; }

  public String getDepartement()                  { return Dpt ;  }
  public int    getSalaire()                      { return Sal ; }


  //---------------------------------------------------------------------------
  private String Dpt ;
  private int    Sal ;


  //---------------------------------------------------------------------------

  }