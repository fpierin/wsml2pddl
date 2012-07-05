package br.usp.each.wsml2pddl.avaliadores.impl;

import org.antlr.stringtemplate.StringTemplate;

import br.usp.each.wsml2pddl.avaliadores.Avaliador;


/**
 * 
 * @author Felipe Pierin <felipe.pierin@yahoo.com.br>
 *
 */
public class AvaliadorDePredicado implements Avaliador {

	private final Avaliador classe;
	private final Avaliador propriedade;
	private final Avaliador classeDaPropriedade;


	public AvaliadorDePredicado(final Avaliador classe) {
		this.classe = classe;
		this.propriedade = null;
		this.classeDaPropriedade = null;		
	}	
	
	public AvaliadorDePredicado(final Avaliador classe, final Avaliador propriedade, final Avaliador classeDaPropriedade) {
		this.classe = classe;
		this.propriedade = propriedade;
		this.classeDaPropriedade = classeDaPropriedade;
	}

	@Override
	public String avalia() {
		final String template = ehUmaClasse()? "($classePai$ $variavelPai$)": 
			"($propriedade$ $variavelPai$ - $classePai$ $variavelFilha$ - $classeFilha$)";
		final StringTemplate stringTemplate = new StringTemplate(template);
		final String classePai = classe.avalia();
		final String variavelPai = "?" + classePai.toLowerCase();
		stringTemplate.setAttribute("classePai", classePai);
		stringTemplate.setAttribute("variavelPai", variavelPai);
		if (!ehUmaClasse()){
			final String classeFilha = classeDaPropriedade.avalia();
			final String variavelFilha = "?" + classeFilha.toLowerCase();
			stringTemplate.setAttribute("propriedade", propriedade.avalia());			
			stringTemplate.setAttribute("variavelFilha", variavelFilha);
			stringTemplate.setAttribute("classeFilha", classeFilha);			
		}
		return stringTemplate.toString();
	}

	private boolean ehUmaClasse() {
		return (propriedade == null) || (classeDaPropriedade == null);
	}
}