package br.usp.each.wsml2pddl.evaluators;

public class AndEvaluator implements Evaluator {

	private final Evaluator atributo1;
	private final Evaluator atributo2;

	public AndEvaluator(final Evaluator atributo1, final Evaluator atributo2) {
		this.atributo1 = atributo1;
		this.atributo2 = atributo2;
	}

	@Override
	public String evaluate() {
		return "(and " + atributo1.evaluate() + " " + atributo2.evaluate() + ")";
	}

}
