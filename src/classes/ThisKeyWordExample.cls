public class ThisKeyWordExample
{
    String str  = 'Test Me';
   
    public void strMethod(String str)
    {
        System.debug('--Parameter Value--'+str);
        System.debug('--Current Instance Value--'+this.str);
    }
   
}