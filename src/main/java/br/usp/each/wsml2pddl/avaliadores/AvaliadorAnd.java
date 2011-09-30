package br.usp.each.wsml2pddl.avaliadores;

import org.antlr.stringtemplate.StringTemplate;

import br.usp.each.wsml2pddl.constantes.TemplatePDDL;
import br.usp.each.wsml2pddl.modelo.avaliadores.Avaliador;

public class AvaliadorAnd implements Avaliador {

	private final Avaliador atributo1;
	private final Avaliador atributo2;

	public AvaliadorAnd(final Avaliador atributo1, final Avaliador atributo2) {
		this.atributo1 = atributo1;
		this.atributo2 = atributo2;
	}

	@Override
	public String avalia() {
		final StringTemplate stringTemplate = new StringTemplate(TemplatePDDL.AND);
		stringTemplate.setAttribute("atributo1", atributo1.avalia());
		stringTemplate.setAttribute("atributo2", atributo2.avalia());		
		return stringTemplate.toString();
	}

}
