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
	: ontologia
	| webService
	;
	
ontologia
	: 'ontology' full_iri 
		ontologiasImportadas? anotacoes? conceito* instancias? relacoes? axiomas?
	;
	
axiomas
	: (axioma)+
	;
	
axioma
	:	'axiom' identificador
		anotacoes?
		'definedBy' identificador
	;
	

relacoes
	: 'relation' identificador '(' parametros ')'
		anotacoes?
	;
	
parametros
	: parametro (',' parametro)*
	;
	
parametro
	: 'ofType' tipo
	;
	
conceito
	: 'concept' identificador ('subConceptOf' identificador)?
		anotacoes?
		propriedade*
	;
	
instancias
	: 'instance' identificador 'memberOf' identificador
		propriedadeDaInstancia*
	;
	
propriedade
	: identificador tipoDeRelacao unidadeDeRelacao tipo
	;

propriedadeDaInstancia
	: identificador 'hasValue' valor
	;	
	
valor
	: STRING_LITERAL
	| funcao
	| identificador
	; 

tipo
	: '_dateTime'
	| '_decimal'
	| identificador
	;
	
tipoDeRelacao
	: 'ofType' 
	| 'impliesType'
	;
	
unidadeDeRelacao
	: '(' RELACAO_UNARIA RELACAO_UNARIA ')'
	;
	
webService
	: 'webService' full_iri
		mediadores? ontologiasImportadas? anotacoes? 
	;		
	
ontologiasImportadas
	: 'importsOntology' '{' full_iri (',' full_iri)* '}'
	;
	
mediadores
	: 'usesMediator' full_iri
	;
	

anotacoes
	: 'annotations'	anotacao+	'endAnnotations'
	;
	
anotacao
	: identificador 'hasValue' valores
	;
	
namespace
	: full_iri 
	|	identificador full_iri
	;
	
identificador
	: IDENTIDADE
	;
		
valores
	: full_iri
	| funcao
	| STRING_LITERAL
	| '{' STRING_LITERAL (',' STRING_LITERAL)* '}'
	;	
	
funcao
	: '_date(' NUMERO ',' NUMERO ',' NUMERO ')'
	| '_dateTime(' NUMERO ',' NUMERO ',' NUMERO ',' NUMERO ',' NUMERO ',' NUMERO ')'
	| '_decimal(' NUMERO ')'
	;
	
full_iri
	: '_' STRING_LITERAL
	;
	
fragment ASPAS 						: '"';
fragment BARRA						: '/' ;
fragment CERQUILHA				: '#';
fragment DIGITO 					: '0'..'9' ; 
fragment ESPACO_EM_BRANCO	: (' '|'\r'|'\t'|'\u000C'|'\n') ;				
fragment LETRA						:	'a'..'z' | 'A'..'Z';
fragment PONTO						: '.';


RELACAO_UNARIA 	: '0'| '1'| '*';

IDENTIDADE
	: LETRA (DIGITO | LETRA | CERQUILHA)* ;

STRING_LITERAL
	: ASPAS (options {greedy=false;} : . )* ASPAS ;
	
NUMERO
	: DIGITO+
	| DIGITO+ ('.') DIGITO+
	;
	
WS
	: (ESPACO_EM_BRANCO)+ { $channel = HIDDEN; };
