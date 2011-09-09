package br.usp.each.wsml2pddl.evaluators;

public class EffectEvaluator implements Evaluator {

	private final Evaluator efeitos;
	private final Evaluator comentarios;

	public EffectEvaluator(final Evaluator comentarios, final Evaluator efeitos) {
		this.comentarios = comentarios;
		this.efeitos = efeitos;
	}
	
	@Override
	public String evaluate() {
		return obterResultadoNaoNulo() + efeitos.evaluate() ;
	}

	private String obterResultadoNaoNulo() {
		return (comentarios != null)? comentarios.evaluate(): "";
	}

}
