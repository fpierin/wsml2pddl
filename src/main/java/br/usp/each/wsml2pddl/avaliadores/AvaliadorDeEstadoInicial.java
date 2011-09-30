package br.usp.each.wsml2pddl.avaliadores;

import br.usp.each.wsml2pddl.modelo.avaliadores.Avaliador;

public class AvaliadorDeEstadoInicial implements Avaliador {
	
	private final Avaliador avaliador;

	public AvaliadorDeEstadoInicial(final Avaliador avaliador) {
		this.avaliador = avaliador;
	}

	@Override
	public String avalia() {
		return "(:init" + avaliador.avalia() + 
			   "";
	}

}
