package tstgdi;

import javax.swing.UIManager;
import java.awt.*;

/**
 * Title:        Test de GDI
 * Description:
 * Copyright:    Copyright (c) 2002
 * Company:      _
 * @author Yves Delay
 * @version 1.0
 */

public class App1 {
  boolean packFrame = false;

  /**Construct the application*/
  public App1()
    {

    Frame1 frame = new Frame1();

    //Validate frames that have preset sizes
    //Pack frames that have useful preferred size info, e.g. from their layout
    if (packFrame)
      {
      frame.pack();
      }
    else
      {
      frame.validate();
      }

    //Center the window
    Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();
    Dimension frameSize = frame.getSize();
    if (frameSize.height > screenSize.height)
      {
      frameSize.height = screenSize.height;
      }
    if (frameSize.width > screenSize.width)
      {
      frameSize.width = screenSize.width;
      }
    frame.setLocation((screenSize.width - frameSize.width) / 2, (screenSize.height - frameSize.height) / 2);
    frame.setVisible(true);
    }

  /**Main method*/
  public static void main(String[] args)
    {

    // Chargement de gestionnaire graphique
    try
      { UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName()); }
    catch(Exception e)
      { e.printStackTrace(); }

    // Instanciation de l'application
    new App1();

    }

  }