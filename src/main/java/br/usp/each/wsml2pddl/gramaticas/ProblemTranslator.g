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
			(condicoes = condicoesDoProblema)
	 	{ $e = new ProblemEvaluator($nomeDoProblema.e, $condicoes.e); }
	;

condicoesDoProblema returns [Evaluator e]
	: ('capability' (resultado = resultadoEsperado) '.')
	 	{ $e = new GoalEvaluator($resultado.e); }				
	;

resultadoEsperado returns [Evaluator e]
	:	'effect' 
			(anotacoes = comentarios)?
			(efeitos = efeitoEsperado)
	 	{ $e = new EffectEvaluator($anotacoes.e, $efeitos.e); }
	;

comentarios returns [Evaluator e]
	: 'annotations'
			(verdade = comentario)
		'endAnnotations'
		{ e = $verdade.e; } 		
	;

efeitoEsperado returns [Evaluator e]
	: 'definedBy'	
			(verdade = condicao)  	
		{ e = $verdade.e; } 
	;

condicao returns [Evaluator e]
	: atributo 'memberOf' valor { e = new AtributoEvaluator($atributo.e, $valor.e); }
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
	: Variavel { e = new StringEvaluator($Variavel.text); } 
	;
	
