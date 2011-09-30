package br.usp.each.wsml2pddl.constantes;

public class TemplatePDDL {

	public static final String DocumentoPDDL = 
			"(define ($dominio$)" + "\n" +
			"    $goal$" + "\n" +
			")";
	
	public static final String GOAL = 
			"(:goal" + "\n" +
			"    $goals$" + "\n" +
			")";
	
	public static final String AND = 
		"(and $atributo1$" + "\n" +
		"     $atributo2$" + ")";
	
}
