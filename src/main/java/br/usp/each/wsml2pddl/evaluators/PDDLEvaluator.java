package br.usp.each.wsml2pddl.evaluators;

public class PDDLEvaluator implements Evaluator {

	private final Evaluator evaluator;

	@Override
	public String evaluate() {
		return "(define " + 
					evaluator.evaluate() + "\n" +
				")";
	}

	public PDDLEvaluator(final Evaluator evaluator) {
		this.evaluator = evaluator;
	}

}
