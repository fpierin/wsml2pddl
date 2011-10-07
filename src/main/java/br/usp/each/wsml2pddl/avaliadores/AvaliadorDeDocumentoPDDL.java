package br.usp.each.wsml2pddl.avaliadores;

import org.antlr.stringtemplate.StringTemplate;

import br.usp.each.wsml2pddl.constantes.TemplatePDDL;
import br.usp.each.wsml2pddl.modelo.avaliadores.Avaliador;

public class AvaliadorDeDocumentoPDDL implements Avaliador {
	
	private final Avaliador documento;

	public AvaliadorDeDocumentoPDDL(final Avaliador documento) {
		this.documento = documento;
	}

	@Override
	public String avalia() {
		final StringTemplate stringTemplate = new StringTemplate(TemplatePDDL.Documento);
		stringTemplate.setAttribute("declaracoes", documento.avalia());
		return stringTemplate.toString();
	}

}
