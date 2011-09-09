package br.usp.each.wsml2pddl.evaluators;

public class StringEvaluator implements Evaluator {

	private final String string;

	@Override
	public String evaluate() {
		return string == null? "" : string;
	}

	public StringEvaluator(final String string) {
		this.string = string;
	}
	
	

}
