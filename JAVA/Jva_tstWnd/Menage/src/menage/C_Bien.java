package menage;

/**
 * Title:        Menage
 * Description:
 * Copyright:    Copyright (c) 2001
 * Company:      _
 * @author Yves Delay
 * @version 1.0
 */

import java.lang.* ;

public abstract class C_Bien
   {

   // Membres
   private int prixAchat ;
   private String marque ;

   // Setter
   public void PrixAchat(int prx)      { prixAchat = prx ; }
   public void Marque(String mrq)      { marque = mrq ;    }

   // Getter
   public int PrixAchat()              { return prixAchat;  }
   public String Marque()              { return marque ;    }

   // Constructeurs
   public C_Bien()                     { PrixAchat(0); Marque("");                        }
   public C_Bien(int prx, String mrq)  { PrixAchat(prx); Marque(mrq);                     }
   public C_Bien(C_Bien b)             { PrixAchat(b.PrixAchat()); Marque(b.Marque());    }

   // Methodes
   public double prixVente()           { return prixAchat/2; }

   }