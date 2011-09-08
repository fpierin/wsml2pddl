package br.usp.each.wsml2pddl.gramaticas;

import org.antlr.runtime.ANTLRStringStream;
import org.antlr.runtime.CharStream;
import org.antlr.runtime.RecognitionException;
import org.antlr.runtime.TokenRewriteStream;

public class Teste {

	private static final String exemploDeWsmlGoal = 
			"goal obterCidadaniaPeruana\n" +
					"\tcapability\n" +
					"\t\teffect\n" +
					"\t\t\tdefinedBy\n" +
					"\t\t\t\t?temCidadania memberOf peruana.";

	public static void main(final String[] args) throws RecognitionException {
		
		final CharStream charStream = new ANTLRStringStream(exemploDeWsmlGoal);
		final WsmlLexer lexer = new WsmlLexer(charStream);
		
		TokenRewriteStream tokenRewriteStream = new TokenRewriteStream(lexer);
		WsmlParser wsmlParser = new WsmlParser(tokenRewriteStream);
		
		wsmlParser.goal();
		System.out.println(goal);
		
//		final TokenStream input = new CommonTokenStream(lexer); 
//		final WsmlParser wsmlParser = new WsmlParser(input);
//		StringTemplate st = new s
//		System.out.println(wsmlParser.goal()); 
	}

}
