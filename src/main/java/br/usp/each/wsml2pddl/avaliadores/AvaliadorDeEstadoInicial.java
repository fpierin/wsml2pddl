package br.usp.each.wsml2pddl.avaliadores;

import org.antlr.stringtemplate.StringTemplate;

import br.usp.each.wsml2pddl.constantes.TemplatePDDL;
import br.usp.each.wsml2pddl.modelo.avaliadores.Avaliador;

public class AvaliadorDeEstadoInicial implements Avaliador {
	
	private final Avaliador estadoInicial;

	public AvaliadorDeEstadoInicial(final Avaliador estadoInicial) {
		this.estadoInicial = estadoInicial;
	}

	@Override
	public String avalia() {
		final StringTemplate stringTemplate = new StringTemplate(TemplatePDDL.InitState);
		stringTemplate.setAttribute("initState", obtemEstadoInicialValido());
		return stringTemplate.toString();
	}

	private String obtemEstadoInicialValido() {
		return (estadoInicial != null)? estadoInicial.avalia(): "(Clear)";
	}

}
