package br.usp.each.wsml2pddl.avaliadores;

import br.usp.each.wsml2pddl.modelo.avaliadores.Avaliador;

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
