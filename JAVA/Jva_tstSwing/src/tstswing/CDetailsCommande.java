package tstswing;

/**
 * Title:        Test de l'interface swing
 * Description:
 * Copyright:    Copyright (c) 2002
 * Company:      _
 * @author Yves Delay
 * @version 1.0
 */

public class CDetailsCommande implements ListModel
  {

  // Instanciation
  public CDetailsCommande() {}

  // Impl�mentation de ListModel
  public CCommande getElementAt(int index)                      { return myGetElement(int index) ;  }
  public int       getSize()                                    {}
  public void      voidaddListDataListener(ListDataListener�l)  {} ��������
  public void      removeListDataListener(ListDataListener�l)   {}



  /***************************************************************************/



  }
