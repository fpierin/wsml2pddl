package br.usp.each.wsml2pddl.avaliadores;

import org.antlr.stringtemplate.StringTemplate;

import br.usp.each.wsml2pddl.constantes.TemplatePDDL;
import br.usp.each.wsml2pddl.modelo.avaliadores.Avaliador;

public class AvaliadorDeProblema implements Avaliador {

	private final Avaliador problema;
	private final Avaliador objetivo;
	private final Avaliador dominio;
	private final Avaliador objetos;
	private final Avaliador estadoInicial;
	private final Avaliador requerimentos;

	@Override
	public String avalia() {
		final StringTemplate stringTemplate = new StringTemplate(TemplatePDDL.Problema);
		stringTemplate.setAttribute("problema", problema.avalia());
		stringTemplate.setAttribute("requerimentos", requerimentos.avalia());		
		stringTemplate.setAttribute("dominio", dominio.avalia());
		stringTemplate.setAttribute("objetos", objetos.avalia());
		stringTemplate.setAttribute("estadoInicial", estadoInicial.avalia());		
		stringTemplate.setAttribute("objetivo", objetivo.avalia());
		return stringTemplate.toString();
		
	}

	public AvaliadorDeProblema(final Avaliador problema, final Avaliador requerimentos, final Avaliador dominio, 
			final Avaliador objetos, final Avaliador estadoInicial, final Avaliador objetivo) {
		this.problema = problema;
		this.requerimentos = requerimentos;
		this.dominio = dominio;
		this.objetos = objetos;
		this.estadoInicial = estadoInicial;
		this.objetivo = objetivo;
	}

}
