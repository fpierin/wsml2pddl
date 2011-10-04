package br.usp.each.wsml2pddl.avaliadores;

import br.usp.each.wsml2pddl.modelo.avaliadores.Avaliador;

public class AvaliadorDeClasse implements Avaliador {

	private final Avaliador nomeDaClasse;

	public AvaliadorDeClasse(final Avaliador nomeDaClasse) {
		this.nomeDaClasse = nomeDaClasse;
	}

	@Override
	public String avalia() {
		return null;
	}

}
