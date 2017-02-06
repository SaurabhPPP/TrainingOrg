public interface CalculatorInterface {
    
    //Write a method which will accept following parameters & return the result :
	//Parameter: String : (Value here will be any of the following :
	//‘SUM’,’SUB’,’MUL’,’DIV’)
	//Parameter: Two integers :
	//Example :
	//Integer result = Calculator(‘SUM’, 2 ,3);
	// here the result will be 5
     String  calculator(String Operation , Integer inp1 , Integer inp2);

}