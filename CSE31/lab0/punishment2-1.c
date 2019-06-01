#include <stdio.h>

int main () {
  int num;
  int typo;
    printf("Enter the numberof lines for the punishment:\n");
      scanf("%d", &num);
    printf("Enter the line for which we want to makea typo:\n");
      scanf("%d", &typo);

    if(num<0){
     printf("You entered an incorrect value for the number of lines!\n");
     return 0;
    }
    if(typo<0){
      printf("You entered an incorrect value for the line typo!\n");
      return 0;
    }
      for( int i=0; i< num; i++ ){
        if(typo==num){
          printf("C programming language is the bet!\n");
        }
        printf("C programming language is the best! ");
      }

    return(0);
}
