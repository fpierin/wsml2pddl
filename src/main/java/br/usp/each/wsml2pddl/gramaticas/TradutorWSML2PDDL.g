tree grammar TradutorWSML2PDDL;

options {
  language = Java;
  tokenVocab = GramaticaWSML;
  ASTLabelType = CommonTree;
}

@header {
  package br.usp.each.wsml2pddl.gramaticas;
	import br.usp.each.wsml2pddl.modelo.avaliadores.Avaliador;
	import java.util.HashMap;
	import java.util.Map;
	import br.usp.each.wsml2pddl.avaliadores.*; 
	import org.antlr.stringtemplate.StringTemplate; 
}

@members{

		Map<String, String> propriedades = new HashMap<String, String>();
  
}

avaliador returns [Avaliador e]
	:	problema EOF { $e = $problema.e; } 
	;
	
problema returns [Avaliador e]
	: varianteWsml?
		prefixosImportados?
		(declaracaoDoOntologias { $e = $declaracaoDoOntologias.e; })?		
		(declaracaoDoGoal { $e = $declaracaoDoGoal.e; })?
	;

declaracaoDoOntologias returns [Avaliador e]
	: 'ontology' string { $e = $string.e; }
			('concept' Identificador ('subConceptOf' Identificador)?
				anotacoes?
				(Identificador 'ofType' Identificador )*)*
	;
	
anotacoes
	:	'annotations'
			propriedade+
		'endAnnotations'
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
	 		$e = new AvaliadorPDDL(avaliadorDeProblema,	avaliadorDeRequerimentos, avaliadorDeDominio,	
	 			avaliadorDeObjetos,	avaliadorDeEstadoInicial, $condicoesDoProblema.e);
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
			'definedBy'
				axioma 
				{
					$e = new AvaliadorDePosCondicoes($axioma.e);
		  		for(final String propriedade: propriedades.keySet()){
		  			$e = new AvaliadorDeCondicao($e, propriedade, propriedades.get(propriedade));
		  		} 
				}
			'.'
	;
	
axioma returns [Avaliador e]
	: c1 = condicao { $e = $c1.e; }
	  ( 'and' c2 = axioma	{	$e = new AvaliadorAnd($c1.e, $c2.e);	} )?
	;
	
condicao returns [Avaliador e]
	: variavel ('[' propriedades ']')? 'memberOf' classe 
		{
		 	propriedades.put($variavel.e.avalia(), $classe.e.avalia());
			e = new AvaliadorExists(new AvaliadorDeClasse($classe.e, $propriedades.e)); 
		}
	;
	
propriedades returns [Avaliador e]
	: p1 = propriedade { e = $p1.e; } 
		(',' p2 = propriedade { e = new AvaliadorAnd($p1.e, $p2.e); } )*		
	;		
	
propriedade  returns [Avaliador e]
	: classe 'hasValue' variavel 
		{ 
			e = new AvaliadorDePropriedade($classe.e); 
		}
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
	
