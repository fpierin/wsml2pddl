grammar PDDL;

options {
  language = Java;
  output=AST;
  ASTLabelType=CommonTree;
  //backtrack=true;
}

tokens {
	DOMAIN;
}

@header {
  package br.usp.each.wsml2pddl.gramaticas;
}

@lexer::header {
  package br.usp.each.wsml2pddl.gramaticas;
}

documento
	: '(' 'define'
			( dominio | problema )
		')'
	;
	
dominio
	: declaracaoDeDominio
		requerimentos?
		tipos?
		predicados?
		acao*
	;
	
declaracaoDeDominio
	: '(' ':'? 'domain' (nome | url) ')'
	;
	
declaracaoDeProblema
	: '(' 'problem' (nome | url) ')'
	;
	
problema
	: declaracaoDeProblema
		requerimentos?
		declaracaoDeDominio
		objetos?
		estadoInicial?
		objetivo?
	;	
	
requerimentos
	: '(' ':' 'requirements' requerimento+ ')'
	;
	
objetos
	: '(' ':' 'objects' nome+ ')'
	;
	
tipos
	: '(' ':' 'types'
	 			tipo+
		')'
	;
	
tipo
	: Identidade '-'?
	;
	
estadoInicial
	: '(' ':' 'init' estado+ ')'
	;
	
objetivo
	: '(' ':' 'goal' condicao ')'		
	;
	
requerimento
	: ':adl'
	| ':strips'
	| ':typing'
	| ':conditional-effects'
	| ':existential-preconditions'
	;

predicados
	: '('	':' 'predicates' predicado+ ')'
	;
	
predicado
	: '(' tipo variavel+ ')'
	| '(' nome variavel '-' tipo variavel '-' tipo ')'
	;
	
acao
	: '(' ':' 'action' nome
			parametros
			precondicoes?
			efeitos
		')'
	;
	
parametros
	: ':' 'parameters' '(' variavel+ ('-' tipo)? ')'
	;
	
precondicoes
	: ':' 'precondition'	condicao
	;
	
efeitos
	: ':' 'effect' condicao
	;
	
estado
	: '(' nome nome nome? ')'
	;
	
condicao
	: '(' 'and' condicao+ ')'
	| '(' 'not' condicao+ ')'	
	| '(' 'forall' '(' variavel '-' tipo ')' condicao+ ')'
	| '(' 'when' condicao condicao ')'
	| '(' 'exists' '(' variavel tipo ')' condicao* ')'
	| '(' nome (variavel | nome)+ ')'
	;
	
variavel
	: '?' identidade
	;
	
identidade
	: Identidade
	;
	
nome
	: Identidade
	;
	
url
	: Url
	;
	
fragment AlfaNumerico		: Digito | Letra;
fragment Digito					: '0'..'9';
fragment Espacamento		: ' '; 
fragment Letra					: 'a'..'z' | 'A'..'Z';
fragment QuebraDeLinha	: '\n' | '\r' | '\r\n' | '\n\r';
fragment Tabulacao			: '\t';

Inteiro : Digito+;

Identidade: (Letra)(AlfaNumerico | '-' | '_')*;

Url: ('http://') (AlfaNumerico) (AlfaNumerico | '-' | '/' | ';' | '#' | '.')*;

StringLiteral 
	: '"'
		{ StringBuilder b = new StringBuilder(); }
		( '\\' '"' 	 { b.appendCodePoint('"'); }
		| c = ~('"') { b.appendCodePoint(c); }
		)*
		'"'
		{ setText(b.toString()); }		
	;
	
CaracteresIgnorados: (Espacamento | Tabulacao | QuebraDeLinha | '\f')+ {$channel = HIDDEN;};
ComentarioDeLinhaUnica: ';;' .* (QuebraDeLinha) {$channel = HIDDEN;};