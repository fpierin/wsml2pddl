package br.usp.each.wsml2pddl.constantes;

public class TemplatePDDL {

	public static final String DocumentoPDDL = 
		"(define ($dominio$)" + "\n" +
		"    $domain$" + "\n" +
		"    $objects$" + "\n" +					
		"    $initState$" + "\n" +	
		"    $goal$" + "\n" +
		")";

	public static final String InitState = 
		"(:init " + "\n" +
		"    $initState$" + "\n" +
		")";	
	
	public static final String Goal = 
		"(:goal" + "\n" +
		"    $goals$" + "\n" +
		")";
	
	public static final String And = 
		"(and $atributo1$" + "\n" +
		"     $atributo2$)";
	
	public static final String Exists = 
		"(exists $condicao$)";
	
	public static final String Negation = 
		"(not $condicao$)";	

}
