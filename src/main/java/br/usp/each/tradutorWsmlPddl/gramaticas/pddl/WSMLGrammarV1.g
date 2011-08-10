grammar WSMLGrammarV1;

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
	: wsmlvariant? namespace? definition*
	;

wsmlvariant
	: 'wsmlVariant' full_iri
	;
	
namespace
	: 'namespace' prefixDefinitionList
	;	
	
definition
	: goal
	| ontology
	| webservice
	| mediator
	| capability
	| interface	
	;
	
goal
	: 'goal' iri? header* nfp* capability? interface*
	;
	
nfp
	: 'nfp' attributeValueNfp log_definition_nfp?
	| 'nonFunctionalProperty' attributeValueNfp log_definition_nfp?
	;	
	
attributeValueNfp
	: id 'hasValue' valueListNfp annotations?
	;	
	
valueListNfp
	: valueNfp
	| '{' valueNfp moreNfpValues* '}'
	;	
	
valueNfp
	: baseValue
	| variable
	;	
	
moreNfpValues
	: ',' valueNfp
	;	
	
baseValue
	:
	;
	
variable
	:
	;
		
log_definition_nfp
	: 'definedby' log_expr+
	;	
	
header
	: annotations
	| importOntology
	| usesMediator
	;	
	
annotations
	: 'annotations' annotationValue* 'endAnnotations'
	;
	
annotationValue
	: id 'hasValue' baseValueList
	;	
	
id
	:
	;	
	
baseValueList
	:
	;	
	
importOntology
	: 'importsOntology' iriList
	;	
	
usesMediator
	: 'usesMediator' iriList
	;	
	
iriList
	:
	;	
	
ontology
	: 'ontology' iri? header* ontology_element*
	;	
	
ontology_element
	: concept
	| relation
	| instance
	| relationInstance
	| axiom
	;
	
concept
	: 'concept' id? superConcept? annotations? attribute*
	;	
	
superConcept
	: 'subConceptOf' idList
	;
	
idList
	: id
	| '{' id (',' id)* '}'
	| '{' '}'
	; 
	
attribute
	: attributeFeature* att_type cardinality? idList annotations? 
	;	
	
att_type
	: 'ofType'
	| 'impliesType'
	;	
	
cardinality
	: '(' DIGIT+ cardinality_number? ')'
	;	
	
cardinality_number
	: DIGIT+
	| '*'
	;	
	
attributeFeature
	: 'transitive'
	| 'symmetric'
	| 'inverseOf' '(' id ')'
	| 'subAttributeOf' '(' id ')'
	| 'reflexive'
	;
	
relation
	: 'relation' id? paramDef superRelation? annotations?
	;	
	
paramDef
	: arity
	| paramTyping
	;	
	
paramTyping
	:'(' paramType moreParamType* ')'
	;	

moreParamType
	: ',' paramType
	;
	
paramType
	: att_type idList
	;

arity
	: '/' pos_integer
	;
	
pos_integer
	:
	;
	
superRelation
	: 'subRelationOf' idList
	;	
	
instance
	: 'instance' id? memberOf? annotations? attributeValue*
	;
	
memberOf
	: 'memberOf' idList
	;		
	
attributeValue
	: id 'hasValue' valueList
	;	
	
relationInstance
	: 'relationInstance' id? id '(' value moreValues ')' annotations?
	;	
	
axiom
	: 'axiom' axiomDefinition
	;	
	
value
	:
	;	
	
moreValues
	:
	;	
	
axiomDefinition
	: id? annotations?
	| id? annotations? log_definition
	;
	
log_definition
	: 'definedBy' log_expr+
	;
	
log_expr
	:
	;	
	
valueList
	:
	;	
	
webservice
	:
	;	
	
mediator
	: ooMediator | ggMediator | wgMediator | wwMediator
	;	
	
ooMediator
	: 'ooMediator' iri? baseHeader* nfp* sources? target? use_service?
	;	
	
target
	:
	;	
	
baseHeader
	: annotations	| importOntology
	;	
	
sources
	:
	;
	
source
	:
	;	
	
use_service
	:
	;	
	
ggMediator
	: 'ggMediator' iri? header* nfp* source? target? use_service?
	;	
	
wgMediator
	: 'wgMediator' iri? header* nfp* sources? target? use_service?
	;	
	
wwMediator
	: 'wwMediator' iri? header* nfp* source? target? use_service?
	;	
	
capability
	: 'capability' iri? header* nfp* sharedVarDef? pre_post_ass_or_eff*
	;	
	
sharedVarDef
	:
	;
	
pre_post_ass_or_eff
	:
	;

interface
	:
	;	
	
prefixDefinitionList
	: full_iri
	| '{' prefixDefinition ( ',' prefixDefinition )* '}'
	;	
	
prefixDefinition
	: NAME full_iri
	| full_iri
	;
	
name
	:
	;
	
iri
	: full_iri
	| compactURI
	;
	
full_iri
	: '_' '"' IRI_F '"'
	;	
	
compactURI
	: (NAME '#')? NAME
	;	

