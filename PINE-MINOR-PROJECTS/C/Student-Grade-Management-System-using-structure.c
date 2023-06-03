#include <stdio.h>

// Define the structure for a student
struct Student {
    int id;
    char name[50];
    int marks;
};

// Function to read student details
void readStudentDetails(struct Student *student) {
    printf("Enter student ID: ");
    scanf("%d", &(student->id));

    printf("Enter student name: ");
    scanf("%s", student->name);

    printf("Enter student marks: ");
    scanf("%d", &(student->marks));
}

// Function to display student details
void displayStudentDetails(const struct Student *student) {
    printf("Student ID: %d\n", student->id);
    printf("Student Name: %s\n", student->name);
    printf("Student Marks: %d\n", student->marks);
}

int main() {
    struct Student student;

    // Read and display student details
    readStudentDetails(&student);
    printf("\nStudent Details:\n");
    displayStudentDetails(&student);

    return 0;
}
