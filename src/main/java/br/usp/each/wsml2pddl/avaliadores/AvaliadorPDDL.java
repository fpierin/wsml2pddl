package br.usp.each.wsml2pddl.avaliadores;

import org.antlr.stringtemplate.StringTemplate;

import br.usp.each.wsml2pddl.constantes.TemplatePDDL;
import br.usp.each.wsml2pddl.modelo.avaliadores.Avaliador;

public class AvaliadorPDDL implements Avaliador {

	private final Avaliador dominio;
	private final Avaliador goal;
	private final Avaliador domain;
	private final Avaliador objects;
	private final Avaliador initState;
	private final Avaliador requirements;

	@Override
	public String avalia() {
		final StringTemplate stringTemplate = new StringTemplate(TemplatePDDL.DocumentoPDDL);
		stringTemplate.setAttribute("dominio", dominio.avalia());
		stringTemplate.setAttribute("requirements", requirements.avalia());		
		stringTemplate.setAttribute("domain", domain.avalia());
		stringTemplate.setAttribute("objects", objects.avalia());
		stringTemplate.setAttribute("initState", initState.avalia());		
		stringTemplate.setAttribute("goal", goal.avalia());
		return stringTemplate.toString();
		
	}

	public AvaliadorPDDL(final Avaliador dominio, final Avaliador requirements, final Avaliador domain, 
			final Avaliador objects, final Avaliador initState, final Avaliador goal) {
		this.dominio = dominio;
		this.requirements = requirements;
		this.domain = domain;
		this.objects = objects;
		this.initState = initState;
		this.goal = goal;
	}

}
