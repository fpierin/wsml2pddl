package br.usp.each.wsml2pddl.avaliadores;

import org.antlr.stringtemplate.StringTemplate;

import br.usp.each.wsml2pddl.constantes.TemplatePDDL;
import br.usp.each.wsml2pddl.modelo.avaliadores.Avaliador;

public class AvaliadorDeDominio implements Avaliador {

	private final Avaliador dominio;
	private final Avaliador requerimentos;
	
	public AvaliadorDeDominio(final Avaliador dominio, final Avaliador requerimentos) {
		this.dominio = dominio;
		this.requerimentos = requerimentos;
	}

	@Override
	public String avalia() {
		final StringTemplate stringTemplate = new StringTemplate(TemplatePDDL.Dominio);
		stringTemplate.setAttribute("dominio", dominio.avalia());
		stringTemplate.setAttribute("requerimentos", requerimentos.avalia());		
		return stringTemplate.toString();
	}

}
