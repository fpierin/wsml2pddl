tree grammar TradutorDeProblemaPDDL;

options {
  language = Java;
  tokenVocab = GramaticaWSML;
  ASTLabelType = CommonTree;
}

@header {
  package br.usp.each.wsml2pddl.gramaticas;
	import br.usp.each.wsml2pddl.modelo.avaliadores.Avaliador;  
	import br.usp.each.wsml2pddl.avaliadores.*;  
}

avaliador returns [Avaliador e]
	:	problema EOF { $e = $problema.e; } 
	;
	
problema returns [Avaliador e]
	: varianteWsml?
		prefixosImportados?
		declaracaoDoGoal { $e = $declaracaoDoGoal.e; }
	;

declaracaoDoGoal returns [Avaliador e]
	:	'goal' fullIri
			importsOntology?
			condicoesDoProblema
	 	{ $e = new AvaliadorPDDL(new AvaliadorDeProblema($fullIri.e), $condicoesDoProblema.e); }
	;

prefixosImportados
	:	'namespace' ( namespace | '{' namespace (',' namespace)* '}'	)
	;	
	
varianteWsml
	: WsmlVariant fullIri
	;
	
importsOntology 
	: 'importsOntology' 
			( fullIri | '{' fullIri (',' fullIri)* '}' )
	; 

condicoesDoProblema returns [Avaliador e]
	: 'capability'  
			(posCondicoes = postconditions) 
	 	{ $e = new AvaliadorDeGoal($posCondicoes.e); }				
	;
	
postconditions returns [Avaliador e]
	: 'postcondition'
			axiomDefinition	{ e = $axiomDefinition.e; }
	;
	
axiomDefinition returns [Avaliador e]
	: comentarios?
		axioma
	 { $e = new AvaliadorDePosCondicoes($axioma.e); }
	;

comentarios returns [Avaliador e]
	: 'annotations'
			( verdade = comentario )
		'endAnnotations'
		{ e = $verdade.e; } 		
	;

axioma returns [Avaliador e]
	: 'definedBy'	
			condicional '.' {$e = $condicional.e;}
	;

condicional returns [Avaliador e]
	:	condicao { $e = $condicao.e; }
	| v1 = condicao 'and' v2 = condicional { e = new AvaliadorAnd($v1.e, $v2.e); }
	;
	
condicao returns [Avaliador e]
	: atributo ('[' comentario (',' comentario)* ']')?  'memberOf' valor { e = new AvaliadorDeAtributo($atributo.e, $valor.e); }
	;
	
comentario returns [Avaliador e]
	: atributo 'hasValue' valor { e = new AvaliadorDeComentario($valor.e); }
	;

atributo returns [Avaliador e]
	: Variavel { e = new AvaliadorDeString($Variavel.text); } 
	;
	
valor returns [Avaliador e]
	: Variavel { e = new AvaliadorDeString($Variavel.text); }
	| StringLiteral { e = new AvaliadorDeString($StringLiteral.text); }	 
	;	
	
fullIri returns [Avaliador e]
	: '_' StringLiteral { e = new AvaliadorDeString($StringLiteral.text); }
	| Variavel { e = new AvaliadorDeString($Variavel.text); } 
	;
	
namespace
	: Variavel? fullIri
	;	
	
