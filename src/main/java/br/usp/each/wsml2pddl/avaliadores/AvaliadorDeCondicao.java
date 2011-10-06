package br.usp.each.wsml2pddl.avaliadores;

import br.usp.each.wsml2pddl.modelo.avaliadores.Avaliador;

public class AvaliadorDeCondicao implements Avaliador {

	private final Avaliador condicao;
	private final String atributo;
	private final String valor;

	public AvaliadorDeCondicao(final Avaliador condicao, final String atributo, final String valor) {
		this.condicao = condicao;
		this.atributo = atributo;
		this.valor = valor;
	}

	@Override
	public String avalia() {
		String avaliacaoDeCondicao = condicao.avalia();
		avaliacaoDeCondicao = avaliacaoDeCondicao.replace("$" + atributo + "$", valor);
		return avaliacaoDeCondicao;
	}

}
