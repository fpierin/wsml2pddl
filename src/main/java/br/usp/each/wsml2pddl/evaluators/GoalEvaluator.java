package br.usp.each.wsml2pddl.evaluators;

public class GoalEvaluator implements Evaluator {

	private final Evaluator evaluator;

	public GoalEvaluator(final Evaluator evaluator) {
		this.evaluator = evaluator;
	}

	@Override
	public String evaluate() {
		return "(:goal" + evaluator.evaluate() + ")";
	}
	
	
	
}
