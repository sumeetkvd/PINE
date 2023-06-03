// Encapsulation:

class Person {
private:
    std::string name;
    int age;

public:
    void setName(const std::string& newName) {
        name = newName;
    }

    std::string getName() const {
        return name;
    }

    void setAge(int newAge) {
        age = newAge;
    }

    int getAge() const {
        return age;
    }
};

// --------------------------------------------- //

// Inheritance:

class Shape {
protected:
    double area;

public:
    virtual double calculateArea() = 0;
};

class Rectangle : public Shape {
private:
    double length;
    double width;

public:
    Rectangle(double len, double wid) : length(len), width(wid) {}

    double calculateArea() override {
        area = length * width;
        return area;
    }
};

// ---------------------------------------------- //

// Polymorphism:

class Shape {
public:
    virtual double calculateArea() = 0;
};

class Rectangle : public Shape {
private:
    double length;
    double width;

public:
    Rectangle(double len, double wid) : length(len), width(wid) {}

    double calculateArea() override {
        return length * width;
    }
};

class Circle : public Shape {
private:
    double radius;

public:
    Circle(double rad) : radius(rad) {}

    double calculateArea() override {
        return 3.14 * radius * radius;
    }
};

void printArea(Shape* shape) {
    double area = shape->calculateArea();
    std::cout << "Area: " << area << std::endl;
}

// ------------------------------------------------------------------------- //

// Abstraction: 

class Animal {
public:
    virtual void makeSound() = 0; // Pure virtual function (interface)
};

class Dog : public Animal {
public:
    void makeSound() override {
        cout << "Woof!" << endl;
    }
};

class Cat : public Animal {
public:
    void makeSound() override {
        cout << "Meow!" << endl;
    }
};

int main() {
    Animal* animal1 = new Dog();
    Animal* animal2 = new Cat();

    animal1->makeSound(); // Output: Woof!
    animal2->makeSound(); // Output: Meow!

    delete animal1;
    delete animal2;

    return 0;
}


