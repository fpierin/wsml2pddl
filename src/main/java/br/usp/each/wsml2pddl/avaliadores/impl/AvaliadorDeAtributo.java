package br.usp.each.wsml2pddl.avaliadores.impl;

import br.usp.each.wsml2pddl.avaliadores.Avaliador;


/**
 * 
 * @author Felipe Pierin <felipe.pierin@yahoo.com.br>
 *
 */
public class AvaliadorDeAtributo implements Avaliador {

	private final Avaliador atributo;
	private final Avaliador valor;

	public AvaliadorDeAtributo(final Avaliador atributo, final Avaliador valor) {
		this.atributo = atributo;
		this.valor = valor;
	}

	@Override
	public String avalia() {
		return "(" + atributo.avalia() + " " + valor.avalia() + ")";
	}

}
