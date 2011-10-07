package br.usp.each.wsml2pddl.avaliadores;

import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.antlr.stringtemplate.StringTemplate;

import br.usp.each.wsml2pddl.constantes.TemplatePDDL;
import br.usp.each.wsml2pddl.modelo.avaliadores.Avaliador;

public class AvaliadorDeTipos implements Avaliador {
	
	private final Map<String, List<String>> classes;

	public AvaliadorDeTipos(final Map<String, List<String>> classes) {
		this.classes = classes;
	}

	@Override
	public String avalia() {
		String tiposEncontrados = "";
		for (final Map.Entry<String, List<String>> entry: classes.entrySet()) {
			tiposEncontrados =  obterTipoPDDL(entry) + "\n" + tiposEncontrados;
		}
		
		final StringTemplate stringTemplate = new StringTemplate();
		stringTemplate.setTemplate(TemplatePDDL.DeclaracaoDeTipos);
		stringTemplate.setAttribute("declaracaoDeTipos", tiposEncontrados);
		return stringTemplate.toString();
	}

	private String obterTipoPDDL(final Entry<String, List<String>> entry) {
		String tipo = "- " + entry.getKey();
		final List<String> subClasses = entry.getValue();		
		for(final String subClasse: subClasses){
			tipo = subClasse + " " + tipo;
		}
		return tipo;
	}

}
