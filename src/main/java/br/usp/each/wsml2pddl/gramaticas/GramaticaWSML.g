grammar GramaticaWSML;

options {
  language = Java;
  output=AST;
  ASTLabelType=CommonTree;
}

tokens {
	WsmlVariant;
}

@header {
  package br.usp.each.wsml2pddl.gramaticas;
}

@lexer::header {
  package br.usp.each.wsml2pddl.gramaticas;
}

wsml
	: declaracaoDeVarianteWsml? 
		declaracaoDeNamespaces?
		declaracaoDeGoal
	;
	
declaracaoDeVarianteWsml
	: wsmlVariant fullIri
	;
	
declaracaoDeNamespaces
	:	'namespace' ( namespace | '{' namespace (',' namespace)* '}'	)
	;	
	
namespace
	: Identificador? fullIri
	;

	
wsmlVariant
	: 'wsmlVariant' -> WsmlVariant
	;
	
declaracaoDeGoal
	: 'goal' fullIri?
		anotacoes?
		ontologiaImportada?
		capacidade
	;
	
capacidade
	: 'capability' fullIri?
		variaveisCompartilhadas?
		( preCondicoes | posCondicoes | efeitos )*
	;
	
preCondicoes
	:	'precondition'
		axiomdefinition
	;
	
posCondicoes
	:	'postcondition'
		axiomdefinition
	;	
	
efeitos
	:	'effect'
		axiomdefinition
	;
	
variaveisCompartilhadas
	: 'sharedVariables' '{' variavel (',' variavel)* '}'
	;	
	
axiomdefinition
	:	anotacoes?
		definicao '.'
	;
	
definicao
	: 'definedBy'
			axiomas*
	;
	
axiomas
	: axioma ('and' axioma)*
	;

axioma
	: variavel ('[' propriedades ']')? 'memberOf' classe
	;
	
propriedades
	: atributo (',' atributo)*
	;
	
classe
	: (Identificador '#')? Identificador
	;	
	
variavel
	: '?' Identificador
	;
		
anotacoes
	:	'annotations'
			atributo*	
		'endAnnotations'
	;
	
ontologiaImportada
	: 'importsOntology' 
					( fullIri 
					| '{' fullIri (',' fullIri)*	'}' )
	;	
	
atributo
	: classe 'hasValue' variavel
	;
	
fullIri
	: '_' StringLiteral
	| Identificador
	;

prefixo
	: Identificador fullIri
	;

fragment AlfaNumerico		: Digito | Letra;
fragment Digito					: '0'..'9';
fragment Espacamento		: ' '; 
fragment Letra					: 'a'..'z' | 'A'..'Z';
fragment QuebraDeLinha	: '\n' | '\r';
fragment Tabulacao			: '\t';

Inteiro : Digito+;

Identificador: (Letra)(AlfaNumerico | '-')*; 

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

