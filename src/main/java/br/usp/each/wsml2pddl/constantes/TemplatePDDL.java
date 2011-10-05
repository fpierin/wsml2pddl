package br.usp.each.wsml2pddl.constantes;

public class TemplatePDDL {

	public static final String DocumentoPDDL = 
		"(define ($dominio$)" + "\n" +
		"    $requirements$" + "\n" +	
		"    $domain$" + "\n" +
		"    $objects$" + "\n" +					
		"    $initState$" + "\n" +	
		"    $goal$" + "\n" +
		")";

	public static final String Requirements = 
		"(:requirements $requirements$)";	
	
	public static final String Domain = 
		"(:domain www-goal-domain-$domain$)";
	
	public static final String Objects = 
		"(:objects $objects$)";	

	public static final String InitState = 
		"(:init $initState$)";	
	
	public static final String Goal = 
		"(:goal \n" + 
		"    $goals$ \n" +
		")";
	
	public static final String And = 
		"(and \n" + 
		"     $atributo1$$atributo2$\n" +
		")";
	
	public static final String Exists = 
		"(exists $condicao$ \n" +
		")";
	
	public static final String Negation = 
		"(not $condicao$)";	

}
