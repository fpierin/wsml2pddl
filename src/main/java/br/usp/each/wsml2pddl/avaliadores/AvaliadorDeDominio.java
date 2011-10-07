package br.usp.each.wsml2pddl.avaliadores;

import org.antlr.stringtemplate.StringTemplate;

import br.usp.each.wsml2pddl.constantes.TemplatePDDL;
import br.usp.each.wsml2pddl.modelo.avaliadores.Avaliador;

public class AvaliadorDeDominio implements Avaliador {

	private final Avaliador dominio;
	private final Avaliador requerimentos;
	private final Avaliador tipos;
	
	public AvaliadorDeDominio(final Avaliador dominio, 
			final Avaliador requerimentos, final Avaliador tipos) {
		this.dominio = dominio;
		this.requerimentos = requerimentos;
		this.tipos = tipos;
	}

	@Override
	public String avalia() {
		final StringTemplate stringTemplate = new StringTemplate(TemplatePDDL.Dominio);
		stringTemplate.setAttribute("dominio", dominio.avalia());
		stringTemplate.setAttribute("requerimentos", requerimentos.avalia());
		stringTemplate.setAttribute("tipos", tipos.avalia());		
		return stringTemplate.toString();
	}

}
