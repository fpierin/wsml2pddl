package br.usp.each.wsml2pddl.avaliadores;

import java.util.List;

import org.antlr.stringtemplate.StringTemplate;

import br.usp.each.wsml2pddl.constantes.TemplatePDDL;
import br.usp.each.wsml2pddl.modelo.avaliadores.Avaliador;

public class AvaliadorDePredicados implements Avaliador {

	private final List<Avaliador> predicados;

	public AvaliadorDePredicados(final List<Avaliador> predicados) {
		this.predicados = predicados;
	}

	@Override
	public String avalia() {
		final StringTemplate stringTemplate = new StringTemplate(TemplatePDDL.Predicados);
		for (final Avaliador predicado: predicados){
			stringTemplate.setAttribute("predicado", predicado.avalia());
		}
		return stringTemplate.toString();
	}

}
