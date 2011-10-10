package br.usp.each.wsml2pddl.modelo.sistema;

import java.io.File;


public interface Compilador {
	
	String compila(File arquivo);
	
	String compila(String cadeiaDePalavras);

}
