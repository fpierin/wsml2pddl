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


dominio
	:'(' 'define' declaracaoDoDominio
		declaracaoDeRequerimento
		declaracaoDePredicados
		declaracaoDeAcoes
	 ')'
	;

declaracaoDoDominio
	: '(' 'domain' nomeDoDominio ')'
	;

declaracaoDeRequerimento
	: '(' ':requirements' nomeDoRequerimento ')'
	;
	
declaracaoDePredicados
	: '(' ':predicates' predicado+ ')'
	;

declaracaoDeAcoes
	: declaracaoDeAcao* 
	;
	
declaracaoDeAcao
	: '(' ':action' nomeDaAcao
			declaracaoDeParametros
			declaracaoDePrecondicoes
			declaracaoDeEfeitos
		')'
	;	
	
declaracaoDeParametros
 : ':parameters' '(' parametros ')'
 ;

declaracaoDePrecondicoes
	: ':precondition' '(' precondicao? ')'
	;
	
declaracaoDeEfeitos
	: ':effect' '(' efeito ')'
	;		

parametros
	: parametro*
	;
	
precondicao
	: 'and' condicao+
	| condicao
	;
	
efeito
	: 'and' condicao+
	| condicao
	;		
	
condicao
	: '(' condicao ')'
	| '(' relacao condicao+ ')'
	| parametro
	;		
	
modificador		
	: IDENTIDADE
	;
		
relacao
	: IDENTIDADE
	;	
	
predicado
	: '(' nomeDoPredicado ')'
	;
	
parametro
	: IDENTIDADE
	;
	
nomeDoDominio
	: IDENTIDADE+;
	
nomeDoRequerimento
	: IDENTIDADE+;
	
nomeDoPredicado
	: IDENTIDADE+;	
	
nomeDoEfeito
	: IDENTIDADE+;

nomeDaAcao
	: IDENTIDADE+;

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