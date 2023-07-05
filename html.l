%{
    #include "html.tab.h"
    #undef yywrap
    #define yywrap() 1
%}
digit [0-9]+
alphanum [a-zA-Z0-9]+


%%
[\n\t\ ]   ;
"<"(t|T)(a|A)(b|B)(l|L)(e|E)">"  return START_TABLE;
"</"(t|T)(a|A)(b|B)(l|L)(e|E)">"  return END_TABLE;
"<"(T|t)(r|R)">"  return STR;   
"<"(T|t)(d|D)">"  return STD;
"<"(T|t)(h|H)">"  return STH; 
"</"(T|t)(r|R)">" return ETR; 
"</"(T|t)(d|D)">" return ETD;
"</"(T|t)(h|H)">" return ETH;
{digit} return DIGIT; 
{alphanum}  {   return ALNUM;}
.         return *yytext;
%%