BLANK : ( '\t' | ' ' | '\r' | '\n'| '\u000C' )+ 	{ $channel = HIDDEN; } ;

IRI_F : SCHEME ':' IHIER_PART ( '?' IQUERY )? ( '#' IFRAGMENT )? ;
NAME  : ( LETTER | '_' ) NAMECHAR* ;

fragment IHIER_PART		 : INET_PATH | IABS_PATH | IREL_PATH;
fragment IQUERY				 : ( IPCHAR | IPRIVATE | '/' | '?' )*;
fragment IFRAGMENT		 : ( IPCHAR | '/' | '?' )*;
fragment INET_PATH  	 : '//' IAUTHORITY ( IABS_PATH )? ;
fragment IABS_PATH 	 	 : '/' IPATH_SEGMENTS ;
fragment IPATH_SEGMENTS: ISEGMENT ( '/' ISEGMENT )* ;
fragment ISEGMENT      : IPCHAR*;
fragment IPCHAR				 : IUNRESERVED | ESCAPED | ';' | ':' | '@' | '&' | '=' | '+' | '$' | ',';
fragment IUNRESERVED	 : UNRESERVED | UCSCHAR;
fragment IREL_PATH		 : IPATH_SEGMENTS;
fragment IPRIVATE			 : '\uE000' .. '\uF8FF';
fragment IAUTHORITY		 : ( IUSERINFO '@' )? IHOST ( ':' PORT )?;
fragment IUSERINFO		 : ( IUNRESERVED | ESCAPED | ';' | ':' | '&' | '=' | '+' | '$' | ',')* ;
fragment IHOST 				 : ( IPV6REFERENCE | IPV4ADRESS | IHOSTNAME )? ;
fragment IHOSTNAME		 : IDOMAINLABEL IQUALIFIED ;
fragment IDOMAINLABEL  : ALPHANUM ( ( ALPHANUM | '-' )* ALPHANUM )?;
fragment IQUALIFIED  	 : ( '.' IDOMAINLABEL )* '.' ? ;
fragment IPV6REFERENCE : '[' IPV6ADRESS ']';
fragment IPV6ADRESS		 : ( ( H4 ':' )* H4 )? '::' ( H4 ':' )* LS32 | ( ( H4 ':' )* H4 )? '::' H4 | ( ( H4 ':' )* H4 )? '::';
fragment IPV4ADRESS    : DEC_OCTECT '.' DEC_OCTECT '.' DEC_OCTECT '.' DEC_OCTECT;
fragment LS32 				 : ( H4 ':' H4 ) | IPV4ADRESS ;	
fragment PORT					 : DIGIT* ;

fragment NAMECHAR   		 		 :( ESCAPE_CHAR ESCAPED_NAMECHAR ) | NOT_ESCAPED_NAMECHAR ;
fragment ESCAPE_CHAR		 		 : '\\' ;
fragment ESCAPED_NAMECHAR		 : '.' | '-' | NOT_ESCAPED_NAMECHAR;
fragment NOT_ESCAPED_NAMECHAR: LETTER | DIGIT | '_' | COMBININGCHAR | EXTENDER ; 
fragment ESCAPED				 		 : '%' HEXDIGIT HEXDIGIT ;
fragment UNRESERVED			 		 : LETTER | DIGIT | MARK ;
fragment SCHEME					 		 : LETTER (LETTER | DIGIT | '+' | '-' | '.')* ;
fragment UCSCHAR    		 		 :'\u00A0' .. '\uD7FF' | '\uF900' .. '\uFDCF' | '\uFDF0' ..'\uFFEF' ;
fragment H4         		 		 : HEXDIGIT HEXDIGIT? HEXDIGIT? HEXDIGIT? ;
fragment DEC_OCTECT 		 		 : DIGIT | ( ('\u0031' .. '\u0039') DIGIT ) 
														 | ( '1' DIGIT DIGIT ) | ( '2' ('\u0030' .. '\u0034') DIGIT ) | ( '25' ('\u0030' .. '\u0035') ) ;
														 
fragment ALPHANUM			: DIGIT | LETTER ;
fragment BASECHAR			: '\u0041' .. '\u005A' | '\u0061' .. '\u007A';
fragment COMBININGCHAR: '\u0300' .. '\u0345' | '\u0360' .. '\u0361' | '\u0483' ..'\u0486' ;
fragment DIGIT				: '\u0030' .. '\u0039';
fragment EXTENDER			: '\u00B7' | '\u02D0' | '\u02D1' | '\u0387' | '\u0640' | '\u0E46' 
											| '\u0EC6' | '\u3005' | '\u3031' .. '\u3035' | '\u309D' .. '\u309E' | '\u30FC' .. '\u30FE' ;
fragment HEXDIGIT			: '0' .. '9' | 'A' .. 'F';	
fragment IDEOGRAPHIC	: '\u4E00' .. '\u9FA5' | '\u3007' | '\u3021' .. '\u3029';
fragment LETTER 		: BASECHAR | IDEOGRAPHIC;
fragment MARK				: '-' | '_' | '.' | '!' | '~' | '*' | '(' | ')' ;
