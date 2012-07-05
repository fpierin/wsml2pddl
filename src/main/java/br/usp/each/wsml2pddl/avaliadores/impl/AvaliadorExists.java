package br.usp.each.wsml2pddl.avaliadores.impl;

import org.antlr.stringtemplate.StringTemplate;

import br.usp.each.wsml2pddl.avaliadores.Avaliador;
import br.usp.each.wsml2pddl.constantes.TemplatePDDL;

/**
 * 
 * @author Felipe Pierin <felipe.pierin@yahoo.com.br>
 *
 */
public class AvaliadorExists implements Avaliador {

	private final Avaliador condicao;

	public AvaliadorExists(final Avaliador condicao) {
		this.condicao = condicao;
	}

	@Override
	public String avalia() {
		final StringTemplate stringTemplate = new StringTemplate(TemplatePDDL.Exists);
		stringTemplate.setAttribute("condicao", condicao.avalia());
		return stringTemplate.toString();
	}

}
