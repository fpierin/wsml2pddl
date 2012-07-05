package br.usp.each.wsml2pddl.avaliadores.impl;

import br.usp.each.wsml2pddl.avaliadores.Avaliador;


/**
 * 
 * @author Felipe Pierin <felipe.pierin@yahoo.com.br>
 *
 */
public class AvaliadorDeClasse implements Avaliador {

	private final Avaliador classe;
	private final Avaliador propriedades;

	public AvaliadorDeClasse(final Avaliador classe, final Avaliador propriedades) {
		this.classe = classe;
		this.propriedades = propriedades;
	}

	@Override
	public String avalia() {
		final String nomeDaClasse = classe.avalia().trim();
		final String variavelDaClasse = "?" + nomeDaClasse.toLowerCase();
		final String regiaoDeClasse = "(" + variavelDaClasse + " " + nomeDaClasse + ")";
		
		if (propriedades != null){
			String declaracaoDePropriedades = null;
			declaracaoDePropriedades = propriedades.avalia();
			declaracaoDePropriedades = declaracaoDePropriedades.replace("$classe$", variavelDaClasse);
			return regiaoDeClasse + "\n" + declaracaoDePropriedades;			
		}
		
		return regiaoDeClasse;		
	}

}
