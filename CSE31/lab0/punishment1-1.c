#include <stdio.h>

int main () {
   int num;
       scanf("%d", &num);
    if(num<0){
     printf("You entered an incorrect value for the number of lines!\n");
    }
    else{

    for( int i=0; i< num; i++ ){
        printf("C programming language is the best! ");
      }
    }

    return(0);
}
