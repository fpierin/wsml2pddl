package br.usp.each.wsml2pddl.avaliadores.impl;

import br.usp.each.wsml2pddl.avaliadores.Avaliador;


/**
 * 
 * @author Felipe Pierin <felipe.pierin@yahoo.com.br>
 *
 */
public class AvaliadorDeComentario implements Avaliador {

	private final Avaliador avaliador;

	public AvaliadorDeComentario(final Avaliador evaluator) {
		this.avaliador = evaluator;
	}

	@Override
	public String avalia() {
		String comentario = avaliador.avalia();
		if (comentario == null){
			return "";
		}
		return "\n;" + comentario.replace("\n", "\n;") + "\n";
	}

}
