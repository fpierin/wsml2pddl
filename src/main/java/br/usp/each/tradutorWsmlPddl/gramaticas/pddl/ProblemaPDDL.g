grammar ProblemaPDDL;

options {
  language = Java;
}

@header {
  package br.usp.each.tradutorWsmlPddl.gramaticas.pddl;
}

@lexer::header {
  package br.usp.each.tradutorWsmlPddl.gramaticas.pddl;
}

problema
	: '(' define
		')'
	;
	
define
	: 'define' '(' problem ')' 
		'(:' domain ')'
		'(:' init ')'
		'(:' goal ')'
	;
	
problem
	: 'problem' IDENTIDADE
	;
	
domain
	: 'domain' IDENTIDADE
	;
	
init
	: 'init' '(' IDENTIDADE ')'
	;
	
goal
	: 'goal' '(' IDENTIDADE  ')'
	;			


NUMERO 		 : (DIGITOS)+ ;
LETRAS 		 : ('a'..'z' | 'A'..'Z') ;
PALAVRA 	 : (LETRAS)+ ;
SINAIS		 : (SINAL_DE_ADICAO | SINAL_DE_SUBTRACAO | SINAL_DE_DIVISAO | SINAL_DE_MULTIPLICACAO );
IDENTIDADE : (PALAVRA)(LETRAS | DIGITOS | SINAIS)* ; 

ESPACO_EM_BRANCO : ( '\t' | ' ' | '\r' | '\n'| '\u000C' )+ 	{ $channel = HIDDEN; } ;

fragment DIGITOS 								: '0'..'9' ; 
fragment SINAL_DE_ADICAO 				: '+' ;
fragment SINAL_DE_SUBTRACAO 		: '-' ;
fragment SINAL_DE_MULTIPLICACAO : '*' ;
fragment SINAL_DE_DIVISAO				: '/' ;


