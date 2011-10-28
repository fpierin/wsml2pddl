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
	import java.util.List;
	import java.util.ArrayList;
	import br.usp.each.wsml2pddl.avaliadores.*; 
	import org.antlr.stringtemplate.StringTemplate; 
}

@members{

		Map<String, String> propriedades = new HashMap<String, String>();
		Map<String, List<String>> superclasses = new HashMap<String, List<String>>();
		List<Avaliador> predicados = new ArrayList<Avaliador>();
		Avaliador nomeDoDominio = null;
  
}

avaliador returns [Avaliador e]
	:	documento EOF { $e = new AvaliadorDeDocumentoPDDL($documento.e); } 
	;
	
documento returns [Avaliador e]
	: varianteWsml?
		prefixosImportados?
		(declaracaoDeOntologias { $e = $declaracaoDeOntologias.e; })?		
		(declaracaoDoGoal { $e = $declaracaoDoGoal.e; })?
	;

declaracaoDeOntologias returns [Avaliador e]
	: 'ontology' string
	 		conceito*
		{
		 	final Avaliador dominio = $string.e;
		 	final Avaliador requerimentos = new AvaliadorDeRequerimentos();
		 	final Avaliador tipos = new AvaliadorDeTipos(superclasses);
		 	final Avaliador predicado = new AvaliadorDePredicados(predicados);		 			 	
			$e = new AvaliadorDeDominio(dominio, requerimentos, tipos, predicado); 
		}				
	;
	
conceito
	: 'concept' c1 = Identificador 
			('subConceptOf' c2 = Identificador )?
			{ 
				predicados.add(new AvaliadorDePredicado(new AvaliadorDeString($c1.text)));
				final String superClasse = ($c2 != null)? $c2.text : "Object"; 
				final List<String> objetosDaClasseC2 = superclasses.get(superClasse);
				if (objetosDaClasseC2 == null){
						superclasses.put(superClasse, new ArrayList<String>());
						superclasses.get(superClasse).add($c1.text);
				} else {
					objetosDaClasseC2.add($c1.text);
				}
			}			
			anotacoes?
			( p = Identificador 'ofType' '_'? c = Identificador 
				{	predicados.add(new AvaliadorDePredicado(new AvaliadorDeString($c1.text), 
					new AvaliadorDeString($p.text), 
					new AvaliadorDeString($c.text))); } 
			)*
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
	 		Avaliador avaliadorDeProblema = new AvaliadorDeString($fullIri.e.avalia());
	 		Avaliador avaliadorDeDominio = new AvaliadorDeDeclaracaoDeDominio(nomeDoDominio);
	 		Avaliador avaliadorDeObjetos = new AvaliadorDeObjetos(null);
	 		Avaliador avaliadorDeEstadoInicial = new AvaliadorDeEstadoInicial(null);
	 		Avaliador avaliadorDeRequerimentos = new AvaliadorDeRequerimentos();	 		
	 		$e = new AvaliadorDeProblema(avaliadorDeProblema,	avaliadorDeRequerimentos, avaliadorDeDominio,	
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
			( f1 = fullIri { nomeDoDominio = $f1.e; } 
			| '{' fullIri (',' fullIri)* '}' 
			)
	; 

condicoesDoProblema returns [Avaliador e]
	: 'capability' string?
			postconditions 
	 	{ $e = new AvaliadorDeGoal($postconditions.e); }				
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
	: c1 = classe 'hasValue' 
		( variavel { e = new AvaliadorDePropriedade($c1.e); }
		| StringLiteral { e = new AvaliadorDeClasse($c1.e, new AvaliadorDeString($StringLiteral.text)); }
		| c2 = classe { e = new AvaliadorDeClasse($c1.e, $c2.e); } 
		)
	;		

classe returns [Avaliador e] 
	: (v1 = Identificador '#')? v2 = Identificador { e = new AvaliadorDeString($v2.text); }
	;

variavel returns [Avaliador e]
	: '?' string { e = new AvaliadorDeVariavel($string.e); }
	;

atributo returns [Avaliador e]
	: Identificador { e = new AvaliadorDeString($Identificador.text); } 
	;
	
fullIri returns [Avaliador e]
	: '_'? 
		( string { $e = $string.e; }
		| url { $e = $url.e; }
		) 
	;
	
url returns [Avaliador e]
	: Url { e = new AvaliadorDeString($Url.text); }
	;
	
string returns [Avaliador e]
	: StringLiteral { e = new AvaliadorDeString($StringLiteral.text); }
	| Identificador { e = new AvaliadorDeString($Identificador.text); }
	;
	
namespace
	: Identificador? fullIri
	;	
	
