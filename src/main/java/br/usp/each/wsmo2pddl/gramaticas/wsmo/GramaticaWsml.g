grammar GramaticaWsml;

options {
  language = Java;
}

@header {
  package br.usp.each.wsmo2pddl.gramaticas.wsmo;
}

@lexer::header {
  package br.usp.each.wsmo2pddl.gramaticas.wsmo;
}

wsml
	: variante? namespaces? outrasDefinicoes+
	;

variante
	: 'wsmlVariant' full_iri
	;
	
namespaces
	: 'namespace' '{' namespace (',' namespace)* '}'
	;
	
outrasDefinicoes
//	: goal | ontology | webservice | mediator | capability | interface;
	: ontologia
	;	
	
ontologia
	: 'ontology' full_iri anotacoes
	;
	
anotacoes
	: 'annotations'	anotacao+	'endAnnotations'
	;
	
anotacao
	: identificador 'hasValue' valor
	;
	
namespace
	: full_iri 
	|	prefixo full_iri
	;
	
identificador
	: IDENTIDADE
	;
		
prefixo
	: IDENTIDADE
	;
	
valor
	:
	;	
	
full_iri
	: '_' STRING_LITERAL
	;
	
fragment ASPAS 									: '"';
fragment CERQUILHA							: '#';
fragment DIGITO 								: '0'..'9' ; 
fragment ESPACO_EM_BRANCO				: (' '|'\r'|'\t'|'\u000C'|'\n') ;				
fragment LETRA									:	'a'..'z' | 'A'..'Z';
fragment SINAL_DE_ADICAO 				: '+' ;
fragment SINAL_DE_SUBTRACAO 		: '-' ;
fragment SINAL_DE_MULTIPLICACAO : '*' ;
fragment SINAL_DE_DIVISAO				: '/' ;

IDENTIDADE
	: LETRA (DIGITO | LETRA | CERQUILHA)* ;

STRING_LITERAL
	: ASPAS (options {greedy=false;} : . )* ASPAS ;
	
WS
	: (ESPACO_EM_BRANCO)+ { $channel = HIDDEN; };



