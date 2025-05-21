// Import section
import java_cup.runtime.*;

%%

// Options and declarations section
%class MPLexer

%cup

%line
%column

// Constructor
%eofval{
    return new Symbol( sym.EOF );
%eofval}

// Additional class members
%{
    public int getLine()
    {
        return yyline;
    }
%}

// States
%state COMMENT

// Macros
digit = [0-9]
digit_seq = (0|[1-9]{digit}*)
letter = [A-Za-z]
char = ({digit}|{letter})
char_seq = {char}+

%%

// Rules section

// Comment
"<-comm"                        { yybegin( COMMENT ); }
<COMMENT>~"comm->"               { yybegin( YYINITIAL ); }

// Whitespace
[\t\n\r ] 			            { ; }


// Brackets
\(                              { return new Symbol( sym.OPEN_BRACKET ); }
\)                              { return new Symbol( sym.CLOSE_BRACKET ); }
\{                              { return new Symbol( sym.OPEN_CURLY_BRACKET ); }
\}                              { return new Symbol( sym.CLOSE_CURLY_BRACKET ); }


// Operators
\+                              { return new Symbol( sym.PLUS ); }
\*                              { return new Symbol( sym.MULTIPLY ); }
=                               { return new Symbol( sym.ASSIGN ); }


// Separators
;                               { return new Symbol( sym.SEMICOLON ); }


// Keywords

"strategy"                      {   return new Symbol( sym.STRATEGY_BEGIN );    }
"~strategy"                     {   return new Symbol( sym.STRATEGY_END );      }
"declaration"                   {   return new Symbol( sym.DECLARATION_BEGIN ); }
"~declaration"                  {   return new Symbol( sym.DECLARATION_END );   }
"int"                           {   return new Symbol( sym.INT );               }
"double"                        {   return new Symbol( sym.DOUBLE );            }
"string"                        {   return new Symbol( sym.STRING );            }
"bool"                          {   return new Symbol( sym.BOOL );              }
"char"                          {   return new Symbol( sym.CHAR );              }
"repeat"                        {   return new Symbol( sym.REPEAT );            }
"less"                          {   return new Symbol( sym.LESS );              }
"equal"                         {   return new Symbol( sym.EQUAL );             }
"greater"                       {   return new Symbol( sym.GREATER );           }
"numInstances"                  {   return new Symbol( sym.NUM_INSTANCES );     }
"service"                       {   return new Symbol( sym.SERVICE_BEGIN );     }
"~service"                      {   return new Symbol( sym.SERVICE_END );       }
"serviceName"                   {   return new Symbol( sym.SERVICE_NAME );      }
"executedBy"                    {   return new Symbol( sym.EXECUTED_BY );       }
"if"                            {   return new Symbol( sym.IF );                }
"then"                          {   return new Symbol( sym.THEN );              }
"scale"                         {   return new Symbol( sym.SCALE );             }
"redeployOn"                    {   return new Symbol( sym.REDEPLOY_ON );       }
"optimize"                      {   return new Symbol( sym.OPTIMIZE );          }

// Constants

// bool
"true"|"false"                  { return new Symbol( sym.BOOLCONST, Boolean.parseBoolean( yytext() ) ); }

// int
[-]?{digit_seq}                { return new Symbol( sym.INTCONST, Integer.parseInt( yytext() ) ); }

// double
[-]?{digit_seq}\.{digit_seq}  { return new Symbol( sym.DOUBLECONST, Double.parseDouble( yytext() ) ); }

// string
\"{char_seq}\"               { return new Symbol( sym.STRINGCONST, yytext() ); }

// char
'{char}'                        { return new Symbol( sym.CHARCONST, yytext() ); }

// IDs
{letter}({letter}|{digit})*       { return new Symbol( sym.ID, yytext() ); }

// Error
.  { if (yytext() != null && yytext().length() > 0) System.out.println( "Error at ln: " + yyline + ", column: " + yycolumn + " -- " + yytext() ); }