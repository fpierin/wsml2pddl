grammar DominioPDDL;

options {
  language = Java;
}

@header {
  package br.usp.each.tradutorWsmlPddl.gramaticas.pddl;
}

@lexer::header {
  package br.usp.each.tradutorWsmlPddl.gramaticas.pddl;
}


define: '(define'
				')'
			;

NUMERO : (DIGITOS)+ ;

ESPACO_EM_BRANCO : ( '\t' | ' ' | '\r' | '\n'| '\u000C' )+ 	{ $channel = HIDDEN; } ;

fragment DIGITOS	: '0'..'9' ;
fragment LETRAS	: 'a'..'z';

