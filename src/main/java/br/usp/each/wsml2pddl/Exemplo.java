package br.usp.each.wsml2pddl;

import java.io.File;

import br.usp.each.wsml2pddl.sistema.Compilador;
import br.usp.each.wsml2pddl.sistema.impl.CompiladorWsmlPDDL;

/**
 * 
 * @author Felipe Pierin <felipe.pierin@yahoo.com.br>
 * 
 */
public class Exemplo {

	public static void main(final String[] args) {

		final Compilador compilador = new CompiladorWsmlPDDL();
		System.out.println("\n\nRealizando tradução de um goal WSML para um problema PDDL\n\n");
		final File arquivo = new File("src/main/resources/goal.wsml");
		final String traducao = compilador.compila(arquivo);
		System.out.println(traducao);

		final File arquivo2 = new File("src/main/resources/ontologia.wsml");
		final String traducao2 = compilador.compila(arquivo2);
		System.out.println(traducao2);

	}

}
