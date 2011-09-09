package br.usp.each.wsml2pddl.evaluators;

public class AtributoEvaluator implements Evaluator {

	private final Evaluator atributo;
	private final Evaluator valor;

	public AtributoEvaluator(final Evaluator atributo, final Evaluator valor) {
		this.atributo = atributo;
		this.valor = valor;
	}

	@Override
	public String evaluate() {
		return "(" + atributo.evaluate() + " " + valor.evaluate() + ")";
	}

}
