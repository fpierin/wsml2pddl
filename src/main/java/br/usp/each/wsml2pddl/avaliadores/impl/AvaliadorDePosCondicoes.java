package br.usp.each.wsml2pddl.avaliadores.impl;

import br.usp.each.wsml2pddl.avaliadores.Avaliador;


/**
 * 
 * @author Felipe Pierin <felipe.pierin@yahoo.com.br>
 *
 */
public class AvaliadorDePosCondicoes implements Avaliador {

	private final Avaliador posCondicoes;

	public AvaliadorDePosCondicoes(final Avaliador posCondicoes) {
		this.posCondicoes = posCondicoes;
	}
	
	@Override
	public String avalia() {
		return posCondicoes.avalia() ;
	}

}
