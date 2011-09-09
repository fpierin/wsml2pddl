package br.usp.each.wsml2pddl.evaluators;

public class ProblemEvaluator implements Evaluator {

	final Evaluator nomeDoProblema;
	final Evaluator efeitos;
	
	public ProblemEvaluator(final Evaluator nomeDoProblema, final Evaluator efeitos) {
		this.nomeDoProblema = nomeDoProblema;
		this.efeitos = efeitos;
	}

	@Override
	public String evaluate() {
		return "(problem " + nomeDoProblema.evaluate() + ")" + "\n" +
					"  " + efeitos.evaluate();

	}

}
