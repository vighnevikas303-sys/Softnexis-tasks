
public class TemperatureConverter { 
    public static void main(String[] args) { 
        double fahrenheit = 98.6; 
        double celsius = (fahrenheit - 32) * 5/9; 
        System.out.printf("%.2f°F = %.2f°C\n", fahrenheit, celsius); 
    } 
} 