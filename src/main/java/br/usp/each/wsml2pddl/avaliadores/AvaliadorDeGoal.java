package br.usp.each.wsml2pddl.avaliadores;

import org.antlr.stringtemplate.StringTemplate;

import br.usp.each.wsml2pddl.modelo.avaliadores.Avaliador;

public class AvaliadorDeGoal implements Avaliador {

	private final Avaliador evaluator;

	public AvaliadorDeGoal(final Avaliador evaluator) {
		this.evaluator = evaluator;
	}

	@Override
	public String avalia() {
		final String template = 
				"(:goal " + evaluator.avalia() + "\n" +
				")";
		final StringTemplate stringTemplate = new StringTemplate(template);
		return stringTemplate.getTemplate();
		
		
	}
	
	
	
}
