package br.usp.each.wsml2pddl.avaliadores;

import br.usp.each.wsml2pddl.modelo.avaliadores.Avaliador;

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
