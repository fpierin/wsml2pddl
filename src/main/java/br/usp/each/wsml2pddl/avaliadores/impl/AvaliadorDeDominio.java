package br.usp.each.wsml2pddl.avaliadores.impl;

import org.antlr.stringtemplate.StringTemplate;

import br.usp.each.wsml2pddl.avaliadores.Avaliador;
import br.usp.each.wsml2pddl.constantes.TemplatePDDL;

/**
 * 
 * @author Felipe Pierin <felipe.pierin@yahoo.com.br>
 *
 */
public class AvaliadorDeDominio implements Avaliador {

	private final Avaliador dominio;
	private final Avaliador requerimentos;
	private final Avaliador tipos;
	private final Avaliador predicados;
	
	public AvaliadorDeDominio(final Avaliador dominio, final Avaliador requerimentos, 
			final Avaliador tipos, final Avaliador predicados) {
		this.dominio = dominio;
		this.requerimentos = requerimentos;
		this.tipos = tipos;
		this.predicados = predicados;
	}

	@Override
	public String avalia() {
		final StringTemplate stringTemplate = new StringTemplate(TemplatePDDL.Dominio);
		stringTemplate.setAttribute("dominio", dominio.avalia());
		stringTemplate.setAttribute("requerimentos", requerimentos.avalia());
		stringTemplate.setAttribute("tipos", tipos.avalia());
		stringTemplate.setAttribute("predicados", predicados.avalia());		
		return stringTemplate.toString();
	}

}
