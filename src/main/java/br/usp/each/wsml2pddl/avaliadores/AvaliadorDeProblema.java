package br.usp.each.wsml2pddl.avaliadores;

import br.usp.each.wsml2pddl.modelo.avaliadores.Avaliador;

public class AvaliadorDeProblema implements Avaliador {

	final Avaliador nomeDoProblema;
	
	public AvaliadorDeProblema(final Avaliador nomeDoProblema) {
		this.nomeDoProblema = nomeDoProblema;
	}

	@Override
	public String avalia() {
		 return "problem www-goal-problem-" + nomeDoProblema.avalia();
	}

}
