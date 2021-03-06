package tstwnd;

import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

public class C_Frm extends JFrame {
   JPanel contentPane;
   BorderLayout borderLayout1 = new BorderLayout();

   /**Construct the frame*/
   public C_Frm() {
      enableEvents(AWTEvent.WINDOW_EVENT_MASK);
      try {
         jbInit();
      }
      catch(Exception e) {
         e.printStackTrace();
      }
   }
   /**Component initialization*/
   private void jbInit() throws Exception  {
      //setIconImage(Toolkit.getDefaultToolkit().createImage(C_Frm.class.getResource("[Your Icon]")));
      contentPane = (JPanel) this.getContentPane();
      contentPane.setLayout(borderLayout1);
      this.setSize(new Dimension(400, 300));
      this.setTitle("Frame Title");
   }
   /**Overridden so we can exit when window is closed*/
   protected void processWindowEvent(WindowEvent e) {
      super.processWindowEvent(e);
      if (e.getID() == WindowEvent.WINDOW_CLOSING) {
         System.exit(0);
      }
   }
}