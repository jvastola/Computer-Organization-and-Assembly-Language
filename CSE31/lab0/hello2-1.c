#include <stdio.h>

int main () {
   char name[20];

    printf("Please enter your name: ");
    scanf("%[^\n]s", name);

    printf("Welcome to CSE031,%s!\n", name);

   return(0);
}
