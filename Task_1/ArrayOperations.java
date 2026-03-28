public class ArrayOperations { 
    public static void main(String[] args) { 
        int[] numbers = {5, 2, 9, 1, 5}; 
        int sum = 0; 
        for(int n : numbers) { 
            sum += n; 
        } 
        System.out.println("Array sum: " + sum); 
    } 
} 