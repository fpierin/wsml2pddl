package br.usp.each.wsml2pddl.avaliadores.impl;

import org.antlr.stringtemplate.StringTemplate;

import br.usp.each.wsml2pddl.avaliadores.Avaliador;
import br.usp.each.wsml2pddl.constantes.TemplatePDDL;

/**
 * 
 * @author Felipe Pierin <felipe.pierin@yahoo.com.br>
 *
 */
public class AvaliadorDeEstadoInicial implements Avaliador {
	
	private final Avaliador estadoInicial;

	public AvaliadorDeEstadoInicial(final Avaliador estadoInicial) {
		this.estadoInicial = estadoInicial;
	}

	@Override
	public String avalia() {
		final StringTemplate stringTemplate = new StringTemplate(TemplatePDDL.InitState);
		stringTemplate.setAttribute("estadoInicial", obtemEstadoInicialValido());
		return stringTemplate.toString();
	}

	private String obtemEstadoInicialValido() {
		return (estadoInicial != null)? estadoInicial.avalia(): "(clear)";
	}

}
