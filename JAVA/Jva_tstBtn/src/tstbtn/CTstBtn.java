package tstbtn;

import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

public class CTstBtn extends JFrame
  {
  JPanel contentPane;
  BorderLayout borderLayout1 = new BorderLayout();
  JPanel jPanel1 = new JPanel();
  GridLayout gridLayout1 = new GridLayout();
  JButton jButton1 = new JButton();
  JButton jButton2 = new JButton();
  JButton jButton3 = new JButton();
  JButton jButton4 = new JButton();

  // Constructeur
  public CTstBtn()
    {
    enableEvents(AWTEvent.WINDOW_EVENT_MASK);
    try { jbInit(); }
    catch(Exception e)
      { e.printStackTrace(); }
    }
  // Fin du constructeur

  // Initialisation du composant
  private void jbInit() throws Exception
    {

    //setIconImage(Toolkit.getDefaultToolkit().createImage(CTstBtn.class.getResource("[Your Icon]")));
    contentPane = (JPanel) this.getContentPane();
    contentPane.setLayout(borderLayout1);
    this.setSize(new Dimension(400, 300));
    this.setTitle("Frame Title");
    jPanel1.setLayout(gridLayout1);
    borderLayout1.setHgap(2);
    borderLayout1.setVgap(2);
    gridLayout1.setRows(2);
    gridLayout1.setColumns(2);
    gridLayout1.setHgap(2);
    jButton1.setText("jButton1");
    jButton1.addMouseListener(new CTstBtn_jButton1_mouseAdapter(this));
    jButton2.setText("jButton2");
    jButton3.setText("jButton3");
    jButton4.setText("jButton4");
    contentPane.add(jPanel1, BorderLayout.CENTER);
    jPanel1.add(jButton1, null);
    jPanel1.add(jButton3, null);
    jPanel1.add(jButton2, null);
    jPanel1.add(jButton4, null);
    }
  // Fin de l'initialisation du composant

  // Evenement de fermeture du composant
  protected void processWindowEvent(WindowEvent e)
    {
    super.processWindowEvent(e);
    if (e.getID() == WindowEvent.WINDOW_CLOSING)
      {
      System.exit(0);
      }

    }
  // Fin de l'evenemnt de fermeture

  // Pression du boutton 1
  void jButton1_mouseClicked(MouseEvent e)
    {
    jButton1.setLabel("Nouvau");
    }
  // Fin de l'evenement

  }
// Fin de la classe


class CTstBtn_jButton1_mouseAdapter extends java.awt.event.MouseAdapter {
  CTstBtn adaptee;

  CTstBtn_jButton1_mouseAdapter(CTstBtn adaptee)
    {
    this.adaptee = adaptee;
    }

  public void mouseClicked(MouseEvent e)
    {
    adaptee.jButton1_mouseClicked(e);
    }

}

