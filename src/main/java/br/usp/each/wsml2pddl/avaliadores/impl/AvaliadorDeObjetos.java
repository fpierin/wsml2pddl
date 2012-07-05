package br.usp.each.wsml2pddl.avaliadores.impl;

import org.antlr.stringtemplate.StringTemplate;

import br.usp.each.wsml2pddl.avaliadores.Avaliador;
import br.usp.each.wsml2pddl.constantes.TemplatePDDL;

/**
 * 
 * @author Felipe Pierin <felipe.pierin@yahoo.com.br>
 *
 */
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
		final StringTemplate stringTemplate = new StringTemplate(TemplatePDDL.Objetos);
		stringTemplate.setAttribute("objetos", avaliador.avalia());
		return stringTemplate.toString();
	}

}
