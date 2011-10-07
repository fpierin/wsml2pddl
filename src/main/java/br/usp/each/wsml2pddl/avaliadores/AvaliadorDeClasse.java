package br.usp.each.wsml2pddl.avaliadores;

import br.usp.each.wsml2pddl.modelo.avaliadores.Avaliador;

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
