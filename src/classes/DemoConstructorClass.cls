/*
 *  A constructor is code that is invoked when an object is created from the class blueprint. 
 *  You do not need to write a constructor for every class.
 *  If a class does not have a user-defined constructor, 
 *  an implicit, no-argument, public one is used.
 *  The syntax for a constructor is similar to a method, 
 *  but it differs from a method definition in that it never has an explicit return type 
 *  and it is not inherited by the object created from it.
 */ 
public class DemoConstructorClass {
    
    public static final Integer DEFAULT_ARRAYSIZE = 10;
    Integer arraySize;
    Boolean isArgument;
    
    // The no argument constructor , If there is no any constructor defined  this will be by default taken  
    public DemoConstructorClass() {
      
      this(20); // Using this(...) calls the one argument constructor DemoConstructorClass (Integer arraySize) 
      arraySize = DEFAULT_ARRAYSIZE;
      isArgument = false;
      
    }
    // A constructor with one argument
   public DemoConstructorClass (Integer arraySize) {
      this.arraySize = arraySize; 
   }

    // A constructor with two arguments
   public DemoConstructorClass (Integer arraySize, Boolean isArgument) {
        this.arraySize = arraySize; 
        this.isArgument = isArgument;
   }

   // Though this constructor has the same arguments as the 
   // one above, they are in a different order, so this is legal
   public DemoConstructorClass (Boolean isArgument, Integer arraySize) {
       this(arraySize ,isArgument); //Using this(...) calls the one argument constructor DemoConstructorClass(Integer arraySize, Boolean isArgument)
   } 
    
    
   
   
    
}