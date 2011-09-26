tree grammar ProblemTranslator;

options {
  language = Java;
  tokenVocab = Wsml;
  ASTLabelType = CommonTree;
}

@header {
  package br.usp.each.wsml2pddl.gramaticas;
	import br.usp.each.wsml2pddl.evaluators.*;  
}

evaluator returns [Evaluator e]
	:	problem EOF { $e = new PDDLEvaluator($problem.e); } 
	;
	
problem returns [Evaluator e]
	: wsmlVariant?
		namespace?
		('goal' (nomeDoProblema = fullIri ))
			importsOntology?
			(condicoes = condicoesDoProblema)
	 	{ $e = new ProblemEvaluator($nomeDoProblema.e, $condicoes.e); }
	;

namespace	
	: 'namespace' '{' fullIri (',' valor fullIri )* '}'
	;
	
wsmlVariant
	: WsmlVariant fullIri
	;
	
importsOntology 
	: 'importsOntology' 
			( fullIri | '{' fullIri (',' fullIri)* '}' )
	; 

condicoesDoProblema returns [Evaluator e]
	: 'capability'  
			(posCondicoes = postconditions)? 
			(pddlGoal = efeitos) 
		'.'
	 	{ $e = new GoalEvaluator($pddlGoal.e); }				
	;
	
postconditions
	: 'postcondition'
			axiomDefinition
	;

efeitos returns [Evaluator e]
	:	'effect' 
			( definicaoDoEfeito =  axiomDefinition )
			{ e = $definicaoDoEfeito.e; }
	;
	
axiomDefinition returns [Evaluator e]
	: ( anotacoes = comentarios )?
		( efeitos2 = axioma )
	 { $e = new EffectEvaluator($anotacoes.e, $efeitos2.e); }
	;

comentarios returns [Evaluator e]
	: 'annotations'
			( verdade = comentario )
		'endAnnotations'
		{ e = $verdade.e; } 		
	;

axioma returns [Evaluator e]
	: 'definedBy'	
				( ( verdade = condicao ) { e = $verdade.e; }
	 			| ( condicao1 = condicao ) 'and' ( condicao2 = condicao ) { e = new AndEvaluator($condicao1.e, $condicao2.e); }
	 			)
	;

condicao returns [Evaluator e]
	: atributo ('[' comentario (',' comentario)* ']')?  'memberOf' valor { e = new AtributoEvaluator($atributo.e, $valor.e); }
	;
	
comentario returns [Evaluator e]
	: atributo 'hasValue' valor { e = new ComentarioEvaluator($valor.e); }
	;

atributo returns [Evaluator e]
	: Variavel { e = new StringEvaluator($Variavel.text); } 
	;
	
valor returns [Evaluator e]
	: Variavel { e = new StringEvaluator($Variavel.text); }
	| StringLiteral { e = new StringEvaluator($StringLiteral.text); }	 
	;	
	
fullIri returns [Evaluator e]
	: '_' StringLiteral { e = new StringEvaluator($StringLiteral.text); }
	| Variavel { e = new StringEvaluator($Variavel.text); } 
	;
	
