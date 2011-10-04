package br.usp.each.wsml2pddl.avaliadores;

import br.usp.each.wsml2pddl.modelo.avaliadores.Avaliador;

public class AvaliadorDePropriedade implements Avaliador {

	final Avaliador nomeDoProblema;
	
	public AvaliadorDePropriedade(final Avaliador nomeDoProblema) {
		this.nomeDoProblema = nomeDoProblema;
	}

	@Override
	public String avalia() {
		 return "(tttttttt "+ nomeDoProblema.avalia()  +" )";
	}

}
