package br.usp.each.wsml2pddl.avaliadores;

import br.usp.each.wsml2pddl.modelo.avaliadores.Avaliador;

public class AvaliadorDeClasse implements Avaliador {

	private final Avaliador nomeDaClasse;
	private final Avaliador propriedades;

	public AvaliadorDeClasse(final Avaliador classe, final Avaliador propriedades) {
		this.nomeDaClasse = classe;
		this.propriedades = propriedades;
	}

	@Override
	public String avalia() {
//		return "(" + "?" + nomeDaClasse.avalia().toLowerCase() + " " + nomeDaClasse.avalia() + ")" + "(x " + propriedades.avalia() + ")";
		return "(x " + propriedades.avalia() + ")";		
//		return "(" + "?" + nomeDaClasse.avalia().toLowerCase() + " " + nomeDaClasse.avalia() + ")";		
	}

}
