package br.usp.each.wsml2pddl.avaliadores;

import br.usp.each.wsml2pddl.modelo.avaliadores.Avaliador;

public class AvaliadorDePropriedade implements Avaliador {

	final Avaliador propriedade;
	
	public AvaliadorDePropriedade(final Avaliador propriedade) {
		this.propriedade = propriedade;
	}

	@Override
	public String avalia() {
		 return "(tttttttt " + propriedade.avalia()  +" )";
	}

}
