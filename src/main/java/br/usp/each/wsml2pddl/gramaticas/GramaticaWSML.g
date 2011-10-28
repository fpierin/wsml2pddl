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
		( declaracaoDeOntologias |	declaracaoDeGoal )
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
	
declaracaoDeOntologias
	:	ontologia*
	;
	
ontologia
	: 'ontology' Identificador
			(conceito | axioma | instancia)*
	;
	
declaracaoDeAxioma
	: 'axiom' Identificador
			anotacoes?
			'definedBy'
				axioma ('implies' | 'impliedBy') axioma
			'.'
	;
	
axiomas
	: axioma ('and' axioma)*
	;
	
axioma
	:	variavel ('[' propriedades ']')? ('memberOf' classe)?
	;		
	
instancia
	: 'instance' Identificador 'memberOf' Identificador
	;
	
conceito
	:	'concept' Identificador ('subConceptOf' Identificador)?
			anotacoes?
			propriedade*
	;
	
propriedade
	: Identificador 'ofType' classe
	;
	
capacidade
	: 'capability' fullIri?
		variaveisCompartilhadas?
		( preCondicoes | posCondicoes | efeitos )*
	;
	
declaracaoDeCondicao
	: anotacoes?
			'definedBy'
		axiomas
	;
	
preCondicoes
	:	'precondition'
			declaracaoDeCondicao
		'.'
	;
	
posCondicoes
	:	'postcondition'
			declaracaoDeCondicao
		'.'
	;	
	
efeitos
	:	'effect'
			declaracaoDeCondicao
		'.'			
	;
	
variaveisCompartilhadas
	: 'sharedVariables' '{' variavel (',' variavel)* '}'
	;	
	
propriedades
	: atributo (',' atributo)*
	;
	
classe
	: '_'? (Identificador '#')? Identificador
	| StringLiteral
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
	: classe 'hasValue' (variavel | classe)
	;
	
fullIri
	: '_' StringLiteral
	| '_' Url
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

Url: ('http://') (AlfaNumerico) (AlfaNumerico | '-' | '/' | ';' | '#' | '.')*;

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

