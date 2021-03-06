using System                         ;
using System.Collections             ;
using System.Collections.ObjectModel ;
using System.Management.Automation   ;

namespace PSC
{
class C_PSC_Exec
{
   #region    ********** [ MEMBERS     ] ******************************************************************************     
   //                                                                               -----------------------------------
   private Collection<PSObject> myOUT = null ;                                                //
   //                                                                               -----------------------------------   
   #endregion *********************************************************************************************************         
   #region    ********** [ INTERFACE   ] ******************************************************************************     
   public void PS_Invoke(string sScript = "") { myPS_Invoke(sScript) ; }
   #endregion *********************************************************************************************************   
   #region    ********** [ PRIVATE     ] ******************************************************************************     
   private void myPS_Invoke(string sScript = "")   {
      /*----------------------------------------------------------------------------*/
      /*----------------------------------------------------------------------------*/
      PowerShell oPse = PowerShell.Create()  ;                                      //
      //                                                                            -----------------------------------
      oPse.AddScript(sScript)                ;                                      //
      //                                                                            -----------------------------------      
      foreach (PSObject R in oPse.Invoke())  {                                      //
          Console.WriteLine("{0}", R)   ;                                      //
      }                                                                             //
      //                                                                            -----------------------------------      
   }
   #endregion *********************************************************************************************************
}   
}