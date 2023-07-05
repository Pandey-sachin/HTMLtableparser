%{
  #include <stdio.h>
  #include <stdlib.h>  
  extern FILE *yyin;           // Declare yyin as a pointer to FILE for input file stream
  
  int yylex();                // Declare yylex function for tokenizing input
  int yyerror(char const *s)
  {
      printf("%s \n",s);    // Print error message s
      exit(0);             // Exit program with status code 0
  }

%}
%token START_TABLE STR STH STD ALNUM DIGIT END_TABLE ETR ETD ETH // Define the tokens used in the grammar


%%                                                            //Start of grammer rules 
T        : STAG { printf("input accepted \n"); exit(0); }      // Top-level rule that matches STAG and outputs a message before exiting
         ;

STAG       : START_TABLE BODY END_TABLE      // Rule that matches a table definition
         ;

BODY     : STR BODY1 ETR      // Rule that matches a table row
         | STR BODY1 ETR BODY // Rule that matches multiple table rows
         ;

BODY1    : STD DATA ETD // Rule that matches a table cell with standard alignment and data
         | STH DATA ETH  // Rule that matches a table cell with header alignment and data
         | STD DATA ETD BODY1// Rule that matches multiple table cells with standard alignment and data
         | STH DATA ETH BODY1 // Rule that matches multiple table cells with header alignment and data
         ;

DATA    : DIGIT   // Rule that matches a numeric data item
        | ALNUM   // Rule that matches an alphanumeric data item 
        | STAG     // Rule that matches a subtable definition
        ;
%%  // End of grammar rules
int main()
{
    yyin = fopen("table.txt", "r"); // Open input file "table.html"
    yyparse();                      // Parse input using the defined grammar rules
    return 0;                       // Exit program with status code 0
}