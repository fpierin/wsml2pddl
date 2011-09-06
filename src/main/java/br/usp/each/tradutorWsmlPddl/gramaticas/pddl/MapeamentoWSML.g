grammar MapeamentoWSML;

options {
  language = Java;
}

@header {
  package br.usp.each.tradutorWsmlPddl.gramaticas.wsml;
}

@lexer::header {
  package br.usp.each.tradutorWsmlPddl.gramaticas.wsml;
}

documentoWSML
	: declaracaoDeNamespaces
		ontologias
	;

declaracaoDeNamespaces
	: 'namespace' '{' namespace+ '}'
	;
	
ontologias
	: 'ontology' Uri
		propriedadesNaoFuncionais
	;
	
propriedadesNaoFuncionais
	: 'nonFunctionalProperties'
			propriedadeNaoFuncional
		'endNonFunctionalProperties'
	;
	
propriedadeNaoFuncional
	: nomeDaPropriedade 'hasValue' valorDaPropriedade
	;
	
nomeDaPropriedade
	: Identidade
	;
	
valorDaPropriedade
	: '"' Identidade '"'
	| '{' '"' Identidade (',' valorDaPropriedade)* '"' '}'
	| Uri
	;
		
namespace
	: Uri ','?
	| Identidade Uri ','?
	;
	
Uri: '_"' Identidade '"';
	
Identidade: Letra QualquerCaracter*;

EspacoEmBranco: (' ' | '\t' | '\r' | '\n')+ { $channel = HIDDEN; };

fragment QualquerCaracter: Letra | Digito | '-' | '_' | ':' | '/' | '.' | '#';
fragment Digito: '0'..'9' ; 
fragment Letra:	'a'..'z' | 'A'..'Z';