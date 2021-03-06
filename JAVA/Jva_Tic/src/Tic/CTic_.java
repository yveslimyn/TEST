package Tic;

import java.lang.*;
import java.awt.* ;
import java.awt.event.* ;
import java.math.* ;

/**
 * Title:        Tic
 * Description:
 * Copyright:    Copyright (c) 2002
 * Company:
 * @author Yves Delay
 * @version 1.0
 */

public class CTic_ extends Frame
  implements ActionListener, WindowListener
  {

  /*----- Membres -----------------------------------------------------------*/
  private int         Sze = 5 ; // Taille de la grille
  private CBtn[][]    Btns ;    // Matrice de bouttons
  private CJeux       Jeux ;    // Param�tre du jeux

  /*----- Impl�mentation des interfaces --------------------------------------*/
  public void actionPerformed   (ActionEvent ae) {  Checker() ;   }
  public void windowActivated   (WindowEvent we) {}
  public void windowClosed      (WindowEvent we) {  this.hide() ; }
  public void windowClosing     (WindowEvent we) {  this.hide() ; }
  public void windowDeactivated (WindowEvent we) {}
  public void windowDeiconified (WindowEvent we) {}
  public void windowIconified   (WindowEvent we) {}
  public void windowOpened      (WindowEvent we) {}

  /*----- Instanciation -----------------------------------------------------*/
  public CTic_()                                 { super(); newIst(); }



  /***************************************************************************/



  /*----- Cr�ation de l'instance --------------------------------------------*/
  private void newIst()
    {

    // Ajout des listener
    this.addWindowListener(this) ;

    // Dimension de la fen�tre
    this.setSize(300, 300) ;

    // D�finition du layout de panel principal
    this.setLayout(new GridLayout(Sze, Sze)) ;

    // Initialisation des param�tres du jeux
    Jeux = new CJeux(Sze) ;

    // Cr�ation de la grille des boutons
    Btns = new CBtn[Sze][Sze] ;
    for (int l=0; l<Sze; l++)
      for (int c=0; c<Sze; c++)
        {

        // Cr�ation du boutton
        Btns[l][c] = new CBtn(l, c, Jeux) ;
        Btns[l][c].addActionListener(this) ;

        // Ajout du boutton dans le composant
        this.add(Btns[l][c]) ;

        }

    }

  /*----- Controle de fin de jeux -------------------------------------------*/
  private void Checker()
    {

    if (Jeux.IsEnd())
      for (int l=0; l<Sze; l++)
        for (int c=0; c<Sze; c++)
          {
          this.Btns[l][c].setEnabled(false) ;
          System.out.println("check") ;
          }

    }



  }
