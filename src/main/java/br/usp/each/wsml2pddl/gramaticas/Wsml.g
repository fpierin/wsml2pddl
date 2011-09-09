grammar Wsml;

options {
  language = Java;
  output=AST;
  ASTLabelType=CommonTree;
}

tokens {
	WSMLVARIANT;
}

@header {
  package br.usp.each.wsml2pddl.gramaticas;
}

@lexer::header {
  package br.usp.each.wsml2pddl.gramaticas;
}

wsml
//	: varianteWsml? 
//		namespace? 
	:	goal
	;

//varianteWsml
//	: wsmlVariant^ fullIri
//	;
	
//wsmlVariant
//	: 'wsmlVariant' -> WsmlVariant
//	;
//
//namespace
//	:	'namespace' ( fullIri
//	 							| '{' fullIri (',' prefixo)* '}')
//	;
//	
goal
	: 'goal' fullIri?
//		anotacoes?
//		ontologiaImportada?
		capacidade
	;
	
capacidade
	: 'capability' fullIri?
//		variaveisCompartilhadas?
//		( preCondicoes | posCondicoes | efeitos )*
		( efeitos )*
	;
	
//preCondicoes
//	:	'precondition'
//			anotacoes?
//			definicao '.'
//	;
//	
//posCondicoes
//	:	'postcondition'
//			anotacoes?
//			definicao '.'
//	;	
//	
efeitos
		:	'effect'
//			anotacoes?
			definicao '.'
//			definicao
	;
	
definicao
	: 'definedBy'
		axioma
//		('and' axioma)?
	;

axioma
//	: Variavel '[' atributo 
//							 	(',' atributo)* 
//						 ']' 'memberOf' Variavel
	: Variavel 'memberOf' Variavel
	;
	
//variaveisCompartilhadas
//	: 'sharedVariables' '{' Variavel (',' Variavel)* '}'
//	;
//	
//anotacoes
//	:	'annotations'
//			atributo*	
//		'endAnnotations'
//	;
//	
//ontologiaImportada
//	: 'importsOntology' '{' fullIri (',' fullIri)*	'}'
//	;	
//	
//atributo
//	: Variavel 'hasValue' 
//			( Variavel
//			| StringLiteral)
//	;
//	
fullIri
	: '_' StringLiteral
	| Variavel
	;

//prefixo
//	: Variavel fullIri
//	;

fragment AlfaNumerico		: Digito | Letra;
fragment Digito					: '0'..'9';
fragment Espacamento		: ' '; 
fragment Letra					: 'a'..'z' | 'A'..'Z';
fragment QuebraDeLinha	: '\n' | '\r';
fragment Tabulacao			: '\t';

Inteiro : Digito+;
Variavel: (Letra | '?') (AlfaNumerico | '?' | '#' | '-' )* ;

StringLiteral 
	: '"'
		{ StringBuilder b = new StringBuilder(); }
		( '\\' '"' 										{ b.appendCodePoint('"'); }
		| c = ~('"') { b.appendCodePoint(c); }
		)*
		'"'
		{ setText(b.toString()); }		
	;
	
CaracteresIgnorados: (Espacamento | Tabulacao | QuebraDeLinha | '\f')+ {$channel = HIDDEN;};
ComentarioDeLinhaUnica: '//' .* (QuebraDeLinha) {$channel = HIDDEN;};
ComentarioDeMultiplasLinhas: '/*' .* '*/' {$channel = HIDDEN;};

