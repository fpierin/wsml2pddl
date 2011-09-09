package br.usp.each.wsml2pddl.evaluators;

public class ComentarioEvaluator implements Evaluator {

	private final Evaluator evaluator;

	public ComentarioEvaluator(final Evaluator evaluator) {
		this.evaluator = evaluator;
	}

	@Override
	public String evaluate() {
		String comentario = evaluator.evaluate();
		if (comentario == null){
			return "";
		}
		return "\n;" + comentario.replace("\n", "\n;") + "\n";
	}

}
