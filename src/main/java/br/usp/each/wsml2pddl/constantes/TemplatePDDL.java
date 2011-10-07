package br.usp.each.wsml2pddl.constantes;

public class TemplatePDDL {
	
	public static final String Documento = 
		"(define $declaracoes$)";	

	public static final String Dominio = 
		"(domain $dominio$)\n" +
		"$if(requerimentos)$" +
		"    $requerimentos$" + "\n\n" +
		"$endif$"+
		"$if(extensoes)$" +
		"    $extensoes$" + "\n\n" +
		"$endif$"+
		"$if(tipos)$" +
		"    $tipos$" + "\n\n" +
		"$endif$" +
		"$if(predicados)$" +
		"    $predicados$" + "\n\n" +
		"$endif$";				

	public static final String Problema = 
		"(problem $problema$)\n" +
		"$if(requerimentos)$" +
		"    $requerimentos$" + "\n\n" +
		"$endif$"+
		"$if(dominio)$" +
		"    $dominio$" + "\n\n" +
		"$endif$"+
		"$if(estadoInicial)$" +
		"    $estadoInicial$" + "\n\n" +
		"$endif$"+
		"$if(objetivo)$" +
		"    $objetivo$" + "\n\n" +
		"$endif$";		

	public static final String Requerimentos = 
		"(:requirements $requerimentos$)";	

	public static final String DeclaracaoDeTipos = 
		"(:types $declaracaoDeTipo; separator=\"\n            \"$)";
	
	public static final String Predicados = 
		"(:predicates $predicado; separator=\"\n            \"$)";	
	
	public static final String DeclaracaoDeDominio = 
		"(:domain www-goal-domain-$dominio$)";
	
	public static final String Objetos = 
		"(:objects $objetos$)";	

	public static final String InitState = 
		"(:init $estadoInicial$)";	
	
	public static final String Goal = 
		"(:goal $objetivo$)";
	
	public static final String And = 
		"(and $atributo1$" + "\n" +
		"     $atributo2$)";
	
	public static final String Exists = 
		"(exists $condicao$)";
	
	public static final String Negation = 
		"(not $condicao$)";


}
