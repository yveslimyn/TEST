package Employe;

/*======================================================================================================================
   Description:
      Extension de la class employ� par l'ajout des donn�es propres aux techiciens. Du fait que les techniciens sont
      facturables, cette class impl�mente les m�thodes de l'interface I_Billing .

======================================================================================================================*/

public class C_Technician extends C_Employee implements I_Billing
   {

    /* Constructeurs
   -------------------------------------------------------------------------------------------------------------------*/
   public C_Technician()                                 { super(); myInit() ;                                          }
   public C_Technician(String firstName,
                       String lastName,
                       double birthDay,
                       int employeeId,
                       int salary)                       { super(firstName, lastName, birthDay, employeeId, salary);
                                                              myInit() ;                                                }

   /* Setters
   -------------------------------------------------------------------------------------------------------------------*/
   public void setToolKitNumber(int toolKitNumber)       { myToolKitNumber = toolKitNumber ;                            }

   /* Getter
   -------------------------------------------------------------------------------------------------------------------*/
   public int getToolKitNumber()                         { return myToolKitNumber ;                                     }

    /* Impl�mentation de l'interface I_Billing
   -------------------------------------------------------------------------------------------------------------------*/
   public void    setClientName(String name)             { myClientName = name ;                                        }
   public String  getClientName()                        { return myClientName ;                                        }
   public int     getHoursWork()                         { return myHoursWork ;                                         }
   public void    addHoursWork(int hours)                { myHoursWork += hours ;                                       }
   public void    resetHoursWork()                       { myHoursWork = 0 ;                                            }

   /* Membres
   -------------------------------------------------------------------------------------------------------------------*/
   private String myClientName ;    // Nom du client (pour l'interface I_Billing)
   private int    myHoursWork ;     // Heures de travail (pour l'interface I_Billing)
   private int    myToolKitNumber ; // num�ro de caisse � outils

   /* Initialisation de la class
   -------------------------------------------------------------------------------------------------------------------*/
   private void myInit()
      {
      setClientName("uknow") ;
      resetHoursWork() ;
      setToolKitNumber(0) ;
      }



   }