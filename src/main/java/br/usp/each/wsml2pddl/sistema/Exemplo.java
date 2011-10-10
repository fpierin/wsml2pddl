package br.usp.each.wsml2pddl.sistema;

import java.io.File;

import br.usp.each.wsml2pddl.modelo.sistema.Compilador;

public class Exemplo {

	public static void main(final String[] args) {
		
		final Compilador compilador = new CompiladorWsmlPDDL();
		
		System.out.println("Realizando tradução de ontologia WSML para um dominio PDDL\n\n");			
		System.out.println(compilador.compila(new File("src/main/java/ontologia.wsml")));
		
		System.out.println("\n\nRealizando tradução de um goal WSML para um problema PDDL\n\n");		
		System.out.println(compilador.compila(new File("src/main/java/goal.wsml")));
		
		String texto = "wsmlVariant _\"http://www.wsmo.org/wsml/wsml-syntax/wsml-flight\"" +
				"\nnamespace { dO _\"ontologia.wsml\" }\n" +
				"goal _\"obterTicketDeViagem\"" +
				"\nimportsOntology _\"ontologia.wsml#OntologiaDeViagem\"\n" +
				"capability\n" +
				"postcondition\n" +
				"definedBy\n" +
				"?ticket [ dO#origem hasValue ?origem, dO#destino hasValue ?destino ] memberOf dO#Ticket\n" +
				" and ?origem memberOf dO#SaoPaulo and ?destino memberOf dO#MachuPicchu.";
		System.out.println(compilador.compila(texto ));
		
	}

}
