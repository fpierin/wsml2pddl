package br.usp.each.wsml2pddl.avaliadores;

import br.usp.each.wsml2pddl.modelo.avaliadores.Avaliador;

public class AvaliadorDeClasse implements Avaliador {

	private final Avaliador nomeDaClasse;
	private final Avaliador propriedades;

	public AvaliadorDeClasse(final Avaliador nomeDaClasse, final Avaliador propriedades) {
		this.nomeDaClasse = nomeDaClasse;
		this.propriedades = propriedades;
	}

	@Override
	public String avalia() {
		return "(" + "?" + nomeDaClasse.avalia().toLowerCase() + " " + nomeDaClasse.avalia() + ")" + "(x" + propriedades.avalia() + ")";
	}

}
