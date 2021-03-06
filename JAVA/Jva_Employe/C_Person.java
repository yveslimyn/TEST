package Employe;

/*======================================================================================================================
   Description:
      Classe de base pour l'encapsulation des donn�es d'une personne.

======================================================================================================================*/

public class C_Person
  {

   /* Constructeurs
   -------------------------------------------------------------------------------------------------------------------*/
   public C_Person()                                                       { myInit() ;                                 }
   public C_Person(String firstName, String lastName, double birthDay)     { myInit(firstName, lastName, birthDay) ;    }

   /* Setters
   -------------------------------------------------------------------------------------------------------------------*/
   public void setFirstName(String firstName)                              { myFirstName = new String(firstName) ;      }
   public void setLastName(String lastName)                                { myLastName = new String(lastName) ;        }
   public void setBirthDay(double birthDay)                                { myBirthDay = birthDay ;                    }

   /* Getters
   -------------------------------------------------------------------------------------------------------------------*/
   public String getFirstName()                                            { return myFirstName ;                       }
   public String getLastName()                                             { return myLastName ;                        }
   public double getBirthDay()                                             { return myBirthDay ;                        }

   /* Membres
   -------------------------------------------------------------------------------------------------------------------*/
   private String myFirstName ;
   private String myLastName ;
   private double myBirthDay ;

   /* Initialisation de la class
   -------------------------------------------------------------------------------------------------------------------*/
   private void myInit()
      {
      setFirstName("") ;
      setLastName("") ;
      setBirthDay(0) ;
      }
   private void myInit(String firstName, String lastName, double birthDay)
      {
      setFirstName(firstName) ;
      setLastName(lastName) ;
      setBirthDay(birthDay) ;
      }


   }