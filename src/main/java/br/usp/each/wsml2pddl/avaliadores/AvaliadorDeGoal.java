package br.usp.each.wsml2pddl.avaliadores;

import org.antlr.stringtemplate.StringTemplate;

import br.usp.each.wsml2pddl.constantes.TemplatePDDL;
import br.usp.each.wsml2pddl.modelo.avaliadores.Avaliador;

public class AvaliadorDeGoal implements Avaliador {

	private final Avaliador avaliador;

	public AvaliadorDeGoal(final Avaliador evaluator) {
		this.avaliador = evaluator;
	}

	@Override
	public String avalia() {
		final StringTemplate stringTemplate = new StringTemplate(TemplatePDDL.Goal);
		stringTemplate.setAttribute("goals", avaliador.avalia());
		return stringTemplate.toString();
		
		
	}
	
	
	
}
