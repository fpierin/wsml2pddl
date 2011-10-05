package br.usp.each.wsml2pddl.avaliadores;

import br.usp.each.wsml2pddl.modelo.avaliadores.Avaliador;

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
