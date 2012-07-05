package br.usp.each.wsml2pddl.avaliadores.impl;

import org.antlr.stringtemplate.StringTemplate;

import br.usp.each.wsml2pddl.avaliadores.Avaliador;
import br.usp.each.wsml2pddl.constantes.TemplatePDDL;

/**
 * 
 * @author Felipe Pierin <felipe.pierin@yahoo.com.br>
 *
 */
public class AvaliadorDeRequerimentos implements Avaliador {


	public AvaliadorDeRequerimentos() {
	}
	
	@Override
	public String avalia() {
		final StringTemplate stringTemplate = new StringTemplate(TemplatePDDL.Requerimentos);
		stringTemplate.setAttribute("requerimentos", ":adl :typing");
		return stringTemplate.toString();
	}

}
