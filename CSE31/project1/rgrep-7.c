#include <stdio.h>
#define MAXSIZE 4096

/**
 * You can use this recommended helper function
 * Returns true if pline matches pattern, starting from
 * the first char of pline.
 */
int check_match(char *pline, char *pattern) {

    if(!*pattern){ /** base case:finished pattern=match */
        return 1;
    }
    if(!*pline ){ /** base case: finished string no match */
        return 0;
    }
    if(*pattern == '\\'){/** backslash case: i could have made this shorter or better lol */
        if(*(pattern+1) == *pline ){
            if(*(pattern+2)=='?'){
                return check_match(pline,pattern+1);
            }
             return check_match(pline+1,pattern+2);
        }
        if(*(pattern+1) == '.' || *(pattern+1) == '?' || *(pattern+1) == '\\' ||*(pattern+1) == '+' ){
            if(*(pattern+2) == '?'){
                 return check_match(pline,pattern+3);
            }
        }
        if(*(pattern+1) !=*pline){
            if(*(pattern+2)=='?'){
                return check_match(pline,pattern+1);
            }
        }
    }
    if(*(pattern+1) == '?'){/** check past and now ? to see which line char to compare*/
        if(*(pattern+2) == *(pline+1)){
            if( *pattern==*pline ||*pattern=='.'){
                return check_match(pline+1,pattern+1 );
            }
        }
        return check_match(pline,pattern+1);
    }
    if(*pattern == '?'){/** incase for backslash and normal increment*/
        return check_match(pline,pattern+1);
    }
    if(*pattern =='+'){ /**check prev loop again until new char*/
        if(*(pline-1) == *pline){
            return check_match(pline+1,pattern);
        }
        if(*(pattern-1)==*(pattern+1)){/** if gone too far*/
            return check_match(pline-1,pattern+1);
        }
        return check_match(pline,pattern+1);
    }
    if(*pline == *pattern || *pattern== '.'){/** standard character matched*/
        return check_match(pline+1,pattern+1);
    }
  return 0;
}
/**
 * You may assume that all strings are properly null terminated
 * and will not overrun the buffer set by MAXSIZE
 *
 * Implementation of the rgrep matcher function
 */
int rgrep_matches(char *line, char *pattern) {
    while(*line){/** not null character*/
        if(check_match(line,pattern)){
            return 1;
        }
        line++; //* increment */
    }
    return 0;
}

int main(int argc, char **argv) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <PATTERN>\n", argv[0]);
        return 2;
    }

    /* we're not going to worry about long lines */
    char buf[MAXSIZE];

    while (!feof(stdin) && !ferror(stdin)) {
        if (!fgets(buf, sizeof(buf), stdin)) {
            break;
        }
        if (rgrep_matches(buf, argv[1])) {
            fputs(buf, stdout);
            fflush(stdout);
        }
    }

    if (ferror(stdin)) {
        perror(argv[0]);
        return 1;
    }

    return 0;
}
