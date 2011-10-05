package br.usp.each.wsml2pddl.avaliadores;

import org.antlr.stringtemplate.StringTemplate;

import br.usp.each.wsml2pddl.constantes.TemplatePDDL;
import br.usp.each.wsml2pddl.modelo.avaliadores.Avaliador;

public class AvaliadorDeObjetos implements Avaliador {
	
	private final Avaliador avaliador;

	public AvaliadorDeObjetos(final Avaliador avaliador) {
		this.avaliador = avaliador;
	}

	@Override
	public String avalia() {
		return (avaliador != null)? stringTemplate(): null;
	}

	private String stringTemplate() {
		final StringTemplate stringTemplate = new StringTemplate(TemplatePDDL.Objects);
		stringTemplate.setAttribute("objects", avaliador.avalia());
		return stringTemplate.toString();
	}

}
