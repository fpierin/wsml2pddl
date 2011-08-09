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
	: '(' 'define' definicaoDoProblema 
		dominio
		objetos?
		mundoInicial
		objetivo
		')'
	;
	
definicaoDoProblema
  : '(' 'problem' IDENTIDADE ')'
	;
	
dominio
	: '(' ':domain' IDENTIDADE ')'
	;
	
objetos
	: '(' ':objects' IDENTIDADE+ ')'
	;
	
mundoInicial
	: '(' ':init' elementosIniciais ')'
	;
	
objetivo
	: '(' ':goal' elementosObjetivo ')'
	;			
	
elementosIniciais
	: IDENTIDADE+
	| ('(' IDENTIDADE ')')+
	| condicional+
	;
	
elementosObjetivo
	: '(' 'and' ('(' IDENTIDADE ')')+ ')'
	| '(' 'AND' ('(' IDENTIDADE ')')+ ')'	
	| '(' 'and'  condicional+ ')'
	| '(' 'AND'  condicional+ ')'	
	| '(' IDENTIDADE ')'
	| IDENTIDADE
	;

condicional
	: '(' referencial IDENTIDADE+ ')'+
	;	
	
referencial
	: IDENTIDADE
	;
	
IDENTIDADE 
	: LETRA QUALQUER_CARACTER* ;

ESPACO_EM_BRANCO 
	: ( '\t' | ' ' | '\r' | '\n'| '\u000C' )+ 	{ $channel = HIDDEN; } ;

COMENTARIO
  : ';' ~('\n'|'\r')* '\r'? '\n' { $channel = HIDDEN; } ;
    

fragment DIGITOS 								: '0'..'9' ; 
fragment SINAL_DE_ADICAO 				: '+' ;
fragment SINAL_DE_SUBTRACAO 		: '-' ;
fragment SINAL_DE_MULTIPLICACAO : '*' ;
fragment SINAL_DE_DIVISAO				: '/' ;

fragment LETRA:	'a'..'z' | 'A'..'Z';
fragment QUALQUER_CARACTER: LETRA | DIGITOS | '-' | '_';

