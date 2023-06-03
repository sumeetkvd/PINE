// Function Overloading:

#include <iostream>

void print(int num) {
    std::cout << "Printing an integer: " << num << std::endl;
}

void print(double num) {
    std::cout << "Printing a double: " << num << std::endl;
}

void print(const std::string& str) {
    std::cout << "Printing a string: " << str << std::endl;
}

int main() {
    print(42);             // Output: Printing an integer: 42
    print(3.14);           // Output: Printing a double: 3.14
    print("Hello, World!"); // Output: Printing a string: Hello, World!

    return 0;
}

// ------------------------------------------------------------------------- //

// Operator Overloading

#include <iostream>

class Complex {
private:
    double real;
    double imag;

public:
    Complex(double r, double i) : real(r), imag(i) {}

    Complex operator+(const Complex& other) {
        double sumReal = real + other.real;
        double sumImag = imag + other.imag;
        return Complex(sumReal, sumImag);
    }

    bool operator==(const Complex& other) {
        return (real == other.real) && (imag == other.imag);
    }

    void display() {
        std::cout << real << " + " << imag << "i" << std::endl;
    }
};

int main() {
    Complex c1(3.5, 2.5);
    Complex c2(2.1, 1.9);

    Complex sum = c1 + c2;
    sum.display(); // Output: 5.6 + 4.4i

    bool isEqual = c1 == c2;
    std::cout << "Are the complex numbers equal? " << std::boolalpha << isEqual << std::endl; // Output: Are the complex numbers equal? false

    return 0;
}
