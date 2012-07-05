package br.usp.each.wsml2pddl.avaliadores.impl;

import org.antlr.stringtemplate.StringTemplate;

import br.usp.each.wsml2pddl.avaliadores.Avaliador;
import br.usp.each.wsml2pddl.constantes.TemplatePDDL;

/**
 * 
 * @author Felipe Pierin <felipe.pierin@yahoo.com.br>
 *
 */
public class AvaliadorAnd implements Avaliador {

	private final Avaliador atributo1;
	private final Avaliador atributo2;

	public AvaliadorAnd(final Avaliador atributo1, final Avaliador atributo2) {
		this.atributo1 = atributo1;
		this.atributo2 = atributo2;
	}

	@Override
	public String avalia() {
		final StringTemplate stringTemplate = new StringTemplate(TemplatePDDL.And);
		stringTemplate.setAttribute("atributo1", atributo1.avalia());
		stringTemplate.setAttribute("atributo2", atributo2.avalia());		
		return stringTemplate.toString();
	}

}
