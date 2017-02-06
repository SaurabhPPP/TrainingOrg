/* This Class is to be used for various different purpose 
 * Created date :- 1/1/2017
 */
	public class UtilityClass {
	
        // Method which will accept Integer as parameter and determine & print the number is even or odd
        public String isEvenOrOdd(Integer num){
            String status ='';
            if(num == null)
                status = 'No Number Chosen';
            else if(Math.mod(num, 2)==0)
                status =  'Selected Number '+num+' is Even Number';
            else
                status =  'Selected Number '+num+' is Odd Number';
            //Printing the result
            System.debug('Result : '+status);
            return status;
        }
        
        //Method which will accept integer parameter and build an print array(any data type) of upto that integer parameter
        public Integer[] arrayParameter(Integer param){
            Integer[] arrayInteger = new List<Integer>();
            for(Integer i=0;i<param; i++){
                arrayInteger.add(i+10);
            }
            System.debug('Array is'+ arrayInteger);
            return arrayInteger;
        }
        
        //Sort the array in ascending order
        public Integer[] sortAscendingOrder(List<Integer> arr){
            Integer size = arr.size();
            for(Integer i=0; i<size ;i++){
                Integer min = arr[i];
                Integer tobemin = i;
                for(Integer j=i+1;j<size; j++){
                    if(min>arr[j]){
                        min = arr[j];
                        tobemin = j;
                    }
                }
                arr = swap(arr,i,tobemin);
            }
            System.debug('Sorted Array in Ascending order :'+arr);
            return arr;
        }
        
        //Sort the array in descending order
         public Integer[] sortDescendingOrder(List<Integer> arr){
            Integer size = arr.size();
            for(Integer i=0; i<size ;i++){
                Integer max = arr[i];
                Integer tobemax = i;
                for(Integer j=i+1;j<size; j++){
                    if(max<arr[j]){
                        max = arr[j];
                        tobemax = j;
                    }
                }
                arr = swap(arr,i,tobemax);
            }
            System.debug('Sorted Array in Descending order :'+arr);
            return arr;
        }
        
        //Print the Maximum number in the array
        public Integer printMaxNumber(List<Integer> arr){
        	Integer size = arr.size();
            Integer max = arr[0];
            for(Integer j=1;j<size; j++){
                    if(max<arr[j]){
                        max = arr[j];
                    }
                } 
            System.debug('Maximum number is '+max);
            return max;
        }
        
        //Print the Minimum number in the array
        public Integer printMinNumber(List<Integer> arr){
        	Integer size = arr.size();
            Integer min = arr[0];
            for(Integer j=1;j<size; j++){
                    if(min>arr[j]){
                        min = arr[j];
                    }
                } 
            System.debug('Minimum number is '+min);
            return min;
        }
        
        //Print duplicates and its occurrences in the array
        public map<Integer, Integer> printDupicate(List<Integer> arr){
            //creating a map to hold duplicate counting
            Map<Integer, Integer> mapduplicate = new Map<Integer, Integer>();
            for(Integer i=0; i<arr.size(); i++){
                
                if(mapduplicate.containsKey(arr[i]))
                    mapduplicate.put(arr[i], mapduplicate.get(arr[i])+1);
                else
                   mapduplicate.put(arr[i], 1);  
            }
            System.debug('duplicates occurrences in the array Is below\n'+mapduplicate);
            return mapduplicate;
        } 
        
        
        // Method to display the summation of numbers from zero to parameter number
        public Integer summationOfNumber(Integer param){
            
            Integer sum = (param *(param+1))/2;
            System.debug('Sum of Number from 0 to '+param+'= '+sum);
            return sum;
        }
        
        // Method which will calculate the simple interest 
        public Double calculateSimpleInterest(Integer principal ,Integer year , Integer rate){
            
            Double simpleInterest  =(Principal * year * rate )/100;
            system.debug('simple interest = '+simpleInterest);
            return simpleInterest;
        }
        
        
        private Integer[] swap(List<Integer> arr,Integer first , Integer second){
            Integer num1 = arr[first];
            Integer num2 = arr[second];
            arr.set(first ,num2);
            arr.set(second,num1);
            return arr;
        }
	}