package br.usp.each.wsml2pddl.avaliadores;

import org.antlr.stringtemplate.StringTemplate;

import br.usp.each.wsml2pddl.modelo.avaliadores.Avaliador;

public class AvaliadorPDDL implements Avaliador {

	private final Avaliador dominio;
	private final Avaliador goal;

	@Override
	public String avalia() {
		final String estruturaDoDocumentoPDDL = 
			  "(define ($dominio$)" + "\n" +
			  "  $goal$" + "\n" +
			  ")";
		final StringTemplate stringTemplate = new StringTemplate(estruturaDoDocumentoPDDL);
		stringTemplate.setAttribute("dominio", dominio.avalia());
		stringTemplate.setAttribute("goal", goal.avalia());		
		
		return stringTemplate.toString();
		
	}

	public AvaliadorPDDL(final Avaliador dominio, final Avaliador goal) {
		this.dominio = dominio;
		this.goal = goal;
	}

}
