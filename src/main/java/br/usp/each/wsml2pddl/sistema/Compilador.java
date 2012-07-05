package br.usp.each.wsml2pddl.sistema;

import java.io.File;

/**
 * 
 * @author Felipe Pierin <felipe.pierin@yahoo.com.br>
 *
 */
public interface Compilador {
	
	String compila(File arquivo);
	
	String compila(String cadeiaDePalavras);

}
