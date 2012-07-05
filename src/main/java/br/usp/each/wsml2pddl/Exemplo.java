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

		// System.out.println("Realizando tradução de ontologia WSML para um dominio PDDL\n\n");
		// System.out.println(compilador.compila(new
		// File("src/main/java/ontologia.wsml")));

		System.out
				.println("\n\nRealizando tradução de um goal WSML para um problema PDDL\n\n");
		System.out.println(compilador.compila(new File("classpath:goal.wsml")));

	}

}
