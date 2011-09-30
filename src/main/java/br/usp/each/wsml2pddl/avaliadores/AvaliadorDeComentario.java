package br.usp.each.wsml2pddl.avaliadores;

import br.usp.each.wsml2pddl.modelo.avaliadores.Avaliador;

public class AvaliadorDeComentario implements Avaliador {

	private final Avaliador evaluator;

	public AvaliadorDeComentario(final Avaliador evaluator) {
		this.evaluator = evaluator;
	}

	@Override
	public String avalia() {
		String comentario = evaluator.avalia();
		if (comentario == null){
			return "";
		}
		return "\n;" + comentario.replace("\n", "\n;") + "\n";
	}

}
