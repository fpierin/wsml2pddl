grammar GramaticaWsml;

options {
  language = Java;
}

@header {
  package br.usp.each.tradutorWsmlPddl.gramaticas.wsml;
}

@lexer::header {
  package br.usp.each.tradutorWsmlPddl.gramaticas.wsml;
}

wsml
	: variante? namespace? definicao
	;

variante
	: 'wsmlVariant' full_iri
	;
	
namespace
	: 'namespace' definicoesDePrefixos
	;
	
definicao
	: objetivo
	| ontologia
	;

objetivo
	: 'goal' full_iri
	;

ontologia
	: 'ontology' identificador? cabecalho? elementoDaOntologia*
	;
	
cabecalho
	: propriedadesNaoFuncionais
	;
	
propriedadesNaoFuncionais
	: 'nfp' valorDeAtributo 'endnfp'
	| 'nonFunctionalProperties' valorDeAtributo* 'endNonFunctionalProperties'
	;
	
valorDeAtributo
	: identificador 'hasValue' '"' identificador '"'
	;
	
identificador
	: iri
	;

iri
	: full_iri
	| qNameSerializado
	;
	
qNameSerializado
	: (IDENTIDADE '#')? IDENTIDADE
	;

elementoDaOntologia
	: conceito
	;
	
conceito
	: IDENTIDADE
	;

definicoesDePrefixos
	: full_iri
	| '{' definicaoDePrefixo (',' definicaoDePrefixo)* '}'
	;
	
definicaoDePrefixo
	: nomeDoPrefixo full_iri
	| full_iri
	;

full_iri
	: '_' '"' URL '"'
	;
	
nomeDoPrefixo
	: IDENTIDADE
	;
	
ESPACO_EM_BRANCO 
	: ( '\t' | ' ' | '\r' | '\n'| '\u000C' )+ 	{ $channel = HIDDEN; } ;
	
URL
	: 'http://' (IDENTIDADE)*
	;

IDENTIDADE 
	: LETRA QUALQUER_CARACTER* ;

fragment DIGITOS 								: '0'..'9' ; 
fragment SINAL_DE_ADICAO 				: '+' ;
fragment SINAL_DE_SUBTRACAO 		: '-' ;
fragment SINAL_DE_MULTIPLICACAO : '*' ;
fragment SINAL_DE_DIVISAO				: '/' ;

fragment LETRA:	'a'..'z' | 'A'..'Z';
fragment QUALQUER_CARACTER: LETRA | DIGITOS | '-' | '_' | ':' | '/' | '.' | '#';