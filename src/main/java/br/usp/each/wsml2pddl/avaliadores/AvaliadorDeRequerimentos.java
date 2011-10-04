package br.usp.each.wsml2pddl.avaliadores;

import org.antlr.stringtemplate.StringTemplate;

import br.usp.each.wsml2pddl.constantes.TemplatePDDL;
import br.usp.each.wsml2pddl.modelo.avaliadores.Avaliador;

public class AvaliadorDeRequerimentos implements Avaliador {


	public AvaliadorDeRequerimentos() {
	}
	
	@Override
	public String avalia() {
		final StringTemplate stringTemplate = new StringTemplate(TemplatePDDL.Requirements);
		stringTemplate.setAttribute("requirements", ":strips :existential-preconditions");
		return stringTemplate.toString();
	}

}
