package br.usp.each.wsml2pddl.avaliadores;

import java.util.Collections;
import java.util.List;
import java.util.Map;

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
		final StringTemplate stringTemplate = new StringTemplate(TemplatePDDL.DeclaracaoDeTipos);
		for (final Map.Entry<String, List<String>> entry: classes.entrySet()) {
			stringTemplate.setAttribute("declaracaoDeTipo", novoTipo(entry));
		}
		return stringTemplate.toString();
	}

	private String novoTipo(final Map.Entry<String, List<String>> entry) {
		final StringTemplate stringTemplate = new StringTemplate("$subclasse; separator=\" \"$ - $classe$");
		final List<String> tiposExistentes = entry.getValue();
		Collections.reverse(tiposExistentes);
		stringTemplate.setAttribute("classe", entry.getKey());		
		stringTemplate.setAttribute("subclasse", tiposExistentes);
		return stringTemplate.toString();
	}

}
