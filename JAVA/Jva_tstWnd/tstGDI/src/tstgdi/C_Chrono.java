package tstgdi;

/**
 * Title:        Test de GDI
 * Description:
 * Copyright:    Copyright (c) 2002
 * Company:      _
 * @author Yves Delay
 * @version 1.0
 */

import java.awt.Canvas;
import java.awt.Graphics;
import java.awt.Dimension;

public class C_Chrono extends Canvas
  {

  public C_Chrono() {}

  public void paint(Graphics g)
    {
    Dimension dim = this.getSize() ;

    g.drawOval(10,20,30,40)  ;

    }


  }


