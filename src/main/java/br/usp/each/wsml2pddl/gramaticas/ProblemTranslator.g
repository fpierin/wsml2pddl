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
	: ('goal' (nomeDoProblema = fullIri ))
			(especificacoes = capability)
	 	{ $e = new ProblemEvaluator($nomeDoProblema.e, $especificacoes.e); }
	;

capability returns [Evaluator e]
	: 'capability'
		('effect' (definicoes = definicao) '.')
	 	{ $e = new GoalEvaluator($definicoes.e); }	
	;

definicao returns [Evaluator e]
	: ('definedBy'	(verdade = condicao) )
		{ e = $verdade.e; } 
	;

condicao returns [Evaluator e]
	: atributo 'memberOf' valor 
	 	{ e = new AtributoEvaluator($atributo.e, $valor.e); }
	;
	
atributo returns [Evaluator e]
	: Variavel { e = new StringEvaluator($Variavel.text); } 
	;
	
valor returns [Evaluator e]
	: Variavel { e = new StringEvaluator($Variavel.text); } 
	;	
	
fullIri returns [Evaluator e]
	: Variavel { e = new StringEvaluator($Variavel.text); } 
	;
	
