package br.usp.each.wsml2pddl.avaliadores;

import org.antlr.stringtemplate.StringTemplate;

import br.usp.each.wsml2pddl.constantes.TemplatePDDL;
import br.usp.each.wsml2pddl.modelo.avaliadores.Avaliador;

public class AvaliadorDeDeclaracaoDeDominio implements Avaliador {

	private final Avaliador dominio;
	
	public AvaliadorDeDeclaracaoDeDominio(final Avaliador dominio) {
		this.dominio = dominio;
	}

	@Override
	public String avalia() {
		final StringTemplate stringTemplate = new StringTemplate(TemplatePDDL.DeclaracaoDeDominio);
		stringTemplate.setAttribute("dominio", dominio.avalia());
		return stringTemplate.toString();
	}

}
