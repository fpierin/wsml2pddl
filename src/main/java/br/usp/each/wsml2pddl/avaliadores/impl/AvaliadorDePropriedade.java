package br.usp.each.wsml2pddl.avaliadores.impl;

import br.usp.each.wsml2pddl.avaliadores.Avaliador;


/**
 * 
 * @author Felipe Pierin <felipe.pierin@yahoo.com.br>
 *
 */
public class AvaliadorDePropriedade implements Avaliador {

	final Avaliador propriedade;
	
	public AvaliadorDePropriedade(final Avaliador propriedade) {
		this.propriedade = propriedade;
	}

	@Override
	public String avalia() {
		final String nomeDaPropriedade = propriedade.avalia();
		 return "(" + propriedade.avalia() + " $classe$ $?" + nomeDaPropriedade + "$)";
	}

}
