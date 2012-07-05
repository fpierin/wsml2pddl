package br.usp.each.wsml2pddl.avaliadores.impl;

import java.util.List;

import org.antlr.stringtemplate.StringTemplate;

import br.usp.each.wsml2pddl.avaliadores.Avaliador;
import br.usp.each.wsml2pddl.constantes.TemplatePDDL;

/**
 * 
 * @author Felipe Pierin <felipe.pierin@yahoo.com.br>
 *
 */
public class AvaliadorDePredicados implements Avaliador {

	private final List<Avaliador> predicados;

	public AvaliadorDePredicados(final List<Avaliador> predicados) {
		this.predicados = predicados;
	}

	@Override
	public String avalia() {
		final StringTemplate stringTemplate = new StringTemplate(TemplatePDDL.Predicados);
		for (final Avaliador predicado: predicados){
			stringTemplate.setAttribute("predicado", predicado.avalia());
		}
		return stringTemplate.toString();
	}

}
