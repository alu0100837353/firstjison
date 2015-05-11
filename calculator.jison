/* description: Parses end executes mathematical expressions. */

/* operator associations and precedence */


%{
    var symbolTable = { }  /*para guardar valores */
%}

%right '='
%left '+' '-'
%left '*' '/'
%right '^'
%nonassoc '%'
%left UMINUS
%nonassoc '!' 

%start expressions

%% /* language grammar */

expressions
    :s
        { $$ = (typeof $1 == 'undefined')? [] : [ $1 ];}
    | expressions ';' s
        { $$ = $1;
            if ($3) $$.push($3);
            console.log($$);
        }
    ;

s
    :/*empty*/
    | e
    ; 
  

e
    : ID '=' e
        { symbolTable[$1] = $3; $$ = $3; }
    | e '+' e
        {$$ = $1+$3;}
    | e '-' e
        {$$ = $1-$3;}
    | e '*' e
        {$$ = $1*$3;}
    | e '/' e
        {$$ = $1/$3;}
    | e '^' e
        {$$ = Math.pow($1, $3);}
    | e '!'
        {
          $$ = (function fact (n) { return n==0 ? 1 : fact(n-1) * n })($1);
        }
    | e '%'
        {$$ = $1/100;}
    | '-' e %prec UMINUS
        {$$ = -$2;}
    | '(' e ')'
        {$$ = $2;}
    | NUMBER
        {$$ = Number(yytext);}
    | E
        {$$ = Math.E;}
    | PI
        {$$ = Math.PI;}
    | ID
        {$$ = symbolTable[$1];}
    ;
