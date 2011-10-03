package br.usp.each.wsml2pddl.avaliadores;

import org.antlr.stringtemplate.StringTemplate;

import br.usp.each.wsml2pddl.constantes.TemplatePDDL;
import br.usp.each.wsml2pddl.modelo.avaliadores.Avaliador;

public class AvaliadorDeDominio implements Avaliador {

	private final Avaliador dominio;
	
	public AvaliadorDeDominio(final Avaliador dominio) {
		this.dominio = dominio;
	}

	@Override
	public String avalia() {
		final StringTemplate stringTemplate = new StringTemplate(TemplatePDDL.Domain);
		stringTemplate.setAttribute("domain", dominio.avalia());
		return stringTemplate.toString();
	}

}
