package br.usp.each.wsml2pddl.avaliadores;

import org.antlr.stringtemplate.StringTemplate;

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
		return  classePossuiPropriedades()?  classeComPropriedades(): classeSemPropriedades();
	}

	private boolean classePossuiPropriedades() {
		return (propriedades != null);
	}

	private String classeSemPropriedades() {
		final String nomeDaClasse = classe.avalia();
		final String nomeDaVariavelDaClasse = "?" + nomeDaClasse.toLowerCase();
		return "(" + nomeDaVariavelDaClasse + " " + nomeDaClasse + ")";
	}
	private String classeComPropriedades() {
		final String nomeDaClasse = classe.avalia();
		final String variavelDaClasse = "?" + nomeDaClasse.toLowerCase();
		final StringTemplate stringTemplate = new StringTemplate(propriedades.avalia());
		stringTemplate.setAttribute("classe", variavelDaClasse);
		return "(" + variavelDaClasse + " " + nomeDaClasse + ")" + stringTemplate.toString();		
	}

}
