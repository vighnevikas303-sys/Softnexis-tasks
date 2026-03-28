public class CircleOperations { 
    public static void main(String[] args) { 
        double radius = 7.5; 
        System.out.printf("Circumference: %.2f\n", 
calculateCircumference(radius)); 
        System.out.printf("Area: %.2f\n", calculateArea(radius)); 
    } 
     
    static double calculateCircumference(double r) { 
        return 2 * Math.PI * r; 
    } 
     
    static double calculateArea(double r) { 
        return Math.PI * r * r; 
    } 
} 