package br.usp.each.wsml2pddl.avaliadores;

import br.usp.each.wsml2pddl.modelo.avaliadores.Avaliador;

public class AvaliadorDeObjetos implements Avaliador {
	
	private final Avaliador avaliador;

	public AvaliadorDeObjetos(final Avaliador avaliador) {
		this.avaliador = avaliador;
	}

	@Override
	public String avalia() {
		return "(:objects " + avaliador.avalia() + ")";
	}

}
