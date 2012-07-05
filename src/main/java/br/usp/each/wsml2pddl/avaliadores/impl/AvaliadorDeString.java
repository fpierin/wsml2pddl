package br.usp.each.wsml2pddl.avaliadores.impl;

import br.usp.each.wsml2pddl.avaliadores.Avaliador;


/**
 * 
 * @author Felipe Pierin <felipe.pierin@yahoo.com.br>
 *
 */
public class AvaliadorDeString implements Avaliador {

	private final String string;

	@Override
	public String avalia() {
		return string == null? "" : string;
	}

	public AvaliadorDeString(final String string) {
		this.string = string;
	}
	
	

}
