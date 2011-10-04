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

@members{
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
	 	{ 
	 		Avaliador avaliadorDeProblema = new AvaliadorDeProblema($fullIri.e);
	 		Avaliador avaliadorDeDominio = new AvaliadorDeDominio($fullIri.e);
	 		Avaliador avaliadorDeObjetos = new AvaliadorDeObjetos(null);
	 		Avaliador avaliadorDeEstadoInicial = new AvaliadorDeEstadoInicial(null);
	 		Avaliador avaliadorDeRequerimentos = new AvaliadorDeRequerimentos();	 		
	 		$e = new AvaliadorPDDL(avaliadorDeProblema,	avaliadorDeRequerimentos, avaliadorDeDominio,	avaliadorDeObjetos,	avaliadorDeEstadoInicial, $condicoesDoProblema.e);
	 	}
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
			definicaoDoAxioma	{ e = $definicaoDoAxioma.e; }
	;
	
definicaoDoAxioma returns [Avaliador e]
	: axioma { $e = new AvaliadorDePosCondicoes($axioma.e); }
	;

axioma returns [Avaliador e]
	: 'definedBy'	
			condicoes '.' {$e = $condicoes.e;}
	;

condicoes returns [Avaliador e]
	:	condicao { $e = $condicao.e; }
	| v1 = condicao 'and' v2 = condicoes { e = new AvaliadorAnd($v1.e, $v2.e); }
	;
	
condicao returns [Avaliador e]
	: variavel (propriedades)? 'memberOf' classe 
		{ e = new AvaliadorExists($classe.e); }
	;

propriedades returns [Avaliador e]
	: '[' propriedade (',' propriedade)* ']'
	;
	
propriedade
	: classe 'hasValue' variavel
	;

classe returns [Avaliador e]
	: v1 = Identificador '#' v2 = Identificador { e = new AvaliadorDeString($v2.text); }
	;

variavel returns [Avaliador e]
	: '?'? string { e = new AvaliadorDeVariavel($string.e); }
	;

atributo returns [Avaliador e]
	: Identificador { e = new AvaliadorDeString($Identificador.text); } 
	;
	
fullIri returns [Avaliador e]
	: '_'? valor { $e = $valor.e; }
	;
	
valor returns [Avaliador e]
	: string { e = $string.e; }	 
	;	
	
string returns [Avaliador e]
	: StringLiteral { e = new AvaliadorDeString($StringLiteral.text); }
	| Identificador { e = new AvaliadorDeString($Identificador.text); }
	;
	
namespace
	: Identificador? fullIri
	;	
	
