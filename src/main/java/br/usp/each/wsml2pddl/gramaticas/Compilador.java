package br.usp.each.wsml2pddl.gramaticas;

import java.io.IOException;

import org.antlr.runtime.ANTLRFileStream;
import org.antlr.runtime.CharStream;
import org.antlr.runtime.CommonTokenStream;
import org.antlr.runtime.RecognitionException;
import org.antlr.runtime.TokenStream;
import org.antlr.runtime.tree.CommonTreeNodeStream;

import br.usp.each.wsml2pddl.evaluators.Evaluator;

public class Compilador {

	public static void main(final String[] args) throws RecognitionException, IOException {
		
		final CharStream charStream = new ANTLRFileStream("src/main/java/goal.wsml");
		final WsmlLexer lexer = new WsmlLexer(charStream);
		final TokenStream tokenStream = new CommonTokenStream(lexer);
		final WsmlParser wsmlParser = new WsmlParser(tokenStream);
		
		final CommonTreeNodeStream nodeStream = new CommonTreeNodeStream(wsmlParser.wsml().tree);
		final ProblemTranslator problemTranslator =  new ProblemTranslator(nodeStream);
		final Evaluator evaluator = problemTranslator.evaluator();
		System.out.println(evaluator.evaluate()); 
		
	}

}
