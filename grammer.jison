%lex
%options case_insensative easy_keyword_rules
%%
"//".*                              /* skip comments */
"/*"(.|\n|\r)*"*/"                  /* skip comments */
"type"      						return 'T_TYPE';
"export"      						return 'T_EXPORT';
";"                                 return "T_SEMICOLON";
","                                 return "T_COMMA";
"{"                                 return "T_LBRACE";
"}"                                 return "T_RBRACE";
"["                                 return "T_LSQRBRACKET";
"]"                                 return "T_RSQRBRACKET";
"<"                                 return "T_LPNTBRACKET";
">"                                 return "T_RPNTBRACKET";
"="                                 return "T_EQ";
"struct"                            return "T_STRUCT";
"enum"                              return "T_ENUM";
\s+                                 /* skip whitespace */
[1-9]+[0-9]*\b				        return 'T_NUM';
[a-zA-Z0-9_]+						return 'T_CHAR';
<<EOF>>								return 'EOF';


/lex

%ebnf
%start application

%%


application
    : type_def*         {return true;}
    ;

type_def
    : T_EXPORT? T_TYPE T_CHAR  (T_LPNTBRACKET name_list T_RPNTBRACKET)? T_EQ type_body T_SEMICOLON
    ;

type_body
    : T_STRUCT T_LBRACE named_type+ T_RBRACE
    | T_ENUM  T_LBRACE enum_list  T_RBRACE
    | type_expr
    ;

name_list
    : T_CHAR (T_COMMA T_CHAR)* T_COMMA?
    ;

enum_list
    : T_CHAR (T_COMMA T_CHAR)* T_COMMA?
    | T_CHAR T_EQ T_NUM (T_COMMA T_CHAR T_EQ T_NUM)* T_COMMA?
    ;


    
named_type
    : type_body T_CHAR T_SEMICOLON
    ;

type_expr
    : T_CHAR (T_LPNTBRACKET type_list T_RPNTBRACKET)? (T_LSQRBRACKET T_NUM? T_RSQRBRACKET)*
    ;

type_list
    : type_expr (T_COMMA type_expr)*
    ;
