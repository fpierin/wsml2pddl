package br.usp.each.wsml2pddl.avaliadores.impl;

import br.usp.each.wsml2pddl.avaliadores.Avaliador;


/**
 * 
 * @author Felipe Pierin <felipe.pierin@yahoo.com.br>
 *
 */
public class AvaliadorDeVariavel implements Avaliador {

	private final Avaliador variavel;

	public AvaliadorDeVariavel(final Avaliador variavel) {
		this.variavel = variavel;
	}

	@Override
	public String avalia() {
		return "?" + variavel.avalia();
	}

}
