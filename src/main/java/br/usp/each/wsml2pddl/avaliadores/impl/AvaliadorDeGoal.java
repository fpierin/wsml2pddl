package br.usp.each.wsml2pddl.avaliadores.impl;

import org.antlr.stringtemplate.StringTemplate;

import br.usp.each.wsml2pddl.avaliadores.Avaliador;
import br.usp.each.wsml2pddl.constantes.TemplatePDDL;

/**
 * 
 * @author Felipe Pierin <felipe.pierin@yahoo.com.br>
 *
 */
public class AvaliadorDeGoal implements Avaliador {

	private final Avaliador avaliador;

	public AvaliadorDeGoal(final Avaliador evaluator) {
		this.avaliador = evaluator;
	}

	@Override
	public String avalia() {
		final StringTemplate stringTemplate = new StringTemplate(TemplatePDDL.Goal);
		stringTemplate.setAttribute("objetivo", avaliador.avalia());
		return stringTemplate.toString();
		
		
	}
	
	
	
}
